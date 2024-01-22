/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketAddress.h"

/**
 * A socket address of some unknown native type.
 *
 */
@interface OGNativeSocketAddress : OGSocketAddress
{

}


/**
 * Constructors
 */
- (instancetype)initWithNative:(gpointer)native len:(gsize)len;

/**
 * Methods
 */

- (GNativeSocketAddress*)castedGObject;

@end