/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGIOStream.h"

@class OGInputStream;
@class OGOutputStream;

/**
 * GSimpleIOStream creates a #GIOStream from an arbitrary #GInputStream and
 * #GOutputStream. This allows any pair of input and output streams to be used
 * with #GIOStream methods.
 * 
 * This is useful when you obtained a #GInputStream and a #GOutputStream
 * by other means, for instance creating them with platform specific methods as
 * g_unix_input_stream_new() or g_win32_input_stream_new(), and you want
 * to take advantage of the methods provided by #GIOStream.
 *
 */
@interface OGSimpleIOStream : OGIOStream
{

}


/**
 * Constructors
 */
- (instancetype)initWithInputStream:(OGInputStream*)inputStream outputStream:(OGOutputStream*)outputStream;

/**
 * Methods
 */

- (GSimpleIOStream*)castedGObject;

@end