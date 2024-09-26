/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixmounts.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>

#import <OGObject/OGObject.h>

@class OGCancellable;
@class OGInputStream;

/**
 * `GOutputStream` is a base class for implementing streaming output.
 * 
 * It has functions to write to a stream ([method@Gio.OutputStream.write]),
 * to close a stream ([method@Gio.OutputStream.close]) and to flush pending
 * writes ([method@Gio.OutputStream.flush]).
 * 
 * To copy the content of an input stream to an output stream without
 * manually handling the reads and writes, use [method@Gio.OutputStream.splice].
 * 
 * See the documentation for [class@Gio.IOStream] for details of thread safety
 * of streaming APIs.
 * 
 * All of these functions have async variants too.
 * 
 * All classes derived from `GOutputStream` *should* implement synchronous
 * writing, splicing, flushing and closing streams, but *may* implement
 * asynchronous versions.
 *
 */
@interface OGOutputStream : OGObject
{

}


/**
 * Methods
 */

- (GOutputStream*)castedGObject;

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
 * Closing a stream will automatically flush any outstanding buffers in the
 * stream.
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
 * is important to check and report the error to the user, otherwise
 * there might be a loss of data as all data might not be written.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 * Cancelling a close will still leave the stream closed, but there some streams
 * can use a faster close that doesn't block to e.g. check errors. On
 * cancellation (as with any error) there is no guarantee that all written
 * data will reach the target.
 *
 * @param cancellable optional cancellable object
 * @return %TRUE on success, %FALSE on failure
 */
- (bool)close:(OGCancellable*)cancellable;

/**
 * Requests an asynchronous close of the stream, releasing resources
 * related to it. When the operation is finished @callback will be
 * called. You can then call g_output_stream_close_finish() to get
 * the result of the operation.
 * 
 * For behaviour details see g_output_stream_close().
 * 
 * The asynchronous methods have a default fallback that uses threads
 * to implement asynchronicity, so they are optional for inheriting
 * classes. However, if you override one you must override all.
 *
 * @param ioPriority the io priority of the request.
 * @param cancellable optional cancellable object
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Closes an output stream.
 *
 * @param result a #GAsyncResult.
 * @return %TRUE if stream was successfully closed, %FALSE otherwise.
 */
- (bool)closeFinish:(GAsyncResult*)result;

/**
 * Forces a write of all user-space buffered data for the given
 * @stream. Will block during the operation. Closing the stream will
 * implicitly cause a flush.
 * 
 * This function is optional for inherited classes.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 *
 * @param cancellable optional cancellable object
 * @return %TRUE on success, %FALSE on error
 */
- (bool)flush:(OGCancellable*)cancellable;

/**
 * Forces an asynchronous write of all user-space buffered data for
 * the given @stream.
 * For behaviour details see g_output_stream_flush().
 * 
 * When the operation is finished @callback will be
 * called. You can then call g_output_stream_flush_finish() to get the
 * result of the operation.
 *
 * @param ioPriority the io priority of the request.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)flushAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes flushing an output stream.
 *
 * @param result a GAsyncResult.
 * @return %TRUE if flush operation succeeded, %FALSE otherwise.
 */
- (bool)flushFinish:(GAsyncResult*)result;

/**
 * Checks if an output stream has pending actions.
 *
 * @return %TRUE if @stream has pending actions.
 */
- (bool)hasPending;

/**
 * Checks if an output stream has already been closed.
 *
 * @return %TRUE if @stream is closed. %FALSE otherwise.
 */
- (bool)isClosed;

/**
 * Checks if an output stream is being closed. This can be
 * used inside e.g. a flush implementation to see if the
 * flush (or other i/o operation) is called from within
 * the closing operation.
 *
 * @return %TRUE if @stream is being closed. %FALSE otherwise.
 */
- (bool)isClosing;

/**
 * Sets @stream to have actions pending. If the pending flag is
 * already set or @stream is closed, it will return %FALSE and set
 * @error.
 *
 * @return %TRUE if pending was previously unset and is now set.
 */
