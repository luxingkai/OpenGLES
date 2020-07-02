//
//  ShaderViewController.m
//  OpenGL_ES Usage
//
//  Created by tigerfly on 2020/7/2.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "ShaderViewController.h"
#import "esUtil.h"

@interface ShaderViewController ()

@property (nonatomic, strong) EAGLContext *context;

@end

@implementation ShaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    
    [EAGLContext setCurrentContext:self.context];
    
    glClearColor(1.0, 1.0, 1.0, 0.0);
    
    char vShaderSrc[] =
    "#version 300 es                        \n"
    "layout(location = 0) in vec3 Positon;  \n"
    "void main()                            \n"
    "{                                      \n"
    "                                       \n"
    "}                                      \n";
    
    esLoadShader(GL_VERTEX_SHADER, vShaderSrc);
    
    
    
    
    
    
    // Do any additional setup after loading the view.
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
