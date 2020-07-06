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


#define VERTEX_POS_SIZE             3
#define VERTEX_NORMAL_SIZE          3
#define VERTEX_TEXCOORD0_SIZE       2
#define VERTEX_TEXCOORD1_SIZE       2

#define VERTEX_POS_INDX             0
#define VERTEX_NORMAL_INDX          1
#define VERTEX_TEXCOORD0_INDX       2
#define VERTEX_TEXCOORD1_INDX       3

#define VERTEX_POS_OFFSET           0
#define VERTEX_NORMAL_OFFSET        3
#define VERTEX_TEXCOORD0_OFFSET     6
#define VERTEX_TEXCOORD1_OFFSET     8

#define VERTEX_ATTRIB_SIZE         (VERTEX_POS_SIZE + \
VERTEX_NORMAL_SIZE + \
VERTEX_TEXCOORD0_SIZE + \
VERTEX_TEXCOORD1_SIZE)


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
    printf("maxVertexAttribute %d\n",maxVertexAttribute);
    
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
    
    /*
     分配和存储顶点属性数据的常用方法：
     • 在一个缓冲区中存储顶点属性 --- 这种方法称为结构数组。结构表示顶点的所有属性，每个顶点有一个属性到数组。
     • 在单独的缓冲区中保存每个顶点属性  --- 这种方法称为数组结构。
     假设每个顶点有4个顶点属性 -- 位置、法线和两个纹理坐标 -- 这些属性一起保存在为所有顶点分配的一个缓冲区中。
     ---------------------
     |x|y|z|x|y|z|s|t|s|t|
     ---------------------
     位置  法线  纹理 纹理
     
     对于OpenGL ES 3.0硬件实现，哪种分配方法最高效？大部分情况下是数组结构。原因是，每个顶点的属性数据可以顺序方式读取，这最有可能造成高效的内存访问模式。
     */
    
    //结构数组
    int numVertices = 1;
    float *p = (float *)malloc(numVertices * VERTEX_ATTRIB_SIZE * sizeof(float));
    
    //Position is Vertex attribute 0
    glVertexAttribPointer(VERTEX_POS_INDX, VERTEX_POS_SIZE, GL_FLOAT, GL_FALSE, VERTEX_ATTRIB_SIZE * sizeof(float), p);
    
    //Normal is Vertex attribute 1
    glVertexAttribPointer(VERTEX_NORMAL_INDX, VERTEX_NORMAL_SIZE, GL_FLOAT, GL_FALSE, VERTEX_ATTRIB_SIZE *sizeof(float), (p + VERTEX_NORMAL_OFFSET));
    
    //texture coordinate 0 is vertex attribute 2
    glVertexAttribPointer(VERTEX_TEXCOORD0_INDX, VERTEX_TEXCOORD0_SIZE, GL_FLOAT, GL_FALSE, VERTEX_ATTRIB_SIZE * sizeof(float), (p + VERTEX_TEXCOORD0_OFFSET));
    
    //texture coordinate 1 is vertex attribute 2
    glVertexAttribPointer(VERTEX_TEXCOORD1_INDX, VERTEX_TEXCOORD1_SIZE, GL_FLOAT, GL_FALSE, VERTEX_ATTRIB_SIZE * sizeof(float), (p + VERTEX_TEXCOORD1_OFFSET));
    
    //数组结构
    float *position = (float *)malloc(sizeof(float) * numVertices * VERTEX_POS_SIZE);
    float *normal = (float *)malloc(sizeof(float) *numVertices * VERTEX_NORMAL_SIZE);
    float *texcoord0 = (float *)malloc(sizeof(float) *numVertices * VERTEX_TEXCOORD0_SIZE);
    float *texcoord1 = (float *)malloc(sizeof(float) *numVertices * VERTEX_TEXCOORD1_SIZE);
    
    glVertexAttribPointer(VERTEX_POS_INDX, VERTEX_POS_SIZE, GL_FLOAT, GL_FALSE, VERTEX_POS_SIZE * sizeof(float), position);
    glVertexAttribPointer(VERTEX_NORMAL_INDX, VERTEX_NORMAL_SIZE, GL_FLOAT, GL_FALSE, VERTEX_NORMAL_SIZE * sizeof(float), normal);
    glVertexAttribPointer(VERTEX_TEXCOORD0_INDX, VERTEX_TEXCOORD0_SIZE, GL_FLOAT, GL_FALSE, VERTEX_TEXCOORD0_SIZE * sizeof(float), texcoord0);
    glVertexAttribPointer(VERTEX_TEXCOORD1_INDX, VERTEX_TEXCOORD1_SIZE, GL_FLOAT, GL_FALSE, VERTEX_TEXCOORD1_SIZE * sizeof(float), texcoord1);
    
    /*
     在常量顶点属性和顶点数组之间选择
     glEnableVertexAttribArray 和 glDisableVertexAttribArray 命令分别用于启用和禁用通用顶点属性数组。如果某个通用属性索引的顶点属性数组被禁用，将使用为该索引指定的常量顶点属性数据。
     void glEnableVertexAttribArray(GLuint index);
     void glDisableVertexAttribArray(GLuint index);
     index 指定通用顶点属性索引。这个值的范围从0到支持的最大顶点属性索引减1。
     */
    glEnableVertexAttribArray(0);
    glDisableVertexAttribArray(0);
    
    
