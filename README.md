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