- (bool)setPending;

/**
 * Splices an input stream into an output stream.
 *
 * @param source a #GInputStream.
 * @param flags a set of #GOutputStreamSpliceFlags.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a #gssize containing the size of the data spliced, or
 *     -1 if an error occurred. Note that if the number of bytes
 *     spliced is greater than %G_MAXSSIZE, then that will be
 *     returned, and there is no way to determine the actual number
 *     of bytes spliced.
 */
- (gssize)spliceWithSource:(OGInputStream*)source flags:(GOutputStreamSpliceFlags)flags cancellable:(OGCancellable*)cancellable;

/**
 * Splices a stream asynchronously.
 * When the operation is finished @callback will be called.
 * You can then call g_output_stream_splice_finish() to get the
 * result of the operation.
 * 
 * For the synchronous, blocking version of this function, see
 * g_output_stream_splice().
 *
 * @param source a #GInputStream.
 * @param flags a set of #GOutputStreamSpliceFlags.
 * @param ioPriority the io priority of the request.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)spliceAsyncWithSource:(OGInputStream*)source flags:(GOutputStreamSpliceFlags)flags ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an asynchronous stream splice operation.
 *
 * @param result a #GAsyncResult.
 * @return a #gssize of the number of bytes spliced. Note that if the
 *     number of bytes spliced is greater than %G_MAXSSIZE, then that
 *     will be returned, and there is no way to determine the actual
 *     number of bytes spliced.
 */
- (gssize)spliceFinish:(GAsyncResult*)result;

/**
 * This is a utility function around g_output_stream_write_all(). It
 * uses g_strdup_vprintf() to turn @format and @args into a string that
 * is then written to @stream.
 * 
 * See the documentation of g_output_stream_write_all() about the
 * behavior of the actual write operation.
 * 
 * Note that partial writes cannot be properly checked with this
 * function due to the variable length of the written string, if you
 * need precise control over partial write failures, you need to
 * create you own printf()-like wrapper around g_output_stream_write()
 * or g_output_stream_write_all().
 *
 * @param bytesWritten location to store the number of bytes that was
 *     written to the stream
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param error location to store the error occurring, or %NULL to ignore
 * @param format the format string. See the printf() documentation
 * @param args the parameters to insert into the format string
 * @return %TRUE on success, %FALSE if there was an error
 */
- (bool)vprintfWithBytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable error:(GError**)error format:(OFString*)format args:(va_list)args;

/**
 * Tries to write @count bytes from @buffer into the stream. Will block
 * during the operation.
 * 
 * If count is 0, returns 0 and does nothing. A value of @count
 * larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
 * 
 * On success, the number of bytes written to the stream is returned.
 * It is not an error if this is not the same as the requested size, as it
 * can happen e.g. on a partial I/O error, or if there is not enough
 * storage in the stream. All writes block until at least one byte
 * is written or an error occurs; 0 is never returned (unless
 * @count is 0).
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
 * operation was partially finished when the operation was cancelled the
 * partial result will be returned, without an error.
 * 
 * On error -1 is returned and @error is set accordingly.
 *
 * @param buffer the buffer containing the data to write.
 * @param count the number of bytes to write
 * @param cancellable optional cancellable object
 * @return Number of bytes written, or -1 on error
 */
- (gssize)writeWithBuffer:(void*)buffer count:(gsize)count cancellable:(OGCancellable*)cancellable;

/**
 * Tries to write @count bytes from @buffer into the stream. Will block
 * during the operation.
 * 
 * This function is similar to g_output_stream_write(), except it tries to
 * write as many bytes as requested, only stopping on an error.
 * 
 * On a successful write of @count bytes, %TRUE is returned, and @bytes_written
 * is set to @count.
 * 
 * If there is an error during the operation %FALSE is returned and @error
 * is set to indicate the error status.
 * 
 * As a special exception to the normal conventions for functions that
 * use #GError, if this function returns %FALSE (and sets @error) then
 * @bytes_written will be set to the number of bytes that were
 * successfully written before the error was encountered.  This
 * functionality is only available from C.  If you need it from another
 * language then you must write your own loop around
 * g_output_stream_write().
 *
 * @param buffer the buffer containing the data to write.
 * @param count the number of bytes to write
 * @param bytesWritten location to store the number of bytes that was
 *     written to the stream
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE on success, %FALSE if there was an error
 */
