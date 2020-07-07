//
//  VertexShaderController.m
//  OpenGL_ES Usage
//
//  Created by tigerfly on 2020/7/3.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "VertexShaderController.h"
#import <OpenGLES/ES3/glext.h>
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/gltypes.h>
#import "esUtil.h"

//GLuint loadShader(GLenum type, const char*str);
@interface VertexShaderController ()

@end

@implementation VertexShaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    char vertexShader[] =
    "#version 300 es                                    \n"
    "main()                                             \n"
    "{                                                  \n"
    "                                                   \n"
    "}                                                  \n";
    
    /*
     顶点着色器可用于传统的基于顶点操作,例如通过矩阵变换位置、计算照明方程式以生成逐顶点的颜色以及生成或者变换纹理坐标。
     */
    
#pragma mark -- 顶点着色器概述
    
    /*
     顶点着色器提供顶点操作的通用可编程方法。
     顶点着色器的输入包括：
     •  属性 -- 用顶点数组提供的逐顶点数据。
     •  统一变量和统一变量缓冲区 -- 顶点着色器使用的不变数据。
     •  采样器 -- 代表顶点着色器使用的纹理的特殊统一变量类型。
     •  着色器程序 -- 顶点着色器程序源代码或者描述在操作顶点的可执行文件。
     顶点着色器的输出称作顶点着色器输出变量。在图元光栅化阶段，为每个生成的片段计算这些变量，并作为片段着色器的输入传入。
     */
    
    /*
     顶点着色器内建变量
     内建变量可以分为特殊变量（顶点着色器输入输出）、统一状态（如深度范围）以及规定最大值（如属性数量、顶点着色器输出变量数量和统一变量数量）的常量。
     
     内建特殊变量：
     OpenGLES 3.0有内建的特殊变量，它们可以作为顶点着色器输入或者在之后成为片段着色器输入的顶点着色器输出，或者片段着色器的输出。
     •  gl_VertexID是一个输入变量，用于保存顶点的整数索引。这个整数变量用highp精度限定符。
     •  gl_InstanceID是一个输入变量，用于保存实例化绘图调用中图元的实例编号。对于常规的绘图调用，该值为0。gl_InstanceID是一个整数型变量，用highp精度限定符声明。
     •  gl_Position用于输出顶点位置的裁剪坐标。该值在裁剪和视口阶段用于执行相应的图元裁剪以及从裁剪坐标到屏幕坐标的顶点位置转换。如果顶点未写入gl_Position，则gl_Position的值未定义。gl_Position是一个浮点变量，用highp精度限定符声明。
     •  gl_PointSize用于写入以像素表示的点精灵尺寸，在渲染点精灵时使用。顶点着色器输出的gl_PointSize值被限定在OpenGL ES3.0实现支持的非平滑点大小范围之内。gl_PointSize是一个浮点变量，用highp精度限定符声明。
     •  gl_FrontFacing是一个特殊变量，但不是由顶点着色器直接写入的，而是根据顶点着色器生成的位置值和渲染的图元类型生成的。
     
     内建统一变量：
     顶点着色器内可用的唯一内建统一状态时窗口坐标中的深度范围。这由内建统一变量名gl_DepthRange给出，该变量声明为
     gl_DepthRangeParameters类型的统一变量。
     struct gl_DepthRangeParameters {
     highp float near; // near z
     highp float far;  // far z
     highp float diff; // far - near
     }
     uniform gl_DepthRangeParameters gl_DepthRange;
     
     内建常量
     const mediump int gl_MaxVertexAttribs              = 16;
     const mediump int gl_MaxVertexUniformVectors       = 256;
     const mediump int gl_MaxVertexOutputVectors        = 16;
     const mediump int gl_MaxVertexTextureImageUnits    = 16;
     const mediump int gl_MaxCombinedTextureImageUnits  = 32;
     •  gl_MaxVertexAttribs是可以指定的顶点属性的最大数量，所有ES3.0实现都支持的最小值为16。
     •  gl_MaxVertexUniformVectors是顶点着色器中可以使用的vec4统一变量项目的最大数量。
     所有ES3.0实现都支持的最小值为256。开发人员可以使用的vec4统一变量项目数量在不同实现和不同顶点着色器中可能不同。例如，有些实现可能将顶点着色器中使用的用户指定字面值计入统一变量限制中。
     •  gl_MaxVertexOutputVectors是输出向量的最大数量 -- 也就是顶点着色器可以输出的vec4项目数量。所有ES3.0实现都支持的最小值是16个vec4项目。
     •  gl_NaxVertexTextureImageUnits 是顶点着色器中可用的纹理单元的最大数量。最小值为16。
     •  gl_MaxCombinedTextureImageUnits是顶点和片段着色器中可用纹理单元最大数量的总和。最小值为32。
     */
    GLint maxVertexAttribs, maxVertexUniforms, maxVaryings;
    GLint maxVertexTextureUnits, maxCombinedTextureUnits;
    glGetIntegerv(GL_MAX_VERTEX_ATTRIBS, &maxVertexAttribs);
    glGetIntegerv(GL_MAX_VERTEX_UNIFORM_VECTORS, &maxVertexUniforms);
    glGetIntegerv(GL_MAX_VARYING_VECTORS, &maxVaryings);
    glGetIntegerv(GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS, &maxVertexTextureUnits);
    glGetIntegerv(GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &maxCombinedTextureUnits);
    printf("maxVertexAttribs %d\n",maxVertexAttribs);
    printf("maxVertexUniforms %d\n",maxVertexUniforms);
    printf("maxVaryings %d\n",maxVaryings);
    printf("maxVertexTextureUnits %d\n",maxVertexTextureUnits);
    printf("maxCombinedTextureUnits %d\n",maxCombinedTextureUnits);
    
    /*
     精度限定符
     精度限定符可用于指定任何基于浮点数或者整数的变量的精度。指定精度的关键字是lowp、mediump和highp。
     highp vec4     position;
     out lowp vec4  color;
     mediump float  specularExp;
     highp int      oneConstant;
     
     除了精度限定符，还可以使用默认精度。也就是说，如果变量声明时没有使用精度限定符，它将采用该类型的默认精度。默认精度限定符采用如下语法，在顶点或者片段着色器的开始出指定：
     precision  highp float;
     precision  mediump int;
     为float指定的精度将用作所有基于浮点数变量的默认精度。同样，为int指定的精度将用作所有基于整数变量的默认精度。
     
     */
    
    /*
     顶点着色器中的统一变量限制数量
     gl_MaxVertexUniformVectors描述了可以用于顶点着色器的统一变量的最大数量。任何兼容的OpenGL ES3.0实现必须支持的gl_MaxVertexUniformVectors最小值为256个vec4项目。统一变量存储用于存储如下变量：
     •用统一变量限定符声明的变量
     •常数变量
     •字面值
     •特定于实现的常量
     
     顶点着色器中使用的统一变量和用const限定符声明的变量、字面值和特定于实现的常量必须按照打包规则于glMaxVertexUniformVectors相匹配。如果不匹配，顶点着色器无法编译。开发人员可以应用打包规制，确定存储统一变量、常数变量和字面值所需的统一变量存储总数。然而，确定特定于实现的常量数量是不可能的，因为这个值不仅在不同实现中不同，而且取决中顶点着色器使用的内建着色语言函数。通常，特定的常量在使用内建超越函数时是必需的。
     至于字面值，OpenGL ES3.0着色语言规范规定不做任何常量传播。结果是，同一个字面值的多个实例将被多次计算。可以理解的是，在顶点着色器中使用字面值（如0.0和1.0）更容易，但是我们建议尽可能避免采用这种技术，应该声明相应的常数变量代替字面值。这种方法避免将同一个字面值计算多次。在那种情况下，如果顶点统一变量存储需求超过了实现所能支持的存储量，可能导致顶点着色器无法编译。
     */
    
    char vShaderStr[] =
    "#version 300 es                                        \n"
    "#define NUM_TEXTURES 2                                 \n"
    "uniform mat4 tex_matrix[NUM_TEXTURES];                 \n"
    "uniform bool enable_tex[NUM_TEXTURES];                 \n"
    "uniform bool enable_tex_matrix[NUM_TEXTURES];          \n"
    "in vec4 a_texcoord0;                                   \n"
    "in vec4 a_texcoord1;                                   \n"
    "out vec4 v_texcoord[NUM_TEXTURES];                     \n"
    "void main()                                            \n"
    "{                                                      \n"
    "   v_txcoord[0] = vec4[0.0, 0.0, 0.0, 1.0];            \n"
    "   if(enable_tex[0])                                   \n"
    "   {                                                   \n"
    "       if(enable_tex_matrix[0])                        \n"
    "           v_texcoord[0] = tex_matrix[0] * a_texcoord0;\n"
    "       else                                            \n"
    "           v_texcoord[0] = a_texcoord0;                \n"
    "   }                                                   \n"
    "}                                                      \n";
    
    printf("%d",esLoadShader(GL_VERTEX_SHADER, vShaderStr));
    
    
#pragma mark -- 顶点着色器示例
    
    /*
     • 用一个矩阵变换顶点位置
     • 进行照明计算
     • 纹理坐标生成
     • 顶点朦皮
     • 用纹理查找值代替顶点位置
     
     */
    
}

//GLuint loadShader(GLenum type, const char*str) {
//
//    GLuint shader;
//    GLint compiled;
//
//    shader = glCreateShader(type);
//    if (shader == 0) {
//        return 0;
//    }
//
//    glShaderSource(shader, 1, &str, NULL);
//
//    glCompileShader(shader);
//
//    glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);
//
//    if (compiled == 0) {
//
//        GLint infoLen = 0;
//        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &infoLen);
//
//        if (infoLen > 1) {
//            char *infoLog = malloc(sizeof(char) *infoLen);
//
//            glGetShaderInfoLog(shader, infoLen, NULL, infoLog);
//            printf("error: %s",infoLog);
//            glDeleteShader(shader);
//            free(infoLog);
//        }
//        return 0;
//    }
//    return shader;
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
