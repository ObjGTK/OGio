/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInputStream.h"

/**
 * `GMemoryInputStream` is a class for using arbitrary
 * memory chunks as input for GIO streaming input operations.
 * 
 * As of GLib 2.34, `GMemoryInputStream` implements
 * [iface@Gio.PollableInputStream].
 *
 */
@interface OGMemoryInputStream : OGInputStream
{

}


/**
 * Constructors
 */
- (instancetype)init;
- (instancetype)initFromBytes:(GBytes*)bytes;
- (instancetype)initFromDataWithData:(void*)data len:(gssize)len destroy:(GDestroyNotify)destroy;

/**
 * Methods
 */

- (GMemoryInputStream*)castedGObject;

/**
 * Appends @bytes to data that can be read from the input stream.
 *
 * @param bytes input data
 */
- (void)addBytes:(GBytes*)bytes;

/**
 * Appends @data to data that can be read from the input stream
 *
 * @param data input data
 * @param len length of the data, may be -1 if @data is a nul-terminated string
 * @param destroy function that is called to free @data, or %NULL
 */
- (void)addDataWithData:(void*)data len:(gssize)len destroy:(GDestroyNotify)destroy;

@end