#pragma mark -- 在顶点着色器中声明顶点属性变量
    
    /*
     在顶点着色器中，变量通过使用in限定符声明为顶点属性。属性变量也可以选择包含一个布局限定符，提供属性索引。
     layout(location = 0) in vec4  a_position
     layout(location = 1) in vec2  a_texcoord;
     layout(location = 2) in vec3  a_normal;
     
     in限定符只能用于数据类型float、vec2、vec3、vec4、int、ivec2、ivec3、ivec4、uint、uvec2、uvec3、uvec4、mat2、mat2*2、mat2*3、mat2*4、mat3、mat3*3、mat3*4、mat4、mat4*2、mat4*3。属性变量不能声明为数组或者结构。
     在顶点着色器中声明为顶点属性的变量是只读变量，不能修改。
     属性可以在顶点着色器内部声明 -- 但是如果没有使用，就不会被认为是活动属性，从而不会被计入限制。如果在顶点着色器中使用的属性数量大于GL_MAX_VERTEX_ATTRIBS,这个顶点着色器就无法链接。
     一旦程序链接成功，我们就需要找出链接到该程序的顶点着色器使用的活动顶点属性数量。注意，这一步骤只在你对属性不使用输入布局限定符时才有必要。在OpenGLES 3.0中，建议布局限定符；这样你就没有必要事后查询这一信息。
     下面的代码行展示了如何获得活动顶点属性数量：
     glGetProgramiv(program，GL_ACTIVE_ATTRIBUTES, &numActiveAttributes);
     
     程序使用的活动顶点属性列表和它们的数据类型可以用glGetActiveAttrib命令查询。
     glGetActiveAttrib(<#GLuint program#>, <#GLuint index#>, <#GLsizei bufsize#>, <#GLsizei *length#>, <#GLint *size#>, <#GLenum *type#>, <#GLchar *name#>)
     program        前面成功链接的程序对象
     index          指定需要查询的顶点属性，其值为0到GL_ACTIVE_ATTRIBUTES -1. GL_ACTIVE_ATTRIBUTES的值用glGetProgramiv确定。
     bufsize        指定可以写入name的最大字符数，包括NULL终止符。
     length         返回写入name的字符数，如果length 不为NULL， 则不含NULL终止符。
     type           返回属性类型，有效值为
     GL_FLOAT, GL_FLOAT_VEC2, GL_FLOAT_VEC3,
     GL_FLOAT_VEC4, GL_FLOAT_MAT2, GL_FLOAT_MAT3, GL_FLOAT_MAT4
     GL_FLOAT_MAT2*3, GL_FLOAT_MAT2*4, GL_FLOAT_MAT3*2,
     GL_FLOAT_MAT3*4, GL_FLOAT_MAT4*2, GL_FLOAT_MAT4*3,
     GL_INT, GL_INT_VEC2, GL_INT_VEC3, GL_INT_VEC4,
     GL_UNSIGNED_INT, GL_UNSIGNED_INT_VEC2, GL_UNSIGNED_INT_VEC3, GL_UNSIGNED_INT_VEC4
     size           返回属性大小。这以type返回的类型单元格数量指定。如果变量不是一个数组，则size总是为1。如果变量是一个数组，则size返回数组大小。
     name           顶点着色器中声明的属性变量名称。
     */
    
    /*
     在OpenGL ES 3.0中， 可以使用3种方法将通用顶点属性索引映射到顶点着色器中的一个属性变量名称。这些方法可以分为如下几类：
     ▷ 索引可以在顶点着色器源代码中用layout（location = N）限定符指定（推荐）
     ▷ OpenGL ES 3.0将通过顶点属性索引绑定到属性名称
     ▷ 应用程序可以将顶点属性索引绑定到属性名称。
     
     glBindAttribLocation命令可用于将通用顶点属性索引绑定到顶点着色器中的一个属性变量。
     这种绑定在下一次程序链接时生效 --- 不会改变当前链接的程序中的使用的绑定。
     glBindAttribLocation(<#GLuint program#>, <#GLuint index#>, <#const GLchar *name#>)
     program        程序对象名称
     index          通用顶点属性索引
     name           属性变量名称
     
     glGetAttribLocation(<#GLuint program#>, <#const GLchar *name#>)
     program        程序对象
     name           属性变量名称
     glGetAttribLocation返回program定义的程序对象最后一次链接时绑定到属性变量name的通用属性索引。
     */
    
    
