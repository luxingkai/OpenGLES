//
//  GLKUsageController.m
//  OpenGL_ES Usage
//
//  Created by tigerfly on 2020/7/1.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "GLKUsageController.h"

@interface GLKUsageController ()

@end

@implementation GLKUsageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
#pragma mark -- Texture Loading
    
    /*
     GLKTextureInfo
     When your app loads textures using the GLKTextureLoader class, the texture loader return information about the textures using GLKTextureInfo objects. Your app never creates GLKTextureInfo objects directly.
     */
    
    // Reading Texture Information
    //    textureInfo.name
    //    textureInfo.target
    //    textureInfo.height
    //    textureInfo.width
    //    textureInfo.textureOrigin
    //    textureInfo.alphaState
    //    textureInfo.containsMipmaps
    
    // Constants
    //    GLKTextureInfoAlphaState
    //    GLKTextureInfoOrigin
    
    /*
     GLKTextureLoader
     A utility class that simplifies loading OpenGL or OpenGL ES texture datas from a variety of image file formats.
     The GLKTextureLoader class can load two-dimensional or cubemap textures in most image formats supported by the Image I/O framework. In iOS, it can also load textures compressed in the PVRTC format. It can load the data synchronously or asynchronously.
     */
    
    
    
#pragma mark -- OpenGL ES View Rendering
    
    /*
     GLKView
     A default implementation for views that draw their content using OpenGL ES.
     The GLKView class simplifies the effort required to create an OpenGL ES application by directly
     managing a framebuffer object on your behalf; your application simply needs to draw into the framebuffer when the contents need to be updated.
     */
    /*
     Important
     Your drawing method should only modify the  contents of the framebuffer object. Never attempt to read the pixel information from the underlying framebuffer object, modify or dispose of the framebuffer object, or read its other properties by calling OpenGL ES funtions. Instead, rely on the properties and methods provided by the GLKView class.
     */
    
    /*
     GLKViewController
     A view Controller that manages an OpenGL ES rendering loop.
     A GLKViewController object works in conjunction with a GLKView object to display frames of animation in the view, and also provides standard view controller functionality.
     To use this class, allocate and initialize a new GLKViewController subclass and set its view property to point to a GLKView object. then configure the view controller's perferredFramesPerSecond property to the desired frame rate your application requires. You can set a delegate or configure other properties on the view Controller, such as weather the animation loop is automatically paused or resumed when the application moves into the background.
     
     When active, rendering loop automatically updates the view's contents each time a new frame must be displayed. Each frame is rendered by the view controller using these steps:
     1. The view controller calls its delegate's glkViewControllerUpdate(_:)method. Your delegate should update frame data that does not involve rendering the results to the screen.
     2. The view controller calls its view's display() method. Your view should redraw the frame.
     */
    
    /*
     Subclassing Notes
     Your application should subclass GLKViewController and override the viewDidLoad() and viewDidUnload() methods. Your viewDidLoad() method should setup your context and any drawable properties and can perform other resource allocation and initialization.
     Similarly, your class's viewDidUnload() method should delete the drawable object and free any unneeded resources.
     As an alternative to implementing a glkViewControllerUpdate(_:) method in a delegate, your subclass can provide an update method instead. The method must have the following signature:
     - (void)update;
     */
    
#pragma mark -- Mesh Date Management
    
    
#pragma mark -- Shader-Based Rendering Effects
    
    
#pragma mark -- Rendering Effect Parameters
    
    
#pragma mark -- Math Utilities
    
    
    
    
    
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
