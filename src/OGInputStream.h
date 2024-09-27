/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>

#import <OGObject/OGObject.h>

@class OGCancellable;

/**
 * `GInputStream` is a base class for implementing streaming input.
 * 
 * It has functions to read from a stream ([method@Gio.InputStream.read]),
 * to close a stream ([method@Gio.InputStream.close]) and to skip some content
 * ([method@Gio.InputStream.skip]).
 * 
 * To copy the content of an input stream to an output stream without
 * manually handling the reads and writes, use [method@Gio.OutputStream.splice].
 * 
 * See the documentation for [class@Gio.IOStream] for details of thread safety
 * of streaming APIs.
 * 
 * All of these functions have async variants too.
 *
 */
@interface OGInputStream : OGObject
{

}


/**
 * Methods
 */

- (GInputStream*)castedGObject;

/**
 * Clears the pending flag on @stream.
 *
 */
- (void)clearPending;

/**
 * Closes the stream, releasing resources related to it.
 * 
 * Once the stream is closed, all other operations will return %G_IO_ERROR_CLOSED.
 * Closing a stream multiple times will not return an error.
 * 
 * Streams will be automatically closed when the last reference
 * is dropped, but you might want to call this function to make sure
 * resources are released as early as possible.
 * 
 * Some streams might keep the backing store of the stream (e.g. a file descriptor)
 * open after the stream is closed. See the documentation for the individual
 * stream for details.
 * 
 * On failure the first error that happened will be reported, but the close
 * operation will finish as much as possible. A stream that failed to
 * close will still return %G_IO_ERROR_CLOSED for all operations. Still, it
 * is important to check and report the error to the user.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 * Cancelling a close will still leave the stream closed, but some streams
 * can use a faster close that doesn't block to e.g. check errors.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE on success, %FALSE on failure
 */
- (bool)close:(OGCancellable*)cancellable;

/**
 * Requests an asynchronous closes of the stream, releasing resources related to it.
 * When the operation is finished @callback will be called.
 * You can then call g_input_stream_close_finish() to get the result of the
 * operation.
 * 
 * For behaviour details see g_input_stream_close().
 * 
 * The asynchronous methods have a default fallback that uses threads to implement
 * asynchronicity, so they are optional for inheriting classes. However, if you
 * override one you must override all.
 *
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional cancellable object
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes closing a stream asynchronously, started from g_input_stream_close_async().
 *
 * @param result a #GAsyncResult.
 * @return %TRUE if the stream was closed successfully.
 */
- (bool)closeFinish:(GAsyncResult*)result;

/**
 * Checks if an input stream has pending actions.
 *
 * @return %TRUE if @stream has pending actions.
 */
- (bool)hasPending;

/**
 * Checks if an input stream is closed.
 *
 * @return %TRUE if the stream is closed.
 */
- (bool)isClosed;

/**
 * Tries to read @count bytes from the stream into the buffer starting at
 * @buffer. Will block during this read.
 * 
 * If count is zero returns zero and does nothing. A value of @count
 * larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
 * 
 * On success, the number of bytes read into the buffer is returned.
 * It is not an error if this is not the same as the requested size, as it
 * can happen e.g. near the end of a file. Zero is returned on end of file
 * (or if @count is zero),  but never otherwise.
 * 
 * The returned @buffer is not a nul-terminated string, it can contain nul bytes
 * at any position, and this function doesn't nul-terminate the @buffer.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
 * operation was partially finished when the operation was cancelled the
 * partial result will be returned, without an error.
 * 
 * On error -1 is returned and @error is set accordingly.
 *
 * @param buffer a buffer to read data into (which should be at least count bytes long).
 * @param count the number of bytes that will be read from the stream
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return Number of bytes read, or -1 on error, or 0 on end of file.
 */
- (gssize)readWithBuffer:(void*)buffer count:(gsize)count cancellable:(OGCancellable*)cancellable;

