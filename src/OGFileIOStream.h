/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGIOStream.h"

@class OGCancellable;
@class OGFileInfo;

/**
 * `GFileIOStream` provides I/O streams that both read and write to the same
 * file handle.
 * 
 * `GFileIOStream` implements [iface@Gio.Seekable], which allows the I/O
 * stream to jump to arbitrary positions in the file and to truncate
 * the file, provided the filesystem of the file supports these
 * operations.
 * 
 * To find the position of a file I/O stream, use [method@Gio.Seekable.tell].
 * 
 * To find out if a file I/O stream supports seeking, use
 * [method@Gio.Seekable.can_seek]. To position a file I/O stream, use
 * [method@Gio.Seekable.seek]. To find out if a file I/O stream supports
 * truncating, use [method@Gio.Seekable.can_truncate]. To truncate a file I/O
 * stream, use [method@Gio.Seekable.truncate].
 * 
 * The default implementation of all the `GFileIOStream` operations
 * and the implementation of [iface@Gio.Seekable] just call into the same
 * operations on the output stream.
 *
 */
@interface OGFileIOStream : OGIOStream
{

}


/**
 * Methods
 */

- (GFileIOStream*)castedGObject;

/**
 * Gets the entity tag for the file when it has been written.
 * This must be called after the stream has been written
 * and closed, as the etag can change while writing.
 *
 * @return the entity tag for the stream.
 */
- (char*)etag;

/**
 * Queries a file io stream for the given @attributes.
 * This function blocks while querying the stream. For the asynchronous
 * version of this function, see g_file_io_stream_query_info_async().
 * While the stream is blocked, the stream will set the pending flag
 * internally, and any other operations on the stream will fail with
 * %G_IO_ERROR_PENDING.
 * 
 * Can fail if the stream was already closed (with @error being set to
 * %G_IO_ERROR_CLOSED), the stream has pending operations (with @error being
 * set to %G_IO_ERROR_PENDING), or if querying info is not supported for
 * the stream's interface (with @error being set to %G_IO_ERROR_NOT_SUPPORTED). I
 * all cases of failure, %NULL will be returned.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be set, and %NULL will
 * be returned.
 *
 * @param attributes a file attribute query string.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a #GFileInfo for the @stream, or %NULL on error.
 */
- (OGFileInfo*)queryInfoWithAttributes:(OFString*)attributes cancellable:(OGCancellable*)cancellable;

/**
 * Asynchronously queries the @stream for a #GFileInfo. When completed,
 * @callback will be called with a #GAsyncResult which can be used to
 * finish the operation with g_file_io_stream_query_info_finish().
 * 
 * For the synchronous version of this function, see
 * g_file_io_stream_query_info().
 *
 * @param attributes a file attribute query string.
 * @param ioPriority the [I/O priority](iface.AsyncResult.html#io-priority) of the
 *   request
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)queryInfoAsyncWithAttributes:(OFString*)attributes ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finalizes the asynchronous query started
 * by g_file_io_stream_query_info_async().
 *
 * @param result a #GAsyncResult.
 * @return A #GFileInfo for the finished query.
 */
- (OGFileInfo*)queryInfoFinish:(GAsyncResult*)result;

@end