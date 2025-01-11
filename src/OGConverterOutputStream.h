/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilterOutputStream.h"

@class OGOutputStream;

/**
 * Converter output stream implements [class@Gio.OutputStream] and allows
 * conversion of data of various types during reading.
 * 
 * As of GLib 2.34, `GConverterOutputStream` implements
 * [iface@Gio.PollableOutputStream].
 *
 */
@interface OGConverterOutputStream : OGFilterOutputStream
{

}


/**
 * Constructors
 */
+ (instancetype)converterOutputStreamWithBaseStream:(OGOutputStream*)baseStream converter:(GConverter*)converter;

/**
 * Methods
 */

- (GConverterOutputStream*)castedGObject;

/**
 * Gets the #GConverter that is used by @converter_stream.
 *
 * @return the converter of the converter output stream
 */
- (GConverter*)converter;

@end