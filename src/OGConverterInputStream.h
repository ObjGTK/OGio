/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilterInputStream.h"

@class OGInputStream;

/**
 * Converter input stream implements [class@Gio.InputStream] and allows
 * conversion of data of various types during reading.
 * 
 * As of GLib 2.34, `GConverterInputStream` implements
 * [iface@Gio.PollableInputStream].
 *
 */
@interface OGConverterInputStream : OGFilterInputStream
{

}

/**
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Constructors
 */
+ (instancetype)converterInputStreamWithBaseStream:(OGInputStream*)baseStream converter:(GConverter*)converter;

/**
 * Methods
 */

- (GConverterInputStream*)castedGObject;

/**
 * Gets the #GConverter that is used by @converter_stream.
 *
 * @return the converter of the converter input stream
 */
- (GConverter*)converter;

@end