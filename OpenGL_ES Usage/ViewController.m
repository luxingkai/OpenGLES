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

@interface ViewController () {
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    const char *vertexStr = "#version 300 es \n"
    "void main() {                           \n"
    "float foo;                              \n"
    "}                                       \n";
    printf("%s",vertexStr);
    

    
    
    
    // Do any additional setup after loading the view.
}


@end