#pragma mark -- 顶点缓冲区对象
    
    /*
     使用顶点数组指定的顶点数据保存在客户内存中。在进行glDrawArrays或者glDrawElements等绘图调用时，这些数据必须从客户内存复制到图形显卡。但是我们没有必要在每次绘图调用时都复制顶点数据，而是在图形内存中缓存这些数据，那就好得多了。这种方法可以显著地改进渲染性能，可以降低内存带宽和电力消耗需求，对于手持设备相当重要。
     
     glGenBuffers(<#GLsizei n#>, <#GLuint *buffers#>)
     n              返回的缓冲区对象名称数目
     buffers        指向n个条目的数组指针，该数组是分配的缓冲区对象返回的位置
     分配n个缓冲区对象名称，并在buffers中返回它们。
     */
    GLuint buffers;
    glGenBuffers(2, &buffers);
    printf("buffers %d\n",buffers);
    
    /*
     glBindBuffer 命令用于指定当前缓冲区对象。第一次通过调用glBindBuffer绑定缓冲区对象名称时，缓冲区对象以默认状态分配；如果分配成功，则分配的对象绑定为目标的当前缓冲区对象。
     
     glBindBuffer(<#GLenum target#>, <#GLuint buffer#>)
     target             可以设置为以下目标的任何一个：
                        GL_ARRAY_BUFFER
                        GL_ELEMENT_ARRAY_BUFFER
                        GL_COPY_READ_BUFFER
                        GL_COPY_WRITE_BUFFER
                        GL_PIXEL_PACK_BUFFER
                        GL_PIXEL_UNPACK_BUFFER
                        GL_TRANSFORM_FEEDBACK_BUFFER
                        GL_UNIFORM_BUFFER
     buffer             分配给目标作为当前对象的缓冲区对象
     */
    glBindBuffer(GL_ARRAY_BUFFER, buffers);
    
    
    /*
     缓冲区对象相关状态分类：
     ▷  GL_BUFFER_SIZE      引用由glBufferData指定的缓冲区对象数据的大小。在用glBindBuffer首次绑定缓冲区对象时，初始值为0。
     ▷  GL_BUFFER_USAGE     这是对应用程序如何使用存储在缓冲区对象中的数据的提示。
     
     glBufferData(<#GLenum target#>, <#GLsizeiptr size#>, <#const GLvoid *data#>, <#GLenum usage#>)
     target     可以设置如下的其中之一
                GL_ARRAY_BUFFER
                GL_ELEMENT_ARRAY_BUFFER
                GL_COPY_READ_BUFFER
                GL_COPY_WRITE_BUFFER
                GL_PIXEL_PACK_BUFFER
                GL_PIXEL_UNPACK_BUFFER
                GL_TRANSFORM_FEEDBACK_BUFFER
                GL_UNIFORM_BUFFER
     size       缓冲区数据存储大小，以字节数表示
     data       应用程序提供的缓冲区数据的指针,data可以为NULL值，表示保留的数据存储不进行初始化。
     usage      应用程序将如何使用缓冲区对象中存储的数据的提示
                GL_STATIC_DRAW   缓冲区对象数据将被修改一次，使用多次，以绘制图元或者指定图像
                GL_STATIC_READ   缓冲区对象数据将被修改一次，使用多次，以从OpenGL ES读回数据。
                GL_STATIC_COPY   缓冲区对象数据将被修改一次，使用多次，以从OpenGL ES读回数据。
                GL_DYNAMIC_DRAW  缓冲区对象数据将被重复修改，使用多次，以绘制图元或者指定图像
                GL_DYNAMIC_READ  缓冲区对象数据将被重复修改，使用多次，以从OpenGL ES读回数据。
                GL_DYNAMIC_COPY  缓冲区对象数据将被重复修改，使用多次，以从OpenGL ES读回数据。
                GL_STREAM_DRAW   缓冲区对象数据将被修改一次，只使用少数几次，以从OpenGL ES读回数据。
                GL_STREAM_READ   缓冲区对象数据将被修改一次，只使用少数几次，以从OpenGL ES读回数据。
                GL_STREAM_COPY   缓冲区对象数据将被修改一次，只使用少数几次，以从OpenGL ES读回数据。
     */
    //    glBufferData(<#GLenum target#>, <#GLsizeiptr size#>, <#const GLvoid *data#>, <#GLenum usage#>)
    
    
    /*
     缓冲区对象数据存储的内容可以用glBufferSubData命令初始化或者更新。
     glBufferSubData(<#GLenum target#>, <#GLintptr offset#>, <#GLsizeiptr size#>, <#const GLvoid *data#>)
     target     可以设置为如下的任何一个：
                GL_ARRAY_BUFFER
                GL_ELEMENET_ARRAY_BUFFER
                GL_COPY_READ_BUFFER
                GL_COPY_WRITE_BUFFER
                GL_PIXEL_PACK_BUFFER
                GL_PIXEL_UNPACK_BUFFER
                GL_TRANSFORM_FEEDBACK_BUFFER
                GL_UNIFORM_BUFFER
     offset     缓冲区数据存储中的偏移
     size       被修改的数据存储字节数
     data       需要被复制到缓冲区对象数据存储到客户数据指针
     
     在用glBufferData或者glBufferSubData初始化或者更新缓冲区对象数据存储之后，客户数据存储不再需要，可以释放。对于静态的几何形状，应用程序可以释放客户数据存储，减少应用程序消耗的系统内存。对于动态几何形状，这可能无法做到。
     */
    
    
    /*
     在应用程序结束缓冲区对象的使用后，可以用glDeleteBuffers命令删除它们。
     
     glDeleteBuffers(<#GLsizei n#>, <#const GLuint *buffers#>)
     n            删除的缓冲区对象数量
     buffers      包含要删除的缓冲区对象的有n个元素的数组
     */
    
    
    
