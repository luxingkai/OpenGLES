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

GLuint LoadShader(GLenum type, const char *shaderSrc);

@interface ViewController () {
    
}

@property (nonatomic, strong) EAGLContext *context;
@property (nonatomic, strong) GLKBaseEffect *effect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    char vShaderStr[] =
//    "#version 300 es                          \n"
//    "layout(location = 0) in vec4 vPosition;  \n"
//    "void main()                              \n"
//    "{                                        \n"
//    "   gl_Position = vPosition;              \n"
//    "}                                        \n";
//
//
//    printf("%d",LoadShader ( GL_VERTEX_SHADER, vShaderStr ));
    
    

    
    
    
    
    
    // Do any additional setup after loading the view.
}

///
// Create a shader object, load the shader source, and
// compile the shader.
//
GLuint LoadShader ( GLenum type, const char *shaderSrc )
{
    GLuint shader;
    GLint compiled;
    
    // Create the shader object
    shader = glCreateShader ( type );
    
    if ( shader == 0 )
    {
        return 0;
    }
    
    // Load the shader source
    glShaderSource ( shader, 1, &shaderSrc, NULL );
    
    // Compile the shader
    glCompileShader ( shader );
    
    // Check the compile status
    glGetShaderiv ( shader, GL_COMPILE_STATUS, &compiled );
    
    if ( !compiled )
    {
        GLint infoLen = 0;
        
        glGetShaderiv ( shader, GL_INFO_LOG_LENGTH, &infoLen );
        
        if ( infoLen > 1 )
        {
            char *infoLog = malloc ( sizeof ( char ) * infoLen );
            
            glGetShaderInfoLog ( shader, infoLen, NULL, infoLog );
            printf("Error compiling shader:\n%s\n",infoLog);
            free ( infoLog );
        }
        
        glDeleteShader ( shader );
        return 0;
    }
    return shader;
}

void Draw(void) {
    
    
    
}



@end
