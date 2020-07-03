//
//  VertexViewController.m
//  OpenGL_ES Usage
//
//  Created by tigerfly on 2020/7/3.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "VertexViewController.h"
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
#import <OpenGLES/gltypes.h>

@interface VertexViewController ()

@property (nonatomic, strong) EAGLContext *context;

@end

@implementation VertexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    
    [EAGLContext setCurrentContext:self.context];
    
    
    
#pragma mark -- 指定定点属性数据。顶点属性数据可以用一个顶点数组对每个顶点指定，也可以将一个常量值用于一个图元的所有顶点。所有OpenGL ES 3.0实现必须支持最多16个顶点属性
     
    GLint maxVertexAttribute;
    glGetIntegerv(GL_MAX_VERTEX_ATTRIBS, &maxVertexAttribute);
    printf("maxVertexAttribute %d",maxVertexAttribute);
    
    /*
     常量顶点属性
     常量顶点属性对于一个图元的所有顶点都相同，所以对一个图元的所有顶点只需指定一个值。
     glVertexAttrib*命令用于加载index指定的通用顶点属性。
     */
    glVertexAttrib1f(0, 1.0);
    glVertexAttrib2f(1, 1.0, 1.0);
    glVertexAttrib3f(2, 1.0, 1.0, 0.0);
    glVertexAttrib4f(3, 1.0, 1.0, 1.0, 0.0);
    GLfloat values = 1.0;
    GLfloat values_2[] = {1.0, 1.0};
    GLfloat values_3[] = {1.0, 1.0, 1.0};
    GLfloat values_4[] = {1.0, 1.0, 1.0, 0.0};
    glVertexAttrib1fv(0, &values);
    glVertexAttrib2fv(1, values_2);
    glVertexAttrib3fv(2, values_3);
    glVertexAttrib4fv(3, values_4);
    
    /*
     顶点数组
     顶点数组指定每个顶点的属性，是保存在应用程序地址空间（OpenGL ES  称为客户空间）的缓冲区。它们作为顶点缓冲对象的基础，提供指定顶点属性数据的一种灵活高效的手段。
     glVertexAttribPointer(<#GLuint indx#>, GLint size, <#GLenum type#>, <#GLboolean normalized#>, <#GLsizei stride#>, <#const GLvoid *ptr#>)
     index  指定通用顶点属性索引。这个值的范围从0到支持的最大顶点属性数 -1。
     size   顶点数组中为索引引用的顶点属性所指定的分量数量。有效值为1～4。
     type   数据格式。两个函数都包括的有效值是
            GL_BYTE
            GL_UNSIGNED_BYTE
            GL_SHORT
            GL_UNSIGNED_SHORT
            GL_INT
            GL_UNSIGNED_INT
            
            glVertexAttribPointer的有效值还包括
            GL_HALF_FLOAT
            GL_FLOAT
            GL_FIXED
            GL_INT_2_10_10_10_REV
            GL_UNSIGNED_INT_2_10_10_10_REV
    normalized     (仅glVertexAttribPointer)用于表示非浮点数据格式类型在转换为浮点值时是否应该规范化。对于glVertexAttribPointer，这些值被当作是整数对待。
    stribe         每个顶点由size指定的顶点属性分量顺序存储。stride指定顶点索引I和（I+1）表示的顶点数据之间的位移。如果stride为0，则每个顶点的属性数据顺序存储。如果stride大于0，
                    则使用该值作为获取下一个索引表示的顶点数据的跨距。
     ptr            如果使用客户端顶点数组，则保存顶点属性数据的缓冲区的指针。如果使用顶点缓冲区对象，则表示该缓冲区内的偏移量。
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