#pragma mark --  顶点数组对象
    
    /*
     加载顶点属性的两种不同方法：使用客户顶点数组和使用顶点缓冲区对象。顶点缓冲区对象优于客户顶点数组，因为它们能够减少CPU和GPU之间复制的数据量，从而获得更好的性能。
     在OpenGL ES3.0中引入了一个新特性，使顶点数组的使用更加高效：顶点数组对象（VAO）。
     VAO提供包含在顶点数组/顶点缓冲区对象配置之间切换所需要的所有状态的单一对象。
     
     要创建新的顶点数组对象，可以使用glGenVertexArray函数。
     glGenVertexArrays(<#GLsizei n#>, <#GLuint *arrays#>)
     n          要返回的顶点数组对象名称的数量
     arrays     指向一个n个元素的数组的指针，该数组是分配的顶点数组对象返回的位置。一旦创建，就可以用glBindVertexArray绑定顶点数组对象供以后使用。
     */
    GLsizei n = 1;
    GLuint arrays;
    glGenVertexArrays(n, &arrays);
    printf("arrays %d",arrays);
    
    /*
     glBindVertexArray(<#GLuint array#>)
     array      被指定为当前顶点数组对象的对象
     
     每个VAO都包含一个完整的状态向量，描述所有顶点缓冲区绑定和启用的顶点客户状态。绑定VAO时，他的状态向量提供顶点缓冲区状态的当前设置。用
     glBindVertexArray绑定顶点数组对象后，更改顶点数组状态的后续调用将影响新的VAO.
     */
    glBindVertexArray(arrays);
    
    /*
     glDeleteVertexArrays(<#GLsizei n#>, <#const GLuint *arrays#>)
     n          要删除的顶点数组对象的数量
     array      包含需要删除顶点数组对象的有n个元素数组。
     */
    glDeleteVertexArrays(n, &arrays);
    
    
    
