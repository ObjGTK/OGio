/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInputStream.h"

/**
 * Base class for input stream implementations that perform some
 * kind of filtering operation on a base stream. Typical examples
 * of filtering operations are character set conversion, compression
 * and byte order flipping.
 *
 */
@interface OGFilterInputStream : OGInputStream
{

}


/**
 * Methods
 */

- (GFilterInputStream*)castedGObject;

/**
 * Gets the base stream for the filter stream.
 *
 * @return a #GInputStream.
 */
- (OGInputStream*)baseStream;

/**
 * Returns whether the base stream will be closed when @stream is
 * closed.
 *
 * @return %TRUE if the base stream will be closed.
 */
- (bool)closeBaseStream;

/**
 * Sets whether the base stream will be closed when @stream is closed.
 *
 * @param closeBase %TRUE to close the base stream.
 */
- (void)setCloseBaseStream:(bool)closeBase;

@end