- (bool)writeAllWithBuffer:(void*)buffer count:(gsize)count bytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable;

/**
 * Request an asynchronous write of @count bytes from @buffer into
 * the stream. When the operation is finished @callback will be called.
 * You can then call g_output_stream_write_all_finish() to get the result of the
 * operation.
 * 
 * This is the asynchronous version of g_output_stream_write_all().
 * 
 * Call g_output_stream_write_all_finish() to collect the result.
 * 
 * Any outstanding I/O request with higher priority (lower numerical
 * value) will be executed before an outstanding request with lower
 * priority. Default priority is %G_PRIORITY_DEFAULT.
 * 
 * Note that no copy of @buffer will be made, so it must stay valid
 * until @callback is called.
 *
 * @param buffer the buffer containing the data to write
 * @param count the number of bytes to write
 * @param ioPriority the io priority of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore
 * @param callback a #GAsyncReadyCallback
 *     to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)writeAllAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an asynchronous stream write operation started with
 * g_output_stream_write_all_async().
 * 
 * As a special exception to the normal conventions for functions that
 * use #GError, if this function returns %FALSE (and sets @error) then
 * @bytes_written will be set to the number of bytes that were
 * successfully written before the error was encountered.  This
 * functionality is only available from C.  If you need it from another
 * language then you must write your own loop around
 * g_output_stream_write_async().
 *
 * @param result a #GAsyncResult
 * @param bytesWritten location to store the number of bytes that was written to the stream
 * @return %TRUE on success, %FALSE if there was an error
 */
- (bool)writeAllFinishWithResult:(GAsyncResult*)result bytesWritten:(gsize*)bytesWritten;

/**
 * Request an asynchronous write of @count bytes from @buffer into
 * the stream. When the operation is finished @callback will be called.
 * You can then call g_output_stream_write_finish() to get the result of the
 * operation.
 * 
 * During an async request no other sync and async calls are allowed,
 * and will result in %G_IO_ERROR_PENDING errors.
 * 
 * A value of @count larger than %G_MAXSSIZE will cause a
 * %G_IO_ERROR_INVALID_ARGUMENT error.
 * 
 * On success, the number of bytes written will be passed to the
 * @callback. It is not an error if this is not the same as the
 * requested size, as it can happen e.g. on a partial I/O error,
 * but generally we try to write as many bytes as requested.
 * 
 * You are guaranteed that this method will never fail with
 * %G_IO_ERROR_WOULD_BLOCK - if @stream can't accept more data, the
 * method will just wait until this changes.
 * 
 * Any outstanding I/O request with higher priority (lower numerical
 * value) will be executed before an outstanding request with lower
 * priority. Default priority is %G_PRIORITY_DEFAULT.
 * 
 * The asynchronous methods have a default fallback that uses threads
 * to implement asynchronicity, so they are optional for inheriting
 * classes. However, if you override one you must override all.
 * 
 * For the synchronous, blocking version of this function, see
 * g_output_stream_write().
 * 
 * Note that no copy of @buffer will be made, so it must stay valid
 * until @callback is called. See g_output_stream_write_bytes_async()
 * for a #GBytes version that will automatically hold a reference to
 * the contents (without copying) for the duration of the call.
 *
 * @param buffer the buffer containing the data to write.
 * @param count the number of bytes to write
 * @param ioPriority the io priority of the request.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *     to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)writeAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * A wrapper function for g_output_stream_write() which takes a
 * #GBytes as input.  This can be more convenient for use by language
 * bindings or in other cases where the refcounted nature of #GBytes
 * is helpful over a bare pointer interface.
 * 
 * However, note that this function may still perform partial writes,
 * just like g_output_stream_write().  If that occurs, to continue
 * writing, you will need to create a new #GBytes containing just the
 * remaining bytes, using g_bytes_new_from_bytes(). Passing the same
 * #GBytes instance multiple times potentially can result in duplicated
 * data in the output stream.
 *
 * @param bytes the #GBytes to write
 * @param cancellable optional cancellable object
 * @return Number of bytes written, or -1 on error
 */
