/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGBufferedInputStream.h"

@class OGCancellable;
@class OGInputStream;

/**
 * Data input stream implements #GInputStream and includes functions for
 * reading structured data directly from a binary input stream.
 *
 */
@interface OGDataInputStream : OGBufferedInputStream
{

}


/**
 * Constructors
 */
- (instancetype)init:(OGInputStream*)baseStream;

/**
 * Methods
 */

- (GDataInputStream*)castedGObject;

/**
 * Gets the byte order for the data input stream.
 *
 * @return the @stream's current #GDataStreamByteOrder.
 */
- (GDataStreamByteOrder)byteOrder;

/**
 * Gets the current newline type for the @stream.
 *
 * @return #GDataStreamNewlineType for the given @stream.
 */
- (GDataStreamNewlineType)newlineType;

/**
 * Reads an unsigned 8-bit/1-byte value from @stream.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return an unsigned 8-bit/1-byte value read from the @stream or `0`
 * if an error occurred.
 */
- (guchar)readByte:(OGCancellable*)cancellable;

/**
 * Reads a 16-bit/2-byte value from @stream.
 * 
 * In order to get the correct byte order for this read operation,
 * see g_data_input_stream_get_byte_order() and g_data_input_stream_set_byte_order().
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a signed 16-bit/2-byte value read from @stream or `0` if
 * an error occurred.
 */
- (gint16)readInt16:(OGCancellable*)cancellable;

/**
 * Reads a signed 32-bit/4-byte value from @stream.
 * 
 * In order to get the correct byte order for this read operation,
 * see g_data_input_stream_get_byte_order() and g_data_input_stream_set_byte_order().
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a signed 32-bit/4-byte value read from the @stream or `0` if
 * an error occurred.
 */
- (gint32)readInt32:(OGCancellable*)cancellable;

/**
 * Reads a 64-bit/8-byte value from @stream.
 * 
 * In order to get the correct byte order for this read operation,
 * see g_data_input_stream_get_byte_order() and g_data_input_stream_set_byte_order().
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a signed 64-bit/8-byte value read from @stream or `0` if
 * an error occurred.
 */
- (gint64)readInt64:(OGCancellable*)cancellable;

/**
 * Reads a line from the data input stream.  Note that no encoding
 * checks or conversion is performed; the input is not guaranteed to
 * be UTF-8, and may in fact have embedded NUL characters.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 *
 * @param length a #gsize to get the length of the data read in.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a NUL terminated byte array with the line that was read in
 *  (without the newlines).  Set @length to a #gsize to get the length
 *  of the read line.  On an error, it will return %NULL and @error
 *  will be set. If there's no content to read, it will still return
 *  %NULL, but @error won't be set.
 */
- (char*)readLineWithLength:(gsize*)length cancellable:(OGCancellable*)cancellable;

/**
 * The asynchronous version of g_data_input_stream_read_line().  It is
 * an error to have two outstanding calls to this function.
 * 
 * When the operation is finished, @callback will be called. You
 * can then call g_data_input_stream_read_line_finish() to get
 * the result of the operation.
 *
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback callback to call when the request is satisfied.
 * @param userData the data to pass to callback function.
 */
- (void)readLineAsyncWithIoPriority:(gint)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finish an asynchronous call started by
 * g_data_input_stream_read_line_async().  Note the warning about
 * string encoding in g_data_input_stream_read_line() applies here as
 * well.
 *
 * @param result the #GAsyncResult that was provided to the callback.
 * @param length a #gsize to get the length of the data read in.
 * @return a NUL-terminated byte array with the line that was read in
 *  (without the newlines).  Set @length to a #gsize to get the length
 *  of the read line.  On an error, it will return %NULL and @error
 *  will be set. If there's no content to read, it will still return
 *  %NULL, but @error won't be set.
 */
- (char*)readLineFinishWithResult:(GAsyncResult*)result length:(gsize*)length;

