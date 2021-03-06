# OpenGL_ES_Usage
图形库使用

# OpenGL ES 3.0

# Shader Language

【1】 预处理器        
预处理器指令      
编号符（#）可以直接放在指令前， 或者在后面加上空格或水平制表符。       
#define     #undef      #if     #ifdef              
#ifndef     #else   #elif       #endif          
#error      #pragma     #extension      
#line           

预处理器指令事例        
•   " #version 300 es" 必须出现在以GLSL ES 版本 3.0  编写的着色器程序的第一行。如果省略这一行， 着色器将被看作针对版本1.00。 
•   #extension extension_name : behavior, 其中behavior 可以是require、enable、warn或者disable；而extension_name 是编译器支持的扩展名称。       
•   #pragma optimize ({on, off}) 启用或者禁用着色器优化（默认是on）     
•   #pragma debug ({on, off}) 启用或者禁用着色器编译中的调试信息（默认是off）     

预定义宏        
__LINE__ 十进制整数常量， 比当前源代码串中前一个新行的行号多一        
__FILE__ 十进制整数常量，表示当前处理的源字符串编号      
__VERSION__ 十进制整数， 如300     
GL_ES  如果在OpenGL ES 着色语言上运行， 定义为整数1     


【2】运算符和表达式      
运算符


向量分量        
除了数组数值型下标语法之外，向量分量的名称可以用单个字母表示。分量可以混合和重合，例如: pos.xx, pos.zy         
{x, y, z, w}      访问代表点或者法线的向量时使用               
{r, g, b, a}       访问代表颜色的向量时使用     
{s, t, p, q}       访问代表纹理坐标的向量时使用       

【3】类型           
着色器可以用数组和结构聚合以下类型，以构建更复杂的类型。没有指针类型。             
基本类型                
void                                                函数无返回值或者空的参数列表                
bool                                                布尔值             
int                                                   有符号和无符号整数     
float                                                浮点标量       
vec2, vec3, vec4                            n-分量浮点向量        
bvec2, bvec3, bvec4                     布尔向量        
ivec2, ivec3, ivec4                         有符号整数向量     
uvec2, uvec3, uvec4                     无符号整数向量     
mat2, mat3, mat4                           2 * 2， 3 * 3， 4 * 4 浮点矩阵     
mat2 * 2, mat2 * 3, mat2 * 4        
mat3 * 2 mat3 * 3, mat3 * 4         
mat4 * 2 mat4 * 3, mat4 * 4           

浮点采样器类型 （不透明）       
sampler2D,  sampler3D                               访问2D或者3D纹理      
samplerCube                                                 访问立方图纹理         
samplerCubeShadow                                   访问带有对比的立方图深度纹理      
sampler2DShadow                                          访问带有对比的2D深度纹理      
sampler2DArray                                              访问2D数组纹理            
sampler2DArrayShadow                                访问带有对比的2D数组深度纹理     

有符号整数采样器类型 （不透明）        
isampler2D, isampler3D          访问整数2D或者3D采样器       
isamplerCube                            访问整数立方图纹理       
isampler2DArray                        访问整数2D数组纹理       

无符号整数采样器类型 （不透明）        
usampler2D, usampler3D                  访问无符号整数2D或者3D采样器        
usamplerCube                                    访问无符号整数立方图纹理        
usampler2DArray                                访问无符号整数2D数组纹理        

结构和数组       
结构                struct type-name {        
                            members         
                        }struct-name[ ]; //可选变量声明或者数组       
数组                  float foo[3];               
结构、块和结构成员都可以是数组，只支持一维数组。        

【4】限定符          
存储限定符       
存储限定符可以放在变量声明之前。            
none                                (默认)本地读/写内存，或者输入参数      
const                               编译时常量， 或者只读函数参数     
in                                     从前一个阶段链接到一个着色器       
centriod in                     
out                                  从着色器链接到下一个阶段                   
centriod out                
uniform                            在图元处理中值不改变 ，统一变量组成了着色器、OpenGL ES和应用程序的链接。统一变量存储应用程序通过OpenGL ES 3.0 API传入着色器的只读值，对于保存着色器所需的所有数据类型（如变换矩阵、照明参数和颜色）都很有用。还要注意，统一变量的命名空间在顶点着色器和片段着色器中都是共享的。也就是说，如果顶点和片段着色器一起链接到一个程序对象，它们就会共享同一组统一变量。 统一变量通常保存在硬件中，这个区域被称作“常量存储”，是硬件中为存储常量值而分配的特殊空间。因为常量存储的大小一般是固定的，所以程序中可以使用的统一变量数量受到限制。 单独的统一变量块也可以通过覆盖全局作用域上的默认设置来设置布局。此外，统一变量块中的单独统一变量也可以指定布局限定符。                          

-----------------------------------------------------------------------------------------------------
下面的插值限定符用于着色器输入和输出，可以在in、centriod in、 out或者centriod out 之前。     
在没有限定符时，默认的插值行为是执行平滑着色。也就是说，来自顶点着色器的输出变量在图元中线性插值，片段着色器接受线性插值之后的数值作为输入。
OpenGL ES3.0 还引入了另一种插值  ------ 平面着色。在平面着色中，图元中的值没有进行插值，而是将其中一个顶点视为驱动顶点，该顶点的值被用于图元中的所有片段。
可以用centroid关键字在插值器中添加另一个限定符。本质上，使用多重采样渲染时，centroid关键字可用于强制插值发生在被渲染图元内部（否则,在图元边缘可能出现伪像）。
smooth                          透视校正插值          
flat                                 无插值        

-----------------------------------------------------------------------------------------------------

接口块         
统一变量声明可以组合为命名的接口块 
uniform Transform {     
mat4 ModelViewProjectionMatrix;     
float   Deformation;        
}       

