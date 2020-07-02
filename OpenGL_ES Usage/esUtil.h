//
//  esUtil.h
//  OpenGL_ES Usage
//
//  Created by tigerfly on 2020/7/1.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#ifndef esUtil_h
#define esUtil_h

#include <stdio.h>
#include <stdlib.h>
#include <OpenGLES/gltypes.h>
#include <OpenGLES/ES3/glext.h>
#include <OpenGLES/ES3/gl.h>

GLuint esLoadShader(GLenum type, const char *shaderSrc);
GLuint esLoadProgram(const char *vertShaderSrc, const char *fragShaderSrc);


#endif /* esUtil_h */