#pragma mark -- 映射缓冲区对象
    
    /*
     应用程序也可以将缓冲区对象数据存储映射到应用程序的地址空间（也可以解除映射）。
     应用程序映射缓冲区而不使用glBufferData或者glBufferSubData 加载数据有几个理由：
     ▷  映射缓冲区可以减少应用程序的内存占用，因为可能只需要存储数据的一个副本。
     ▷  在使用共享内存的架构上，映射缓冲区返回GPU存储缓冲区的地址空间的直接指针。通过映射缓冲区，应用程序可以避免复制步骤，从而实现更好的更新性能。
     
     glMapBufferRange命令返回指向所有或者一部分（范围）缓冲区对象数据存储的指针。这个指针可以供应用程序使用，以读取或更新缓冲区对象的内容。
     glMapBufferRange(<#GLenum target#>, <#GLintptr offset#>, <#GLsizeiptr length#>, <#GLbitfield access#>)
     target         可以设置为如下的其中之一：
                    GL_ARRAY_BUFFER
                    GL_ELEMENT_ARRAY_BUFFER
                    GL_COPY_READ_BUFFER
                    GL_COPY_WRITE_BUFFER
                    GL_PIXEL_PACK_BUFFER
                    GL_PIXEL_UNPACK_BUFFER
                    GL_TRANSFORM_FEEDBACK_BUFFER
                    GL_UNIFORM_BUFFER
     offset         缓冲区数据存储中的偏移量，以字节数计算
     length         需要映射的缓冲区数据的字节数
     access         访问标志的位域组合。如下：
                    GL_MAP_READ_BIT
                    GL_MAP_WRITE_BIT
     
                    GL_MAP_INVALIDATE_RANGE_BIT
                    GL_MAP_INVALIDATE_BUFFER_BIT
                    GL_MAP_FLUSH_EXPLICIT_BIT
                    GL_MAP_UNSYNCHRONIZED_BIT
     */
    
    
    /*
     glUnmapBuffer 命令取消之前的缓冲区映射
     
     glUnmapBuffer(<#GLenum target#>)
     target     必须设置为GL_ARRAY_BUFFER
     如果取消映射操作成功，则glUnmapBuffer返回结果为GL_TRUE。
     */
    
    
    /*
     glFlushMappedBufferRange(<#GLenum target#>, <#GLintptr offset#>, <#GLsizeiptr length#>)
     target         可以设置为如下的其中之一：
                    GL_ARRAY_BUFFER
                    GL_ELEMENT_ARRAY_BUFFER
                    GL_COPY_READ_BUFFER
                    GL_COPY_WRITE_BUFFER
                    GL_PIXEL_PACK_BUFFER
                    GL_PIXEL_UNPACK_BUFFER
                    GL_TRANSFORM_FEEDBACK_BUFFER
                    GL_UNIFORM_BUFFER
     offset         从映射缓冲区起始点的偏移量，以字节数表示
     length         从偏移点开始刷新的缓冲区字节数
     
     应用程序可能希望用glMapBufferRange来映射缓冲区的一个范围（或者全部），但是只更新映射范围的不用子区域。为了避免调用glUnmapBuffer时刷新整个映射范围的潜在性能损失，应用程序可以用GL_MAP_FLUSH_EXPLICIT_BIT访问标志映射。当应用程序完成映射范围一部分的更新时，可以用glFlushMappedBufferRange指出这个事实。
     */
    
    
#pragma mark -- 复制缓冲区对象
    
    /*
     OpenGL ES 3.0 可以从一个缓冲区对象将数据完全复制到设备，这可用glCopyBufferSubData函数完成。
     
     glCopyBufferSubData(<#GLenum readTarget#>, <#GLenum writeTarget#>, <#GLintptr readOffset#>, <#GLintptr writeOffset#>, <#GLsizeiptr size#>)

     readtarget      读取的缓冲区对象目标
     writetarget     写入的缓冲区对象目标。readtarget 和writetarget都可以设置为如下目标中的任何一个（尽管它们不必设置为同一个目标）：
                    GL_ARRAY_BUFFER
                    GL_ELEMENT_ARRAY_BUFFER
                    GL_COPY_READ_BUFFER
                    GL_COPY_WRITE_BUFFER
                    GL_PIXEL_PACK_BUFFER
                    GL_PIXEL_UNPACK_BUFFER
                    GL_TRANSFORM_FEEDBACK_BUFFER
                    GL_UNIFORM_BUFFER
     readoffset     需要复制的读缓冲数据中的偏移量，以字节表示
     writeoffset    需要复制的写缓冲数据中的偏移量，以字节表示
     size           从读缓冲区数据复制到写缓冲区数据的字节数
     
     调用glCopyBufferSubData将从绑定到readtarget的缓冲区复制到指定的字节writetarget。缓冲区绑定根据每个目标的最后一次glBindBuffer调用确定。任何类型的缓冲区对象（数组、元素数组、变换反馈等）都可以绑定到GL_COPY_READ_BUFFER或GL_COPY_WRITE_BUFFER目标。这两个目标是一种方便的措施，使得应用程序在执行缓冲区间的复制时不必改变任何真正的缓冲区绑定。
     */
//    glCopyBufferSubData(<#GLenum readTarget#>, <#GLenum writeTarget#>, <#GLintptr readOffset#>, <#GLintptr writeOffset#>, <#GLsizeiptr size#>)
    
    
    
    
    
    
    
    
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
