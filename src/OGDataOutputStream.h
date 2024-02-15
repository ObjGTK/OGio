/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilterOutputStream.h"

@class OGOutputStream;
@class OGCancellable;

/**
 * Data output stream implements #GOutputStream and includes functions for
 * writing data directly to an output stream.
 *
 */
@interface OGDataOutputStream : OGFilterOutputStream
{

}


/**
 * Constructors
 */
- (instancetype)init:(OGOutputStream*)baseStream;

/**
 * Methods
 */

- (GDataOutputStream*)castedGObject;

/**
 * Gets the byte order for the stream.
 *
 * @return the #GDataStreamByteOrder for the @stream.
 */
- (GDataStreamByteOrder)byteOrder;

/**
 * Puts a byte into the output stream.
 *
 * @param data a #guchar.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE if @data was successfully added to the @stream.
 */
- (bool)putByteWithData:(guchar)data cancellable:(OGCancellable*)cancellable;

/**
 * Puts a signed 16-bit integer into the output stream.
 *
 * @param data a #gint16.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE if @data was successfully added to the @stream.
 */
- (bool)putInt16WithData:(gint16)data cancellable:(OGCancellable*)cancellable;

/**
 * Puts a signed 32-bit integer into the output stream.
 *
 * @param data a #gint32.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE if @data was successfully added to the @stream.
 */
- (bool)putInt32WithData:(gint32)data cancellable:(OGCancellable*)cancellable;

/**
 * Puts a signed 64-bit integer into the stream.
 *
 * @param data a #gint64.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE if @data was successfully added to the @stream.
 */
- (bool)putInt64WithData:(gint64)data cancellable:(OGCancellable*)cancellable;

/**
 * Puts a string into the output stream.
 *
 * @param str a string.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE if @string was successfully added to the @stream.
 */
- (bool)putStringWithStr:(OFString*)str cancellable:(OGCancellable*)cancellable;

/**
 * Puts an unsigned 16-bit integer into the output stream.
 *
 * @param data a #guint16.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE if @data was successfully added to the @stream.
 */
- (bool)putUint16WithData:(guint16)data cancellable:(OGCancellable*)cancellable;

/**
 * Puts an unsigned 32-bit integer into the stream.
 *
 * @param data a #guint32.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE if @data was successfully added to the @stream.
 */
- (bool)putUint32WithData:(guint32)data cancellable:(OGCancellable*)cancellable;

/**
 * Puts an unsigned 64-bit integer into the stream.
 *
 * @param data a #guint64.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return %TRUE if @data was successfully added to the @stream.
 */
- (bool)putUint64WithData:(guint64)data cancellable:(OGCancellable*)cancellable;

/**
 * Sets the byte order of the data output stream to @order.
 *
 * @param order a %GDataStreamByteOrder.
 */
- (void)setByteOrder:(GDataStreamByteOrder)order;

@end