/**
 * Finish an asynchronous call started by
 * g_data_input_stream_read_line_async().
 *
 * @param result the #GAsyncResult that was provided to the callback.
 * @param length a #gsize to get the length of the data read in.
 * @return a string with the line that
 *  was read in (without the newlines).  Set @length to a #gsize to
 *  get the length of the read line.  On an error, it will return
 *  %NULL and @error will be set. For UTF-8 conversion errors, the set
 *  error domain is %G_CONVERT_ERROR.  If there's no content to read,
 *  it will still return %NULL, but @error won't be set.
 */
- (char*)readLineFinishUtf8WithResult:(GAsyncResult*)result length:(gsize*)length;

/**
 * Reads a UTF-8 encoded line from the data input stream.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 *
 * @param length a #gsize to get the length of the data read in.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a NUL terminated UTF-8 string
 *  with the line that was read in (without the newlines).  Set
 *  @length to a #gsize to get the length of the read line.  On an
 *  error, it will return %NULL and @error will be set.  For UTF-8
 *  conversion errors, the set error domain is %G_CONVERT_ERROR.  If
 *  there's no content to read, it will still return %NULL, but @error
 *  won't be set.
 */
- (char*)readLineUtf8WithLength:(gsize*)length cancellable:(OGCancellable*)cancellable;

/**
 * Reads an unsigned 16-bit/2-byte value from @stream.
 * 
 * In order to get the correct byte order for this read operation,
 * see g_data_input_stream_get_byte_order() and g_data_input_stream_set_byte_order().
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return an unsigned 16-bit/2-byte value read from the @stream or `0` if
 * an error occurred.
 */
- (guint16)readUint16:(OGCancellable*)cancellable;

/**
 * Reads an unsigned 32-bit/4-byte value from @stream.
 * 
 * In order to get the correct byte order for this read operation,
 * see g_data_input_stream_get_byte_order() and g_data_input_stream_set_byte_order().
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return an unsigned 32-bit/4-byte value read from the @stream or `0` if
 * an error occurred.
 */
- (guint32)readUint32:(OGCancellable*)cancellable;

/**
 * Reads an unsigned 64-bit/8-byte value from @stream.
 * 
 * In order to get the correct byte order for this read operation,
 * see g_data_input_stream_get_byte_order().
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return an unsigned 64-bit/8-byte read from @stream or `0` if
 * an error occurred.
 */
- (guint64)readUint64:(OGCancellable*)cancellable;

/**
 * Reads a string from the data input stream, up to the first
 * occurrence of any of the stop characters.
 * 
 * Note that, in contrast to g_data_input_stream_read_until_async(),
 * this function consumes the stop character that it finds.
 * 
 * Don't use this function in new code.  Its functionality is
 * inconsistent with g_data_input_stream_read_until_async().  Both
 * functions will be marked as deprecated in a future release.  Use
 * g_data_input_stream_read_upto() instead, but note that that function
 * does not consume the stop character.
 *
 * @param stopChars characters to terminate the read.
 * @param length a #gsize to get the length of the data read in.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a string with the data that was read
 *     before encountering any of the stop characters. Set @length to
 *     a #gsize to get the length of the string. This function will
 *     return %NULL on an error.
 */
- (char*)readUntilWithStopChars:(OFString*)stopChars length:(gsize*)length cancellable:(OGCancellable*)cancellable;

/**
 * The asynchronous version of g_data_input_stream_read_until().
 * It is an error to have two outstanding calls to this function.
 * 
 * Note that, in contrast to g_data_input_stream_read_until(),
 * this function does not consume the stop character that it finds.  You
 * must read it for yourself.
 * 
 * When the operation is finished, @callback will be called. You
 * can then call g_data_input_stream_read_until_finish() to get
 * the result of the operation.
 * 
 * Don't use this function in new code.  Its functionality is
 * inconsistent with g_data_input_stream_read_until().  Both functions
 * will be marked as deprecated in a future release.  Use
 * g_data_input_stream_read_upto_async() instead.
 *
 * @param stopChars characters to terminate the read.
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback callback to call when the request is satisfied.
 * @param userData the data to pass to callback function.
 */
