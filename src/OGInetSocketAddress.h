/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketAddress.h"

@class OGInetAddress;

/**
 * An IPv4 or IPv6 socket address; that is, the combination of a
 * #GInetAddress and a port number.
 *
 */
@interface OGInetSocketAddress : OGSocketAddress
{

}


/**
 * Constructors
 */
- (instancetype)initWithAddress:(OGInetAddress*)address port:(guint16)port;
- (instancetype)initFromStringWithAddress:(OFString*)address port:(guint)port;

/**
 * Methods
 */

- (GInetSocketAddress*)castedGObject;

/**
 * Gets @address's #GInetAddress.
 *
 * @return the #GInetAddress for @address, which must be
 * g_object_ref()'d if it will be stored
 */
- (OGInetAddress*)address;

/**
 * Gets the `sin6_flowinfo` field from @address,
 * which must be an IPv6 address.
 *
 * @return the flowinfo field
 */
- (guint32)flowinfo;

/**
 * Gets @address's port.
 *
 * @return the port for @address
 */
- (guint16)port;

/**
 * Gets the `sin6_scope_id` field from @address,
 * which must be an IPv6 address.
 *
 * @return the scope id field
 */
- (guint32)scopeId;

@end