- (gssize)writeBytesWithBytes:(GBytes*)bytes cancellable:(OGCancellable*)cancellable;

/**
 * This function is similar to g_output_stream_write_async(), but
 * takes a #GBytes as input.  Due to the refcounted nature of #GBytes,
 * this allows the stream to avoid taking a copy of the data.
 * 
 * However, note that this function may still perform partial writes,
 * just like g_output_stream_write_async(). If that occurs, to continue
 * writing, you will need to create a new #GBytes containing just the
 * remaining bytes, using g_bytes_new_from_bytes(). Passing the same
 * #GBytes instance multiple times potentially can result in duplicated
 * data in the output stream.
 * 
 * For the synchronous, blocking version of this function, see
 * g_output_stream_write_bytes().
 *
 * @param bytes The bytes to write
 * @param ioPriority the io priority of the request.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)writeBytesAsyncWithBytes:(GBytes*)bytes ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes a stream write-from-#GBytes operation.
 *
 * @param result a #GAsyncResult.
 * @return a #gssize containing the number of bytes written to the stream.
 */
- (gssize)writeBytesFinish:(GAsyncResult*)result;

/**
 * Finishes a stream write operation.
 *
 * @param result a #GAsyncResult.
 * @return a #gssize containing the number of bytes written to the stream.
 */
- (gssize)writeFinish:(GAsyncResult*)result;

/**
 * Tries to write the bytes contained in the @n_vectors @vectors into the
 * stream. Will block during the operation.
 * 
 * If @n_vectors is 0 or the sum of all bytes in @vectors is 0, returns 0 and
 * does nothing.
 * 
 * On success, the number of bytes written to the stream is returned.
 * It is not an error if this is not the same as the requested size, as it
 * can happen e.g. on a partial I/O error, or if there is not enough
 * storage in the stream. All writes block until at least one byte
 * is written or an error occurs; 0 is never returned (unless
 * @n_vectors is 0 or the sum of all bytes in @vectors is 0).
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
 * operation was partially finished when the operation was cancelled the
 * partial result will be returned, without an error.
 * 
 * Some implementations of g_output_stream_writev() may have limitations on the
 * aggregate buffer size, and will return %G_IO_ERROR_INVALID_ARGUMENT if these
 * are exceeded. For example, when writing to a local file on UNIX platforms,
 * the aggregate buffer size must not exceed %G_MAXSSIZE bytes.
 *
 * @param vectors the buffer containing the #GOutputVectors to write.
 * @param nvectors the number of vectors to write
 * @param bytesWritten location to store the number of bytes that were
 *     written to the stream
 * @param cancellable optional cancellable object
 * @return %TRUE on success, %FALSE if there was an error
 */
- (bool)writevWithVectors:(const GOutputVector*)vectors nvectors:(gsize)nvectors bytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable;

/**
 * Tries to write the bytes contained in the @n_vectors @vectors into the
 * stream. Will block during the operation.
 * 
 * This function is similar to g_output_stream_writev(), except it tries to
 * write as many bytes as requested, only stopping on an error.
 * 
 * On a successful write of all @n_vectors vectors, %TRUE is returned, and
 * @bytes_written is set to the sum of all the sizes of @vectors.
 * 
 * If there is an error during the operation %FALSE is returned and @error
 * is set to indicate the error status.
 * 
 * As a special exception to the normal conventions for functions that
 * use #GError, if this function returns %FALSE (and sets @error) then
 * @bytes_written will be set to the number of bytes that were
 * successfully written before the error was encountered.  This
 * functionality is only available from C. If you need it from another
 * language then you must write your own loop around
 * g_output_stream_write().
 * 
 * The content of the individual elements of @vectors might be changed by this
 * function.
 *
 * @param vectors the buffer containing the #GOutputVectors to write.
 * @param nvectors the number of vectors to write
 * @param bytesWritten location to store the number of bytes that were
 *     written to the stream
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE on success, %FALSE if there was an error
 */
