/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketAddress.h"

/**
 * A socket address of some unknown native type.
 * 
 * This corresponds to a general `struct sockaddr` of a type not otherwise
 * handled by GLib.
 *
 */
@interface OGNativeSocketAddress : OGSocketAddress
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
+ (instancetype)nativeSocketAddressWithNative:(gpointer)native len:(gsize)len;

/**
 * Methods
 */

- (GNativeSocketAddress*)castedGObject;

@end