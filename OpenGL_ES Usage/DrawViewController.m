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

#define VERTEX_POS_INDX     0
#define NUM_FACES           6

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
    printf("lineWidthRange %f\n",lineWidthRange[1]);
    
    
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
    printf("pointSizeRange %f\n",pointSizeRange[1]);
    
    
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
     
     即使我们用glDrawElements绘制三角形，用glDrawArrays和glDrawElements绘制一个三角扇形，我们的应用程序在GPU上运行的也比glDrawArrays更快，这有许多原因。例如由于顶点重用，顶点属性数据的尺寸将小于glDrawElements。这也导致较小的内存占用和内存带宽需求。
     */
    
    GLfloat vertices[] = {}; // (x,y,z) per vertex
    glEnableVertexAttribArray(VERTEX_POS_INDX);
    glVertexAttribPointer(VERTEX_POS_INDX, 3, GL_FLOAT, GL_FALSE, 0, vertices);
    
    for (int i = 0; i < NUM_FACES; i ++) {
        glDrawArrays(GL_TRIANGLE_FAN, i * 4, 4);
    }
    
    
    GLubyte indices[36] =
    {
        0,1,2,0,2,3,
        0,3,4,0,4,5,
        0,5,6,0,6,1,
        7,1,6,7,2,1,
        7,5,4,7,6,5,
        7,3,2,7,4,3
    };
    glEnableVertexAttribArray(VERTEX_POS_INDX);
    glVertexAttribPointer(VERTEX_POS_INDX, 3, GL_FLOAT, GL_FALSE, 0, vertices);
    glDrawElements(GL_TRIANGLES, sizeof(indices)/sizeof(GLubyte), GL_UNSIGNALED, indices);
    
    
    /*
     图元重启
     使用图元重启，可以在一次绘图调用中渲染多个不相连的图元（例如三角扇形或者条带）。这对于降低绘图API调用的开销是有利的。图元重启的另一种方式是生成退化三角形，这种方法较不简洁。
     使用图元重启，可以通过在索引列表中插入一个特殊索引来重启一个用于索引绘图调用的图元。这个特殊索引是该索引类型的最大可能索引（例如，索引类型为GL_UNSIGNED_BYTE或GL_UNSIGNED_SHORT时，分别为255或者65535）。
     例如，假定两个三角形条带分别为元素索引(0,1,2,3)和（8，9，10，11）。如果我们想利用图元重启在一次调用glDrawElements*中绘制两个条带，索引类型为GL_UNSIGNED_BYTE,则组合的元素索引列表为（0，1，2，3，255，8，9，10，11）。
     可以用如下代码启用和禁用图元重启：
     glEnable   (GL_PRIMITIVE_RESTART_FIXED_INDEX);
     //Draw primitives
     glDisable  (GL_PRIMITIVE_RESTART_FIXED_INDEX);
     */
    
    /*
     驱动顶点
     如果没有限定符，那么顶点着色器的输出值在图元中使用线性插值。但是，使用平面着色时没有发生插值。因为没有发生插值，所以片段着色器中只有一个顶点值可用。对于给定的图元实例，这个驱动顶点确定使用顶点着色器的哪一个顶点输出，因为只能使用一个顶点。
     下面展示了驱动顶点选择的规制。
     GL_POINTS                          i
     GL_LINES                           2i
     GL_LINE_LOOP                       如果i<n，为i+1
                                        如果i=n, 为1
     GL_LINE_STRIP                      i+1
     GL_TRIANGLES                       3i
     GL_TRIANGLE_STRIP                  i+2
     GL_TRIANGLE_LOOP                   i+2
     */
    
    /*
     几何形状实例化
     几何形状实例化很高效，可以用一次API调用多次渲染具有不同属性（例如不同的变换矩阵、颜色或者大小）的一个对象。这一功能在渲染大量类似对象时很有用，例如对人群的渲染。几何图形实例化降低了向OpenGLES引擎发送了许多API调用的CPU处理开销。
     glDrawArraysInstanced(<#GLenum mode#>, <#GLint first#>, <#GLsizei count#>, <#GLsizei instancecount#>)
     glDrawElementsInstanced(<#GLenum mode#>, <#GLsizei count#>, <#GLenum type#>, <#const GLvoid *indices#>, <#GLsizei instancecount#>)
     
     mode       指定要渲染的图元；有效值为
                GL_POINTS
                GL_LINES
                GL_LINE_STRIP
                GL_LINE_LOOP
                GL_TRIANGLES
                GL_TRIANGLE_STRIP
                GL_TRIANGLE_FAN
     first      指定启用的顶点数组中的起始顶点索引（glDrawArraysInstanced）
     count      指定绘制的索引数量
     type       指定保存在indices中的元素索引类型（仅glDrawElementsInstanced），有效值为：
                GL_UNSIGNED_BYTE
                GL_UNSIGNED_SHORT
                GL_UNSIGNED_INT
     indices    指定元素索引存储位置的一个指针（glDrawElementsInstanced）
     instanceCount  指定绘制的图元实例数量
     
     
     可以使用两种方法访问每个实例的数据。第一种方法是用如下命令指示OpenGLES 对每个实例读取一次或者多次顶点属性：
     glVertexAttribDivisor(<#GLuint index#>, <#GLuint divisor#>)
     index      指定通用顶点属性索引
     divisor    指定index位置的通用属性更新之间传递的实例数量
     默认情况下，如果没有指定glVertexAttribDivisor或者顶点属性的divisor等于零，对每个顶点将读取一次顶点属性。如果divisor等于1，则每个图元实例读取一次顶点属性。
     
     第二种方法是使用内建输入变量gl_InstanceID作为顶点着色器中的缓冲区索引，以访问每个实例的数据。使用前面提到的几何形状实例化API调用时，gl_InstanceID将保存当前图元实例的索引。使用非实例化绘图调用时，gl_InstanceID将返回0。
     
     创建和填充颜色缓冲区之后，我们可以绑定颜色缓冲区，将其作为几何形状的顶点属性之一。然后，指定顶点属性因数1，为每个图元实例读取颜色。最后，用一次实例化绘图调用绘制立方体。
     */
    
    
    /*
     应用程序应该确保用尽可能大的图元尺寸调用glDrawElements和glDrawElementsInstanced。如果我们绘制GL_TRIANGLES，这很容易做到。但是，如果有三角形条带或者扇形的网格，则可以用图元重启讲这些网格链接在一起，而不用对每个三角形条带网格单独调用
     glDrawElements*。
     如果无法使用图元重启机制将网格链接在一起（为了维护与旧版本OpenGL ES的兼容性），可以添加造成退化三角形的元素索引，代价是使用更多的索引。退化三角形是两个或者更多顶点相同的三角形。GPU可以非常简单地检测和拒绝退化三角形，所以这是很好的性能改进，我们可以将一个很大的图元放入由GPU渲染的队列。
     为了链接不同网格而添加的元素索引（或者退化三角形）数量取决于每个网格是三角扇形还是三角形条带以及每个条带中定义的索引数量。三角形条带网格的索引数量很重要，因为我们必须保留从跨越链接起来的不同网格的条带的一个三角形到下一个三角形的弯曲顺序。
     
     连接不同的三角形条带时，我们需要检查两个相互连接的条带的最后一个三角形和第一个三角形的顺序。描述三角形条带中偶数编号的三角形的顶点顺序与描述同一个条带中奇数编号的三角形的顶点顺序不同。
     有两种情况需要处理：
     •  第一个三角形条带的奇数编号的三角形连接到第二个三角形条带的第一个（因而是偶尔编号的）三角形。
     •  第一个三角形条带的偶数编号的三角形连接到第二个三角形条带的第一个（因而是偶尔编号的）三角形。
     
     注意，需要的附加元素索引数量和生成的退化三角形数量取决于第一个条带的顶点数量。必须保留下一个连接条带的弯曲顺序。
     在确定如何安排图元元素索引时考虑变换后顶点缓存的大小也是值得研究的技术。大部分GPU采用一个变换后顶点缓存。在顶点着色器执行顶点之前，进行一次检查，以确定顶点是否已经存在于变换后缓存。如果顶点存在于变换后缓存，则顶点着色器不执行顶点；如果顶点不在缓存中，则顶点着色器不执行顶点；如果顶点不在缓存中，则顶点着色器需要执行顶点。使用变换后缓存的大小来确定元素索引的创建方式应该有助于提升总体性能，因为这将减少顶点着色器执行重用顶点的次数。
     */
    
    
    
