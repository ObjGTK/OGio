/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilterOutputStream.h"

@class OGOutputStream;

/**
 * Buffered output stream implements [class@Gio.FilterOutputStream] and provides
 * for buffered writes.
 * 
 * By default, `GBufferedOutputStream`'s buffer size is set at 4 kilobytes.
 * 
 * To create a buffered output stream, use [ctor@Gio.BufferedOutputStream.new],
 * or [ctor@Gio.BufferedOutputStream.new_sized] to specify the buffer's size
 * at construction.
 * 
 * To get the size of a buffer within a buffered input stream, use
 * [method@Gio.BufferedOutputStream.get_buffer_size]. To change the size of a
 * buffered output stream's buffer, use [method@Gio.BufferedOutputStream.set_buffer_size].
 * Note that the buffer's size cannot be reduced below the size of the data within the buffer.
 *
 */
@interface OGBufferedOutputStream : OGFilterOutputStream
{

}


/**
 * Constructors
 */
- (instancetype)initWithBaseStream:(OGOutputStream*)baseStream;
- (instancetype)initSizedWithBaseStream:(OGOutputStream*)baseStream size:(gsize)size;

/**
 * Methods
 */

- (GBufferedOutputStream*)castedGObject;

/**
 * Checks if the buffer automatically grows as data is added.
 *
 * @return %TRUE if the @stream's buffer automatically grows,
 * %FALSE otherwise.
 */
- (bool)autoGrow;

/**
 * Gets the size of the buffer in the @stream.
 *
 * @return the current size of the buffer.
 */
- (gsize)bufferSize;

/**
 * Sets whether or not the @stream's buffer should automatically grow.
 * If @auto_grow is true, then each write will just make the buffer
 * larger, and you must manually flush the buffer to actually write out
 * the data to the underlying stream.
 *
 * @param autoGrow a #gboolean.
 */
- (void)setAutoGrow:(bool)autoGrow;

/**
 * Sets the size of the internal buffer to @size.
 *
 * @param size a #gsize.
 */
- (void)setBufferSize:(gsize)size;

@end