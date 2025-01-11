/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGOutputStream.h"

/**
 * `GMemoryOutputStream` is a class for using arbitrary
 * memory chunks as output for GIO streaming output operations.
 * 
 * As of GLib 2.34, `GMemoryOutputStream` trivially implements
 * [iface@Gio.PollableOutputStream]: it always polls as ready.
 *
 */
@interface OGMemoryOutputStream : OGOutputStream
{

}


/**
 * Constructors
 */
+ (instancetype)memoryOutputStreamWithData:(gpointer)data size:(gsize)size reallocFunction:(GReallocFunc)reallocFunction destroyFunction:(GDestroyNotify)destroyFunction;
+ (instancetype)memoryOutputStreamResizable;

/**
 * Methods
 */

- (GMemoryOutputStream*)castedGObject;

/**
 * Gets any loaded data from the @ostream.
 * 
 * Note that the returned pointer may become invalid on the next
 * write or truncate operation on the stream.
 *
 * @return pointer to the stream's data, or %NULL if the data
 *    has been stolen
 */
- (gpointer)data;

/**
 * Returns the number of bytes from the start up to including the last
 * byte written in the stream that has not been truncated away.
 *
 * @return the number of bytes written to the stream
 */
- (gsize)dataSize;

/**
 * Gets the size of the currently allocated data area (available from
 * g_memory_output_stream_get_data()).
 * 
 * You probably don't want to use this function on resizable streams.
 * See g_memory_output_stream_get_data_size() instead.  For resizable
 * streams the size returned by this function is an implementation
 * detail and may be change at any time in response to operations on the
 * stream.
 * 
 * If the stream is fixed-sized (ie: no realloc was passed to
 * g_memory_output_stream_new()) then this is the maximum size of the
 * stream and further writes will return %G_IO_ERROR_NO_SPACE.
 * 
 * In any case, if you want the number of bytes currently written to the
 * stream, use g_memory_output_stream_get_data_size().
 *
 * @return the number of bytes allocated for the data buffer
 */
- (gsize)size;

/**
 * Returns data from the @ostream as a #GBytes. @ostream must be
 * closed before calling this function.
 *
 * @return the stream's data
 */
- (GBytes*)stealAsBytes;

/**
 * Gets any loaded data from the @ostream. Ownership of the data
 * is transferred to the caller; when no longer needed it must be
 * freed using the free function set in @ostream's
 * #GMemoryOutputStream:destroy-function property.
 * 
 * @ostream must be closed before calling this function.
 *
 * @return the stream's data, or %NULL if it has previously
 *    been stolen
 */
- (gpointer)stealData;

@end