布局限定符       
layout(layout-qualifier) block-declaration      
layout(layout-qualifier) in/out/uniform     
layout(layout-qualifier) in/out/uniform declaration         

输入布局限定符         
对于所有着色器阶段：      
location=整数常量       
输出布局限定符：        
对于所有着色器阶段：      
location=整数常量       

统一变量块布局限定符          
shared： shared限定符指定多个着色器或者多个程序中统一变量块的内存布局相同。要使用这个限定符，不同定义中的row_major/column_major值必须相等。覆盖std140和packed (默认)；        
packed：packed 布局限定符指定编译器可以优化统一变量块的内存布局。使用这个限定符时必须查询偏移位置，而且统一变量块无法在顶点/片段着色器或者程序间共享。
覆盖std140和shared；        
std140：std140布局限定符指定统一变量的布局基于OpenGL ES 3.0规范的 “标准统一变量块布局”一节中定义的一组标准规则。覆盖shared和packed       
row_major： 矩阵在内存中以行优先顺序布局       
column_major：矩阵在内存中以列优先顺序布局（默认）
                            

参数限定符       
输入值在函数调用时复制，输出值在函数返回时复制。        
无                       （默认）与in相同       
in                          用于传入函数的函数参数     
out                        用于传出函数，但是传入时没有初始化的参数     
inout                      用于既传入函数又传出函数的参数      

精度限定符       
任何浮点、整数或者采样器声明都可以在前面加上如下精度限定符：      
highp                              满足顶点语言的最低要求      
mediump                         范围和精度介于lowp和highp之间     
lowp                                范围和精度低于mediump，但是仍然能够表现任何颜色通道的所有颜色值     

不变限定符事例     
#pragma     STDGL invariant (all)               强制所有输出变量不变      
invariant      gl_Position;                             限定之前声明的变量       
invariant      centriod out vec3 color;          限定作为变量声明的一部分       

限定顺序            
存在多个限定时， 它们必须遵循严格的顺序。这个顺序是如下所列的一个：      
不变性，插值，存储，精度        
存储，参数， 精度       

【5】聚合操作和构造器     


【6】语句和结构        


【7】内建输入、输出和常量       
着色器程序使用特殊标量与管线的固定功能部分通信。输出特殊变量可以在写入之后读回。输入特殊变量是只读的。所有特殊变量的作用域都是全局。      

定点着色器特殊变量       
输入：     
int                     gl_VertexID；                //整数索引  
int                     gl_InstanceID;              //实例号       
输出：         
out     gl_PerVertex {      
vec4        gl_Position;                            //变换后的顶点位置，以裁剪坐标表示      
float         gl_PointSize;                         //变换后的点大小，以像素数表示（仅点光栅化）     
}           

片段着色器特殊变量       
输入：         
highp vec4          gl_FragCoord;                //帧缓冲区中的片段位置       
bool                    gl_FrontFacing;             //属于面对图元的片段         
medium vec2     gl_PointCoord;              //每个分量的范围， 从0.0到 1.0        
输出：     
highp float         gl_FragDepth;                 //深度范围        

内建常量和最小值        
const   mediump     int gl_MaxVertexAttribs                                   16        
const   mediump     int gl_MaxVertexUniformVectors                     256          
const   mediump     int gl_MaxVertexOutputVectors                       16      
const   mediump     int gl_MaxFragmentInputVectors                     15       
const   mediump     int gl_MaxVertexTextureImageUnits                 16        
const   mediump     int gl_MaxCombinedTextureImageUnits            32       
const   mediump     int gl_MacTextureImageUnits                            16       
const   mediump     int gl_MacFragmentUmformVectors                 224     
const   mediump     int gl_MaxDrawBuffers                                      4        
const   mediump     int gl_MinProgramTexelOffset                           -8       
const   mediump     int gl_MaxProgramTexelOffset                           7        

内建统一状态          
作为访问OpenGL ES 处理状态的一个辅助手段， OpenGL ES 着色语言内建了统一变量：       
struct gl_DepthRangeParameters {        
float   near;           //n     
float   far;                //f         
float   diff;               //f-n           
}           
uniform gl_DepthRangeParameters     gl_DepthRange       


【8】内建函数         













# GLKit 框架

Speed up OpenGL ES or OpenGL app development. Use math libraries, background texture loading, pre-created shader effects, and a standard view and view controller to implement your rendering loop.

The GLKit framework provides functions and classes that reduce the effort required to create new shader-based apps or to port existing apps that rely on fixed-function vertex or fragment processing provided by earlies version of OpenGL ES or OpenGL.

-----------------------------------------------------------------------------------------------------------------------------
GLKit Features, GLKit provides functionality in four key areas:       
●   Texture loading allows your app to easily load textures from a variety of sources. Textures can even be loaded asynchronously in the background with just a few lines of code. For more information, see GLKTextureLoader.      
●   Math libraries provide commonly used vector, quaternion and matrix operations. These implementations are 
optimized to provide great performance.     
●   Effects provide standard implementations of common shader effects. You configure the effect and the associated vertex data; the effect creates and  loads an appropriate shader. GLKit includes three effects: The GLKBaseEffect class implements a critical subset  of the OpenGL ES 1.1 shading and lighting model, the GLKReflectionMapEffect clas extends the base effect to  include reflection mapping support, and the GLKSkyboxEffect class provides an implementation of a skybox effect.           
●   Views and View Controllers provide a standard implementation of an OpenGL ES view and a corresponding view controller. This reduces the amount of code needed to create an iOS app that use OpenGL ES. For more information, see GLKView and GLKViewController.             

On iOS, GLKit requires an OpenGL ES 2.0 context.        

-----------------------------------------------------------------------------------------------------------------------------