- (bool)writevAllWithVectors:(GOutputVector*)vectors nvectors:(gsize)nvectors bytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable;

/**
 * Request an asynchronous write of the bytes contained in the @n_vectors @vectors into
 * the stream. When the operation is finished @callback will be called.
 * You can then call g_output_stream_writev_all_finish() to get the result of the
 * operation.
 * 
 * This is the asynchronous version of g_output_stream_writev_all().
 * 
 * Call g_output_stream_writev_all_finish() to collect the result.
 * 
 * Any outstanding I/O request with higher priority (lower numerical
 * value) will be executed before an outstanding request with lower
 * priority. Default priority is %G_PRIORITY_DEFAULT.
 * 
 * Note that no copy of @vectors will be made, so it must stay valid
 * until @callback is called. The content of the individual elements
 * of @vectors might be changed by this function.
 *
 * @param vectors the buffer containing the #GOutputVectors to write.
 * @param nvectors the number of vectors to write
 * @param ioPriority the I/O priority of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore
 * @param callback a #GAsyncReadyCallback
 *     to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)writevAllAsyncWithVectors:(GOutputVector*)vectors nvectors:(gsize)nvectors ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an asynchronous stream write operation started with
 * g_output_stream_writev_all_async().
 * 
 * As a special exception to the normal conventions for functions that
 * use #GError, if this function returns %FALSE (and sets @error) then
 * @bytes_written will be set to the number of bytes that were
 * successfully written before the error was encountered.  This
 * functionality is only available from C.  If you need it from another
 * language then you must write your own loop around
 * g_output_stream_writev_async().
 *
 * @param result a #GAsyncResult
 * @param bytesWritten location to store the number of bytes that were written to the stream
 * @return %TRUE on success, %FALSE if there was an error
 */
- (bool)writevAllFinishWithResult:(GAsyncResult*)result bytesWritten:(gsize*)bytesWritten;

/**
 * Request an asynchronous write of the bytes contained in @n_vectors @vectors into
 * the stream. When the operation is finished @callback will be called.
 * You can then call g_output_stream_writev_finish() to get the result of the
 * operation.
 * 
 * During an async request no other sync and async calls are allowed,
 * and will result in %G_IO_ERROR_PENDING errors.
 * 
 * On success, the number of bytes written will be passed to the
 * @callback. It is not an error if this is not the same as the
 * requested size, as it can happen e.g. on a partial I/O error,
 * but generally we try to write as many bytes as requested.
 * 
 * You are guaranteed that this method will never fail with
 * %G_IO_ERROR_WOULD_BLOCK — if @stream can't accept more data, the
 * method will just wait until this changes.
 * 
 * Any outstanding I/O request with higher priority (lower numerical
 * value) will be executed before an outstanding request with lower
 * priority. Default priority is %G_PRIORITY_DEFAULT.
 * 
 * The asynchronous methods have a default fallback that uses threads
 * to implement asynchronicity, so they are optional for inheriting
 * classes. However, if you override one you must override all.
 * 
 * For the synchronous, blocking version of this function, see
 * g_output_stream_writev().
 * 
 * Note that no copy of @vectors will be made, so it must stay valid
 * until @callback is called.
 *
 * @param vectors the buffer containing the #GOutputVectors to write.
 * @param nvectors the number of vectors to write
 * @param ioPriority the I/O priority of the request.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *     to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)writevAsyncWithVectors:(const GOutputVector*)vectors nvectors:(gsize)nvectors ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes a stream writev operation.
 *
 * @param result a #GAsyncResult.
 * @param bytesWritten location to store the number of bytes that were written to the stream
 * @return %TRUE on success, %FALSE if there was an error
 */
- (bool)writevFinishWithResult:(GAsyncResult*)result bytesWritten:(gsize*)bytesWritten;

@end