/**
 * Tries to read @count bytes from the stream into the buffer starting at
 * @buffer. Will block during this read.
 * 
 * This function is similar to g_input_stream_read(), except it tries to
 * read as many bytes as requested, only stopping on an error or end of stream.
 * 
 * On a successful read of @count bytes, or if we reached the end of the
 * stream,  %TRUE is returned, and @bytes_read is set to the number of bytes
 * read into @buffer.
 * 
 * If there is an error during the operation %FALSE is returned and @error
 * is set to indicate the error status.
 * 
 * As a special exception to the normal conventions for functions that
 * use #GError, if this function returns %FALSE (and sets @error) then
 * @bytes_read will be set to the number of bytes that were successfully
 * read before the error was encountered.  This functionality is only
 * available from C.  If you need it from another language then you must
 * write your own loop around g_input_stream_read().
 *
 * @param buffer a buffer to read data into (which should be at least count bytes long).
 * @param count the number of bytes that will be read from the stream
 * @param bytesRead location to store the number of bytes that was read from the stream
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE on success, %FALSE if there was an error
 */
- (bool)readAllWithBuffer:(void*)buffer count:(gsize)count bytesRead:(gsize*)bytesRead cancellable:(OGCancellable*)cancellable;

/**
 * Request an asynchronous read of @count bytes from the stream into the
 * buffer starting at @buffer.
 * 
 * This is the asynchronous equivalent of g_input_stream_read_all().
 * 
 * Call g_input_stream_read_all_finish() to collect the result.
 * 
 * Any outstanding I/O request with higher priority (lower numerical
 * value) will be executed before an outstanding request with lower
 * priority. Default priority is %G_PRIORITY_DEFAULT.
 *
 * @param buffer a buffer to read data into (which should be at least count bytes long)
 * @param count the number of bytes that will be read from the stream
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)readAllAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an asynchronous stream read operation started with
 * g_input_stream_read_all_async().
 * 
 * As a special exception to the normal conventions for functions that
 * use #GError, if this function returns %FALSE (and sets @error) then
 * @bytes_read will be set to the number of bytes that were successfully
 * read before the error was encountered.  This functionality is only
 * available from C.  If you need it from another language then you must
 * write your own loop around g_input_stream_read_async().
 *
 * @param result a #GAsyncResult
 * @param bytesRead location to store the number of bytes that was read from the stream
 * @return %TRUE on success, %FALSE if there was an error
 */
- (bool)readAllFinishWithResult:(GAsyncResult*)result bytesRead:(gsize*)bytesRead;

/**
 * Request an asynchronous read of @count bytes from the stream into the buffer
 * starting at @buffer. When the operation is finished @callback will be called.
 * You can then call g_input_stream_read_finish() to get the result of the
 * operation.
 * 
 * During an async request no other sync and async calls are allowed on @stream, and will
 * result in %G_IO_ERROR_PENDING errors.
 * 
 * A value of @count larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
 * 
 * On success, the number of bytes read into the buffer will be passed to the
 * callback. It is not an error if this is not the same as the requested size, as it
 * can happen e.g. near the end of a file, but generally we try to read
 * as many bytes as requested. Zero is returned on end of file
 * (or if @count is zero),  but never otherwise.
 * 
 * Any outstanding i/o request with higher priority (lower numerical value) will
 * be executed before an outstanding request with lower priority. Default
 * priority is %G_PRIORITY_DEFAULT.
 * 
 * The asynchronous methods have a default fallback that uses threads to implement
 * asynchronicity, so they are optional for inheriting classes. However, if you
 * override one you must override all.
 *
 * @param buffer a buffer to read data into (which should be at least count bytes long).
 * @param count the number of bytes that will be read from the stream
 * @param ioPriority the [I/O priority][io-priority]
 * of the request.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)readAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Like g_input_stream_read(), this tries to read @count bytes from
 * the stream in a blocking fashion. However, rather than reading into
 * a user-supplied buffer, this will create a new #GBytes containing
 * the data that was read. This may be easier to use from language
 * bindings.
 * 
 * If count is zero, returns a zero-length #GBytes and does nothing. A
 * value of @count larger than %G_MAXSSIZE will cause a
 * %G_IO_ERROR_INVALID_ARGUMENT error.
 * 
 * On success, a new #GBytes is returned. It is not an error if the
 * size of this object is not the same as the requested size, as it
 * can happen e.g. near the end of a file. A zero-length #GBytes is
 * returned on end of file (or if @count is zero), but never
 * otherwise.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
 * operation was partially finished when the operation was cancelled the
 * partial result will be returned, without an error.
 * 
 * On error %NULL is returned and @error is set accordingly.
 *
 * @param count maximum number of bytes that will be read from the stream. Common
 * values include 4096 and 8192.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a new #GBytes, or %NULL on error
 */
