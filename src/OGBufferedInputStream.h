/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilterInputStream.h"

@class OGCancellable;
@class OGInputStream;

/**
 * Buffered input stream implements #GFilterInputStream and provides
 * for buffered reads.
 * 
 * By default, `GBufferedInputStream`'s buffer size is set at 4 kilobytes.
 * 
 * To create a buffered input stream, use [ctor@Gio.BufferedInputStream.new],
 * or [ctor@Gio.BufferedInputStream.new_sized] to specify the buffer's size at
 * construction.
 * 
 * To get the size of a buffer within a buffered input stream, use
 * [method@Gio.BufferedInputStream.get_buffer_size]. To change the size of a
 * buffered input stream's buffer, use [method@Gio.BufferedInputStream.set_buffer_size].
 * Note that the buffer's size cannot be reduced below the size of the data within the buffer.
 *
 */
@interface OGBufferedInputStream : OGFilterInputStream
{

}


/**
 * Constructors
 */
- (instancetype)init:(OGInputStream*)baseStream;
- (instancetype)initSizedWithBaseStream:(OGInputStream*)baseStream size:(gsize)size;

/**
 * Methods
 */

- (GBufferedInputStream*)castedGObject;

/**
 * Tries to read @count bytes from the stream into the buffer.
 * Will block during this read.
 * 
 * If @count is zero, returns zero and does nothing. A value of @count
 * larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
 * 
 * On success, the number of bytes read into the buffer is returned.
 * It is not an error if this is not the same as the requested size, as it
 * can happen e.g. near the end of a file. Zero is returned on end of file
 * (or if @count is zero),  but never otherwise.
 * 
 * If @count is -1 then the attempted read size is equal to the number of
 * bytes that are required to fill the buffer.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
 * operation was partially finished when the operation was cancelled the
 * partial result will be returned, without an error.
 * 
 * On error -1 is returned and @error is set accordingly.
 * 
 * For the asynchronous, non-blocking, version of this function, see
 * g_buffered_input_stream_fill_async().
 *
 * @param count the number of bytes that will be read from the stream
 * @param cancellable optional #GCancellable object, %NULL to ignore
 * @return the number of bytes read into @stream's buffer, up to @count,
 *     or -1 on error.
 */
- (gssize)fillWithCount:(gssize)count cancellable:(OGCancellable*)cancellable;

/**
 * Reads data into @stream's buffer asynchronously, up to @count size.
 * @io_priority can be used to prioritize reads. For the synchronous
 * version of this function, see g_buffered_input_stream_fill().
 * 
 * If @count is -1 then the attempted read size is equal to the number
 * of bytes that are required to fill the buffer.
 *
 * @param count the number of bytes that will be read from the stream
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional #GCancellable object
 * @param callback a #GAsyncReadyCallback
 * @param userData a #gpointer
 */
- (void)fillAsyncWithCount:(gssize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an asynchronous read.
 *
 * @param result a #GAsyncResult
 * @return a #gssize of the read stream, or `-1` on an error.
 */
- (gssize)fillFinish:(GAsyncResult*)result;

/**
 * Gets the size of the available data within the stream.
 *
 * @return size of the available stream.
 */
- (gsize)available;

/**
 * Gets the size of the input buffer.
 *
 * @return the current buffer size.
 */
- (gsize)bufferSize;

/**
 * Peeks in the buffer, copying data of size @count into @buffer,
 * offset @offset bytes.
 *
 * @param buffer a pointer to
 *   an allocated chunk of memory
 * @param offset a #gsize
 * @param count a #gsize
 * @return a #gsize of the number of bytes peeked, or -1 on error.
 */
- (gsize)peekWithBuffer:(void*)buffer offset:(gsize)offset count:(gsize)count;

/**
 * Returns the buffer with the currently available bytes. The returned
 * buffer must not be modified and will become invalid when reading from
 * the stream or filling the buffer.
 *
 * @param count a #gsize to get the number of bytes available in the buffer
 * @return read-only buffer
 */
- (void*)peekBuffer:(gsize*)count;

/**
 * Tries to read a single byte from the stream or the buffer. Will block
 * during this read.
 * 
 * On success, the byte read from the stream is returned. On end of stream
 * -1 is returned but it's not an exceptional error and @error is not set.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
 * operation was partially finished when the operation was cancelled the
 * partial result will be returned, without an error.
 * 
 * On error -1 is returned and @error is set accordingly.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore
 * @return the byte read from the @stream, or -1 on end of stream or error.
 */
- (int)readByte:(OGCancellable*)cancellable;

/**
 * Sets the size of the internal buffer of @stream to @size, or to the
 * size of the contents of the buffer. The buffer can never be resized
 * smaller than its current contents.
 *
 * @param size a #gsize
 */
- (void)setBufferSize:(gsize)size;

@end