#pragma mark --  图元装配
    
    /*
     图元装配阶段
     顶点着色器 ->【 裁剪 -> 透视分割 -> 视口变换 】-> 到光栅化阶段
     */
    
    /*
     坐标系统
     顶点以物体或者本地坐标空间输入到OpenGLES，这是最有可能用来建模和存储一个对象的坐标空间。在顶点着色器执行之后，顶点位置被认为是在裁剪坐标空间内。顶点位置从本地坐标系统（物体坐标）到裁剪坐标的变换通过加载执行这一转换的对应矩阵来完成，这些矩阵保存在顶点着色器中定义的对应统一变量中。
     
     物体坐标             裁剪坐标               规范化设备坐标            窗口坐标
     ---->   顶点着色器 ----------> 透视分割  -------------->  视口变换 --------->
     */
    
    /*
     裁剪
     为了避免在可视景体之外处理图元，图元被裁减到裁剪空间。执行顶点着色器之后的顶点位置处于裁剪坐标空间内。裁剪坐标是由（x,y,z,w）指定的同类坐标。在裁剪空间（x,y,z,w）中定义的顶点坐标根据视景体（又称裁剪体）裁剪。
     裁剪体由6个裁剪平面定义，这些平面称作近、远、左、右、上、下裁剪平面。在裁剪坐标中，裁剪体如下：
     -Wc <= Xc <= Wc
     -Wc <= Yc <= Wc
     -Wc <= Zc <= Wc
     前面的6项检查根据需要裁剪的图元，有助于确定平面的列表。
     裁剪阶段将把每个图元裁剪到裁剪体上。“图元”是指用GL_TRIANGLES绘制的单独三角形列表中的每一个三角形，或者一个三角形条带或者扇形中的一个三角形，或者用GL_LINES绘制的单独直线列表中的一条直线，或者一个直线条带或者闭合折线中的一条直线，或者点精灵列表中的一个特定点。
     对于每种图元类型：
     •  裁剪三角形  -- 如果三角形完全在视景体内部，则不执行任何裁剪。如果三角形完全在视景体之外，则该三角形被放弃。如果三角形部分在视景体内，则根据相应的平面裁剪三角形。裁剪操作将生成新的顶点，这些顶点被裁减到安排为三角扇形的平面。
     •  裁剪直线  -- 如果直线完全在视景体内部，则不执行任何裁剪。如果直线完全在视景体之外，则该直线被放弃。如果直线部分在视景体内，则直线被裁减并生成相应的新顶点。
     •  裁剪点精灵  -- 如果点位置在近或者远裁剪平面之外，或者如果表示点精灵的正方形在裁剪体之外，裁剪阶段将抛弃点精灵。否则，它将不做变化的通过该阶段，点精灵将在其从裁剪体内部移到外部时裁剪，反之亦然。
     在图元根据六个裁剪平面进行裁剪时，顶点坐标经历透视分割，从而成为规范化的设备坐标。规范化的设备坐标范围为-1.0到1.0。
     */
    
    
    /*
     透视分割
     透视分割取得裁剪坐标（x,y,z,w）指定的点，并将其投影到屏幕或者视口上。这个投影通过将（x,y,z）除以w进行。执行（X/w）、（Y/w）、（Z/w）之后，我们得到了规范化的设备坐标（X，Y，Z）。这些坐标被称为规范化设备坐标，因为它们落在【-1.0，1.0】区间。这些规范化的（X，Y）坐标根据视口的大小将被转换为真正的屏幕的坐标。规范化的（Z）坐标将用
     glDepthRangef指定的near和far深度值转换为屏幕的Z值。这些转换在视口变换阶段进行。
     */
    
    /*
     视口变换
     视口是一个二维矩形窗口区域，是所有OpenGL ES渲染操作最终显示的地方。视口变换可用如下API调用设置：
     glViewport(<#GLint x#>, <#GLint y#>, <#GLsizei width#>, <#GLsizei height#>)
     x, y       指定视口左下角的窗口坐标，以像素数表示
     w，h       指定视口的宽度和高度（以像素数表示）；这些值必须大于0
     
     深度范围值n和f可以用如下API调用设置：
     n，f         指定所需的深度范围。n和f的默认值分别为0.0和1.0。这两个值限于（0.0，1.0）区间内
     glDepthRangef和glViewport 指定的值用于将顶点位置从规范化设备坐标转化为窗口（屏幕）坐标。
     */
    
    
    