- (void)readUntilAsyncWithStopChars:(OFString*)stopChars ioPriority:(gint)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finish an asynchronous call started by
 * g_data_input_stream_read_until_async().
 *
 * @param result the #GAsyncResult that was provided to the callback.
 * @param length a #gsize to get the length of the data read in.
 * @return a string with the data that was read
 *     before encountering any of the stop characters. Set @length to
 *     a #gsize to get the length of the string. This function will
 *     return %NULL on an error.
 */
- (char*)readUntilFinishWithResult:(GAsyncResult*)result length:(gsize*)length;

/**
 * Reads a string from the data input stream, up to the first
 * occurrence of any of the stop characters.
 * 
 * In contrast to g_data_input_stream_read_until(), this function
 * does not consume the stop character. You have to use
 * g_data_input_stream_read_byte() to get it before calling
 * g_data_input_stream_read_upto() again.
 * 
 * Note that @stop_chars may contain '\0' if @stop_chars_len is
 * specified.
 * 
 * The returned string will always be nul-terminated on success.
 *
 * @param stopChars characters to terminate the read
 * @param stopCharsLen length of @stop_chars. May be -1 if @stop_chars is
 *     nul-terminated
 * @param length a #gsize to get the length of the data read in
 * @param cancellable optional #GCancellable object, %NULL to ignore
 * @return a string with the data that was read
 *     before encountering any of the stop characters. Set @length to
 *     a #gsize to get the length of the string. This function will
 *     return %NULL on an error
 */
- (char*)readUptoWithStopChars:(OFString*)stopChars stopCharsLen:(gssize)stopCharsLen length:(gsize*)length cancellable:(OGCancellable*)cancellable;

/**
 * The asynchronous version of g_data_input_stream_read_upto().
 * It is an error to have two outstanding calls to this function.
 * 
 * In contrast to g_data_input_stream_read_until(), this function
 * does not consume the stop character. You have to use
 * g_data_input_stream_read_byte() to get it before calling
 * g_data_input_stream_read_upto() again.
 * 
 * Note that @stop_chars may contain '\0' if @stop_chars_len is
 * specified.
 * 
 * When the operation is finished, @callback will be called. You
 * can then call g_data_input_stream_read_upto_finish() to get
 * the result of the operation.
 *
 * @param stopChars characters to terminate the read
 * @param stopCharsLen length of @stop_chars. May be -1 if @stop_chars is
 *     nul-terminated
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore
 * @param callback callback to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)readUptoAsyncWithStopChars:(OFString*)stopChars stopCharsLen:(gssize)stopCharsLen ioPriority:(gint)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finish an asynchronous call started by
 * g_data_input_stream_read_upto_async().
 * 
 * Note that this function does not consume the stop character. You
 * have to use g_data_input_stream_read_byte() to get it before calling
 * g_data_input_stream_read_upto_async() again.
 * 
 * The returned string will always be nul-terminated on success.
 *
 * @param result the #GAsyncResult that was provided to the callback
 * @param length a #gsize to get the length of the data read in
 * @return a string with the data that was read
 *     before encountering any of the stop characters. Set @length to
 *     a #gsize to get the length of the string. This function will
 *     return %NULL on an error.
 */
- (char*)readUptoFinishWithResult:(GAsyncResult*)result length:(gsize*)length;

/**
 * This function sets the byte order for the given @stream. All subsequent
 * reads from the @stream will be read in the given @order.
 *
 * @param order a #GDataStreamByteOrder to set.
 */
- (void)setByteOrder:(GDataStreamByteOrder)order;

/**
 * Sets the newline type for the @stream.
 * 
 * Note that using G_DATA_STREAM_NEWLINE_TYPE_ANY is slightly unsafe. If a read
 * chunk ends in "CR" we must read an additional byte to know if this is "CR" or
 * "CR LF", and this might block if there is no more data available.
 *
 * @param type the type of new line return as #GDataStreamNewlineType.
 */
- (void)setNewlineType:(GDataStreamNewlineType)type;

@end