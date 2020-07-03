//
//  ViewController.m
//  OpenGL_ES Usage
//
//  Created by tiger fly on 2020/3/20.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "ViewController.h"
#import <OpenGLES/gltypes.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
#import <GLKit/GLKit.h>
#include "esUtil.h"

/*
 Compatibility
 ·并非所有之前构建版本的着色器语言都可以使用之后出现的版本。例如attribute和varying qualifiers 在版本1.00出现，但是不能使用版本3.00。然而，版本3.20是版本3.10的超集。
 ·最近版本出现的特性将不能出现和使用在之前的版本中。
 ·连接着色器时出现不同版本那么将会报错。
 ·版本2.0和3.0的API不支持使用版本3.20.
 ·在OpenGL ES 3.x中使用GLSL ES 1.00着色器。可以将可用资源扩展到GLSL ES 1.0中指定的最小值之外。使用这种方法的着色器不一定要在OpenGL ES 2.0实现中运行:类似地，在OpenGL ES 3.2中运行的GLSL ES 3.00着色器也是如此。
 ·在GLSL ES 1.00被用于OpenGL ES 2.0 APIs时，支持行延续和注释中的UTF-8字符是可选的
 。但是，当GLSL ES 1.00着色器被用于OpenGL ES 3.x的api，这两种着色器都需要支持。
 */


struct ESContext
{
    void    *userData;
    
    GLint   width;
    GLint   height;
};
typedef struct ESContext ESContext;

typedef struct
{
    GLuint programObject;
} UserData;

int esMain(ESContext *esContext);
int Init (ESContext *esContext);
void Draw (ESContext *esContext);


@interface ViewController () {
    
    ESContext _esContext;
}

@property (nonatomic, strong) EAGLContext *context;
@property (nonatomic, strong) GLKBaseEffect *effect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    //    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    
    [EAGLContext setCurrentContext:self.context];
    
    
    memset(&_esContext, 0, sizeof(_esContext));
    esMain(&_esContext);
    
    
    // Do any additional setup after loading the view.
}

#pragma mark --

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    _esContext.width = view.drawableWidth;
    _esContext.height = view.drawableHeight;
    
    Draw(&_esContext);
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller {
    
}

- (void)dealloc {
    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && [[self view] window] == nil) {
        self.view = nil;
        [self tearDownGL];
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
}



- (void)tearDownGL {
    
    [EAGLContext setCurrentContext:self.context];
    UserData *userData = _esContext.userData;
    glDeleteProgram(userData->programObject);
}


int esMain(ESContext *esContext) {
    
    esContext->userData = malloc ( sizeof ( UserData ) );
    
    if (!Init(esContext)) {
        return GL_FALSE;
    }
    return GL_TRUE;
}


int Init (ESContext *esContext) {
    
    UserData *userData = esContext->userData;
    
    char vShaderStr[] =
    "#version 300 es                                \n"
    "#define new 10                                 \n"
    "#extension name : warn                         \n"
    "#pragma optimize (on)                          \n"
    "#pragma debug (on)                             \n"
    "layout(location = 0) in vec4 vPosition;        \n"
    "layout(location = 1) in vec3 a_color;          \n"
    "out vec3 v_color;                              \n"
    "void main()                                    \n"
    "{                                              \n"
    "   v_color = a_color;                          \n"
    "   gl_Position = vPosition;                    \n"
    "}                                              \n";
    
    char fShaderStr[] =
    "#version 300 es                                \n"
    "precision mediump float;                       \n"
    "out vec4 fragColor;                            \n"
    "void main()                                    \n"
    "{                                              \n"
    "   fragColor = vec4 (1.0, 1.0, 0.0, 1.0);      \n"
    "}                                              \n";
    
    GLuint vertexShader;
    GLuint fragmentShader;
    GLuint programObject;
    GLint linked;
    
    //Load the vertex/fragment shaders
    vertexShader = esLoadShader(GL_VERTEX_SHADER, vShaderStr);
    fragmentShader = esLoadShader(GL_FRAGMENT_SHADER, fShaderStr);
    
    // Create the program object
    programObject = glCreateProgram();
    
    if (programObject == 0) {
        return 0;
    }
    
    glAttachShader(programObject, vertexShader);
    glAttachShader(programObject, fragmentShader);
    
    // Link the program
    glLinkProgram(programObject);
    
    //Check the link status
    glGetProgramiv(programObject, GL_LINK_STATUS, &linked);
    
    if (!linked) {
        GLint infoLen = 0;
        
        glGetProgramiv(programObject, GL_INFO_LOG_LENGTH, &infoLen);
        
        if (infoLen > 1) {
            char *infoLog = malloc(sizeof(char) *infoLen);
            
            glGetProgramInfoLog(programObject, infoLen, NULL, infoLog);
            printf("Error linking program:\n%s\n",infoLog);
            
            free(infoLog);
        }
        glDeleteProgram(programObject);
        return false;
    }
    
    // Store the program object
    userData->programObject = programObject;
    
    glClearColor(1.0, 1.0, 1.0, 0.0);
    return true;
}

void Draw (ESContext *esContext) {
    
    UserData *userData = esContext->userData;
    GLfloat vVertices[] =
    {
        -0.5f, 0.5f, 0.0f,
        0.5f, 0.5f, 0.0f,
        -0.5f, -0.5f, 0.0f,
        0.5f, -0.5f, 0.0f
    };
    
    //Set the viewport
    glViewport(0, 0, esContext->width, esContext->height);
    
    //Clear the color buffer
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Use the program object
    glUseProgram(userData->programObject);
    
    // Load the vertex data
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, vVertices);
    glEnableVertexAttribArray(0);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
}




@end