#pragma mark -- 光栅化
    
    /*
     在顶点变换和图元裁剪之后，光栅化管线取得单独图元（如三角形、线段和点精灵），并为该图元生成对应的片段。每个片段由屏幕空间中的整数位置（x，y）标示。片段代表了屏幕空间中（x，y）指定的像素位置和由片段着色器处理而生成片段颜色的附加片段数据。
     */
    
    /*
     剔除
     在三角形被光栅化之前，我们需要确定它们是正面（也就是面向观看者）或者背面（也就是背向观看者）。剔除操作抛弃背向观看者的三角形。要确定三角形是正面还是背面，首先需要知道它的方向。
     三角形的方向指定从第一个顶点开始，经过第二个和第三个顶点，最后回到第一个顶点的弯曲方向或者路径顺序。
     三角形的方向通过以窗口坐标表示的有符号三角形的面积来计算。我们现在需要将计算出来的三角形面积符号翻译为顺时针（CW）或者逆时针（CCW）方向。这种从三角形面积的符号到顺时针或者逆时针方向的映射由应用程序如下API调用指定：
     glFrontFace(<#GLenum mode#>)
     mode       指定正面三角形的方向。有效值为GL_CW或者GL_CCW，默认值为GL_CCW
     
     
     我们已经讨论之计算三角形方向的方法。要确定需要剔除的三角形，需要知道三角形将被剔除的面。这通过应用程序使用如下API调用指定：
     glCullFace(<#GLenum mode#>)
     mode  指定要被剔除的三角形的面。有效值为GL_FRONT、GL_BACK和GL_FRONT_AND_BACK。默认值为GL_BACK。
     
     最后一个要点是，需要知道剔除操作是否应该执行。如果GL_CULL_FACE状态启用，剔除操作将被执行。
     GL_CULL_FACE状态可以由应用程序用如下API调用启用或者禁用：
     glEnable(<#GLenum cap#>)
     glDisable(<#GLenum cap#>)
     其中cap被设置为GL_CULL_FACE，默认情况下剔除被禁用
     概括起来，要剔除合适的三角形，OpenGLES 应用程序首先必须用glenable(GL_CULL_FACE)启用剔除，glCullFace设置相应的剔除面，并用glFrontFace设置正面三角形的方向。
     
     ⚠️ 剔除应该始终启用，以避免GPU浪费时间去光栅化不可见的三角形。启用剔除应该能够改善OpenGL ES应用程序的整体性能。
     */
    
    /*
     多边形偏移
     考虑绘制两个相互重叠的多边形的情况。你很有可能注意到伪像。这些伪像被称为深度冲突伪像，是因为三角形光栅化的精度有限而发生的，这种精度限制可能影响逐片段生成的深度值的精度，造成伪像。三角形光栅化使用的参数和生成的逐片段深度值的有限精度将越来越好，但是这个问题永远无法完全解决。
     */
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    // load vertex shader
    // set teh appropriate transformation matrices
    // set the vertex attribute s tate
    
    // draw the SMALLER quad
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    
    // set the depth func to <= as polygons are coplanar
    glDepthFunc(GL_LEQUAL);
    
    // set the vertex attribute state
    
    // draw the LARGER quad
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    
    /*
     我们需要在执行深度测试和深度值写入深度缓冲区之前，在计算出来的深度值上添加一个偏移量。如果深度测试通过，原始的深度值---而不是原始深度值+偏移 -- 将被保存到深度缓冲区中。
     多边形偏移用如下API调用设置：
     glPolygonOffset(<#GLfloat factor#>, <#GLfloat units#>)
     深度偏移的计算如下：
     深度偏移 = m * 因数 + r * 单位数
     在上述公式中，m是三角形中的最大深度斜率，计算方法如下：
     m = √(∂z/∂x²+∂z/∂y²)
     m也可以这样计算： m = max{|∂z/∂x|, |∂z/∂y|}
     斜率项∂z/∂x 和∂z/∂y 在三角形光栅化阶段期间由OpenGLES 实现计算。
     r是一个OpenGLES 实现定义的常量，代表深度值中可以保证产生差异的最小值。
     多边形偏移可以分别用glEnable(GL_POLYGON_OFFSET_FILL)和glDisable(GL_POLYGON_OFFSET_FILL)启用或者禁用。
     */
    
    
