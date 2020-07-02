# OpenGL_ES_Usage
图形库使用

# OpenGL ES 3.0



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



【3】类型       


【4】限定符      


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



