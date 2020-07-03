//
//  ShaderViewController.m
//  OpenGL_ES Usage
//
//  Created by tigerfly on 2020/7/2.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "ShaderViewController.h"
#import <OpenGLES/ES3/glext.h>
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/gltypes.h>
#import "esUtil.h"

@interface ShaderViewController ()

@property (nonatomic, strong) EAGLContext *context;

@end

@implementation ShaderViewController

GLuint loadShader (GLenum type, const char *shaderSrc);

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    
    [EAGLContext setCurrentContext:self.context];
    
    
#pragma mark -- 着色器语言
    
    char vShaderSrc[] =
    "#version 300 es                        \n"
    "layout(location = 0) in vec3 Positon;  \n"
    "uniform transformBlock                 \n"
    "{                                      \n"
    "   mat4  matViewProj;                  \n"
    "   mat3  matNormal;                    \n"
    "   mat3  matTexGen;                    \n"
    "};                                     \n"
    "layout(shared, column_major) uniform;  \n"
    "void main()                            \n"
    "{                                      \n"
    "                                       \n"
    "}                                      \n"; 
                    
    printf("load shader = %d", loadShader(GL_VERTEX_SHADER, vShaderSrc));
    
#pragma mark -- 着色器对象和程序对象
    
    
#pragma mark -- 统一变量和属性
    
    
#pragma mark -- 着色器编译器
    
    
#pragma mark -- 程序二进制码
    
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark -- GLKViewControllerDelegate

- (void)glkViewControllerUpdate:(GLKViewController *)controller {
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
}



GLuint loadShader (GLenum type, const char *shaderSrc) {
    
    GLuint shader;
    GLint compiled;
    
    shader = glCreateShader(type);
    
    if (shader == 0) {
        return 0;
    }
    
    glShaderSource(shader, 1, &shaderSrc, NULL);
    
    glCompileShader(shader);
    
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);
    
    if (compiled == 0) {
        
        GLint infoLen;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &infoLen);
        
        if (infoLen > 1) {
            char *infoLog = malloc(sizeof(char) *infoLen);
            
            glGetShaderInfoLog(shader, infoLen, NULL, infoLog);
            printf("Error compiled \n%s\n",infoLog);
            free(infoLog);
        }
        glDeleteShader(shader);
        return 0;
    }
    return shader;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