# pragma mark -- 遮挡查询
    
    /*
     遮挡查询用查询对象来跟踪通过深度测试的任何片段或者样本。这种方法可用于不同的技术，例如镜头炫光特效的可见性测试以及避免在包围体被遮挡的不可见对象上进行几何形状处理的优化。
     遮挡查询可以分别在GL_ANY_SAMPLES_PASSED或者GL_ANY_SAMPLES_PASSED_COMSERVATIVE目标上用glBeginQuery和
     glEndQuery开始和结束。
     
     glBeginQuery(<#GLenum target#>, <#GLuint id#>)
     glEndQuery(<#GLenum target#>)
     target     指定查询对象的目标类型；有效值是
                GL_ANY_SAMPLES_PASSED
                GL_ANY_SAMPLES_PASSED_COMSERVATIVE
                GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN
     id         指定查询对象的名称(glBeginQuery)
     使用GL_ANY_SAMPLES_PASSED目标将返回表示是否有样本通过深度测试的精确布尔状态。GL_ANY_SAMPLES_PASSED_CONSERVATIVE目标将提供更好的性能，但是答案的精确度较低。使用GL_ANY_SAMPLES_PASSED_CONSERVATIVE，有些实现将在没有样本通过深度测试时返回GL_TRUE。
     id 用glGenQueries创建，用glDeleteQueries删除。
     
     glGenQueries(<#GLsizei n#>, <#GLuint *ids#>)
     n      指定生成的查询名称对象的数量
     ids    指定一个数组，以存储查询名称对象的列表
     
     glDeleteQueries(<#GLsizei n#>, <#const GLuint *ids#>)
     n      指定要删除的查询名称对象的数量
     ids    指定一个需要删除的查询名称对象的列表数组
     
     在用glBeginQueries和glEndQueries指定查询对象边界之后，可以使用glGetQueryObjectuiv检索查询对象的结果。
     glGetQueryObjectuiv(<#GLuint id#>, <#GLenum pname#>, <#GLuint *params#>)
     target     指定查询对象名称
     pname      指定需要检索的查询对象参数。可以为GL_QUERY_RESULT或GL_QUERY_RESULT_AVAILABLE
     params     指定存储返回参数值的对应类型的数组
     
     为了获得更好的性能，你应该等待几帧再执行glGetQueryObjectuiv调用，以等待GPU中的结果可用。
     */
    GLuint ids;
    glBeginQuery(GL_ANY_SAMPLES_PASSED, ids);
    // draw primitives here
    
    glEndQuery(GL_ANY_SAMPLES_PASSED);
    
    // after several frames have elapsed, query the number of
    // samples that passed the depth test
    GLuint params;
    glGetQueryObjectuiv(ids, GL_QUERY_RESULT, &params);
    
    
    
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
