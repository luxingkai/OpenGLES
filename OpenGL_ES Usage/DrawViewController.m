//
//  DrawViewController.m
//  OpenGL_ES Usage
//
//  Created by tigerfly on 2020/7/3.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "DrawViewController.h"
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
#import <OpenGLES/gltypes.h>

@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
#pragma mark -- 图元
    
    /*
     图元可以用OpenGL ES 中的glDrawArrays、glDrawElements、glDrawRangeElements、glDrawArraysInstanced和glDrawElementsInstanced命令绘制的几何形状对象。图元由一组表示顶点位置的顶点描述。其他如颜色、纹理坐标和几何法线等信息也作为通用属性与每个顶点关联。
     OpenGL ES 3.0可以绘制如下图元：
     ●  三角形
     ●  直线
     ●  点精灵
     */
//    glDrawArrays(<#GLenum mode#>, <#GLint first#>, <#GLsizei count#>)
//    glDrawElements(<#GLenum mode#>, <#GLsizei count#>, <#GLenum type#>, <#const GLvoid *indices#>)
//    glDrawRangeElements(<#GLenum mode#>, <#GLuint start#>, <#GLuint end#>, <#GLsizei count#>, <#GLenum type#>, <#const GLvoid *indices#>)
//    glDrawArraysInstanced(<#GLenum mode#>, <#GLint first#>, <#GLsizei count#>, <#GLsizei instancecount#>)
//    glDrawElementsInstanced(<#GLenum mode#>, <#GLsizei count#>, <#GLenum type#>, <#const GLvoid *indices#>, <#GLsizei instancecount#>)
    
    /*
        三角形
        三角形代表着描述由3D应用程序渲染的几何形状时最常用的方法。OpenGL ES支持的三角形图元由GL_TRIANGLES、GL_TRIANGLES_STRIP和GL_TRIANGLE_FAN。
     GL_TRIANGLES 绘制一系列单独的三角形。
     GL_TRIANGLE_STRIP 绘制一系列相互连接的三角形。
     GL_TRIANGLE_FAN   绘制一系列相连的三角形。
     */
    
    /*
     直线
     OpenGLES   支持的直线图元有GL_LINES、GL_LINE_STRIP和GL_LINE_LOOP。
     GL_LINES   绘制一系列不相连的线段
     GL_LINE_STRIP  绘制一系列相连的线段。
     GL_LINE_LOOP   绘制一系列相连的线段。
     
     线段宽度用glLineWidth  API调用指定。
     glLineWidth(<#GLfloat width#>)
     width  指定线宽，以像素数表示；默认宽度为1.0
     glLineWidth 指定的宽度将受限于OpenGL ES3.0实现所支持的线宽范围。
     */
    GLfloat lineWidthRange[2];
    glGetFloatv(GL_ALIASED_LINE_WIDTH_RANGE, lineWidthRange);
    printf("%f\n",lineWidthRange[0]);
    
    
    /*
     点精灵
     
     OpenGL ES 支持的点精灵图元是GL_POINTS。点精灵对指定的每个顶点绘制。点精灵通常用于将粒子效果当作点而非正方形绘制，从而实现高效渲染。点精灵是指定位置和半径的屏幕对齐的正方形，位置描述正方形的中心，半径用于计算描述点精灵的正方形的4个坐标。
     gl_PointSize是可用于在顶点着色器中输出点半径的内建变量。与点图元相关的顶点着色器输出gl_PointSize很重要,否则，点尺寸值被视为未定义，很可能会造成绘图错误。
     
     顶点着色器输出的gl_PointSize受到OpenGL ES 3.0实现所支持的非平滑点尺寸范围的限制。
     GLfloat     pointSizeRange[2];
     glGetFloatv(GL_ALIASED_POINT_SIZE_RANGE, pointSizeRange);
     
     默认情况下，OpenGL ES 3.0将窗口原点（0，0）描述为（左，下）区域。但是，点精灵的点坐标原点是（左，上）
     gl_PointCoord是只能在渲染图元为点精灵时用于片段着色器内部的内建变量。它用mediump精度限定符声明为一个vec2变量。
     随着我们从左侧移到右侧，从顶部移到底部，赋予gl_PointCoord的值从0～1变化
     */
    GLfloat     pointSizeRange[2];
    glGetFloatv(GL_ALIASED_POINT_SIZE_RANGE, pointSizeRange);
    printf("%f\n",pointSizeRange[1]);
    
    
#pragma mark -- 绘制图元
    
    /*
     glDrawArrays用元素索引为first和first+count+1的元素指定的顶点绘制mode指定的图元。调用glDrawArrays(GL_TRIANGLES, 0, 6)将绘制两个三角形：一个三角形由索引（0，1，2）指定，另一个三角形由（3，4，5）指定。类似的，调用glDrawArrays(GL_TRIANGLE_STRIP，0，5)将绘制3个三角形：一个由元素索引（0，1，2）指定，第二个三角形由元素索引（2，1，3）指定，最后一个由（2，3，4）指定。
     
     glDrawArrays(<#GLenum mode#>, <#GLint first#>, <#GLsizei count#>)
     mode   指定要渲染的图元：有效值为
            GL_POINTS
            GL_LINES
            GL_LINE_STRIP
            GL_LINE_LOOP
            GL_TRIANGLES
            GL_TRIANGLE_STRIP
            GL_TRIANGLE_LOOP
     first  指定启用的顶点数组中的起始顶点索引
     count  指定要绘制的顶点数量
     
     
     glDrawElements(<#GLenum mode#>, <#GLsizei count#>, <#GLenum type#>, <#const GLvoid *indices#>)
     glDrawRangeElements(<#GLenum mode#>, <#GLuint start#>, <#GLuint end#>, <#GLsizei count#>, <#GLenum type#>, <#const GLvoid *indices#>)
     mode   指定要渲染的图元；有效值为
            GL_POINTS
            GL_LINES
            GL_LINE_STRIP
            GL_LINE_LOOP
            GL_TRIANGLES
            GL_TRIANGLE_STRIP
            GL_TRIANGLE_LOOP
     start  指定indices中的最小数组索引 （仅glDrawRangeElements）
     end    指定indices中的最大数组索引 （仅glDrawRangeElements）
     count  指定要绘制的索引数量
     type   指定indices中保存的元素索引类型；有效值为
            GL_UNSIGNED_BYTE
            GL_UNSIGNED_SHORT
            GL_UNSIGNED_INT
     indices    指向元素索引存储位置的指针
     
     如果你有一个由一系列顺序元素索引描述的图元，且几何形状的顶点不共享，则glDrawArrays很好用。但是，游戏或者其他3D应用程序使用的典型对象由多个三角形网格组成，其中元素的索引可能不一定按照顺序，顶点通常在网格的三角形之间共享。
     */
    
    
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