- (GBytes*)readBytesWithCount:(gsize)count cancellable:(OGCancellable*)cancellable;

/**
 * Request an asynchronous read of @count bytes from the stream into a
 * new #GBytes. When the operation is finished @callback will be
 * called. You can then call g_input_stream_read_bytes_finish() to get the
 * result of the operation.
 * 
 * During an async request no other sync and async calls are allowed
 * on @stream, and will result in %G_IO_ERROR_PENDING errors.
 * 
 * A value of @count larger than %G_MAXSSIZE will cause a
 * %G_IO_ERROR_INVALID_ARGUMENT error.
 * 
 * On success, the new #GBytes will be passed to the callback. It is
 * not an error if this is smaller than the requested size, as it can
 * happen e.g. near the end of a file, but generally we try to read as
 * many bytes as requested. Zero is returned on end of file (or if
 * @count is zero), but never otherwise.
 * 
 * Any outstanding I/O request with higher priority (lower numerical
 * value) will be executed before an outstanding request with lower
 * priority. Default priority is %G_PRIORITY_DEFAULT.
 *
 * @param count the number of bytes that will be read from the stream
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)readBytesAsyncWithCount:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an asynchronous stream read-into-#GBytes operation.
 *
 * @param result a #GAsyncResult.
 * @return the newly-allocated #GBytes, or %NULL on error
 */
- (GBytes*)readBytesFinish:(GAsyncResult*)result;

/**
 * Finishes an asynchronous stream read operation.
 *
 * @param result a #GAsyncResult.
 * @return number of bytes read in, or -1 on error, or 0 on end of file.
 */
- (gssize)readFinish:(GAsyncResult*)result;

/**
 * Sets @stream to have actions pending. If the pending flag is
 * already set or @stream is closed, it will return %FALSE and set
 * @error.
 *
 * @return %TRUE if pending was previously unset and is now set.
 */
- (bool)setPending;

/**
 * Tries to skip @count bytes from the stream. Will block during the operation.
 * 
 * This is identical to g_input_stream_read(), from a behaviour standpoint,
 * but the bytes that are skipped are not returned to the user. Some
 * streams have an implementation that is more efficient than reading the data.
 * 
 * This function is optional for inherited classes, as the default implementation
 * emulates it using read.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
 * operation was partially finished when the operation was cancelled the
 * partial result will be returned, without an error.
 *
 * @param count the number of bytes that will be skipped from the stream
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return Number of bytes skipped, or -1 on error
 */
- (gssize)skipWithCount:(gsize)count cancellable:(OGCancellable*)cancellable;

/**
 * Request an asynchronous skip of @count bytes from the stream.
 * When the operation is finished @callback will be called.
 * You can then call g_input_stream_skip_finish() to get the result
 * of the operation.
 * 
 * During an async request no other sync and async calls are allowed,
 * and will result in %G_IO_ERROR_PENDING errors.
 * 
 * A value of @count larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
 * 
 * On success, the number of bytes skipped will be passed to the callback.
 * It is not an error if this is not the same as the requested size, as it
 * can happen e.g. near the end of a file, but generally we try to skip
 * as many bytes as requested. Zero is returned on end of file
 * (or if @count is zero), but never otherwise.
 * 
 * Any outstanding i/o request with higher priority (lower numerical value)
 * will be executed before an outstanding request with lower priority.
 * Default priority is %G_PRIORITY_DEFAULT.
 * 
 * The asynchronous methods have a default fallback that uses threads to
 * implement asynchronicity, so they are optional for inheriting classes.
 * However, if you override one, you must override all.
 *
 * @param count the number of bytes that will be skipped from the stream
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)skipAsyncWithCount:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes a stream skip operation.
 *
 * @param result a #GAsyncResult.
 * @return the size of the bytes skipped, or `-1` on error.
 */
- (gssize)skipFinish:(GAsyncResult*)result;

@end