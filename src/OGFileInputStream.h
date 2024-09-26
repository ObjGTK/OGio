/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInputStream.h"

@class OGFileInfo;
@class OGCancellable;

/**
 * `GFileInputStream` provides input streams that take their
 * content from a file.
 * 
 * `GFileInputStream` implements [iface@Gio.Seekable], which allows the input
 * stream to jump to arbitrary positions in the file, provided the
 * filesystem of the file allows it. To find the position of a file
 * input stream, use [method@Gio.Seekable.tell]. To find out if a file input
 * stream supports seeking, use [vfunc@Gio.Seekable.can_seek].
 * To position a file input stream, use [vfunc@Gio.Seekable.seek].
 *
 */
@interface OGFileInputStream : OGInputStream
{

}


/**
 * Methods
 */

- (GFileInputStream*)castedGObject;

/**
 * Queries a file input stream the given @attributes. This function blocks
 * while querying the stream. For the asynchronous (non-blocking) version
 * of this function, see g_file_input_stream_query_info_async(). While the
 * stream is blocked, the stream will set the pending flag internally, and
 * any other operations on the stream will fail with %G_IO_ERROR_PENDING.
 *
 * @param attributes a file attribute query string.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a #GFileInfo, or %NULL on error.
 */
- (OGFileInfo*)queryInfoWithAttributes:(OFString*)attributes cancellable:(OGCancellable*)cancellable;

/**
 * Queries the stream information asynchronously.
 * When the operation is finished @callback will be called.
 * You can then call g_file_input_stream_query_info_finish()
 * to get the result of the operation.
 * 
 * For the synchronous version of this function,
 * see g_file_input_stream_query_info().
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be set
 *
 * @param attributes a file attribute query string.
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)queryInfoAsyncWithAttributes:(OFString*)attributes ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an asynchronous info query operation.
 *
 * @param result a #GAsyncResult.
 * @return #GFileInfo.
 */
- (OGFileInfo*)queryInfoFinish:(GAsyncResult*)result;

@end