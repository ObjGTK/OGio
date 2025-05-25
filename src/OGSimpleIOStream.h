/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGIOStream.h"

@class OGInputStream;
@class OGOutputStream;

/**
 * `GSimpleIOStream` creates a [class@Gio.IOStream] from an arbitrary
 * [class@Gio.InputStream] and [class@Gio.OutputStream]. This allows any pair of
 * input and output streams to be used with [class@Gio.IOStream] methods.
 * 
 * This is useful when you obtained a [class@Gio.InputStream] and a
 * [class@Gio.OutputStream] by other means, for instance creating them with
 * platform specific methods as
 * [`g_unix_input_stream_new()`](../gio-unix/ctor.UnixInputStream.new.html)
 * (from `gio-unix-2.0.pc` / `GioUnix-2.0`), and you want to
 * take advantage of the methods provided by [class@Gio.IOStream].
 *
 */
@interface OGSimpleIOStream : OGIOStream
{

}

/**
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Constructors
 */
+ (instancetype)simpleIOStreamWithInputStream:(OGInputStream*)inputStream outputStream:(OGOutputStream*)outputStream;

/**
 * Methods
 */

- (GSimpleIOStream*)castedGObject;

@end