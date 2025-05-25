/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketAddressEnumerator.h"

/**
 * `GProxyAddressEnumerator` is a wrapper around
 * [class@Gio.SocketAddressEnumerator] which takes the [class@Gio.SocketAddress]
 * instances returned by the [class@Gio.SocketAddressEnumerator]
 * and wraps them in [class@Gio.ProxyAddress] instances, using the given
 * [property@Gio.ProxyAddressEnumerator:proxy-resolver].
 * 
 * This enumerator will be returned (for example, by
 * [method@Gio.SocketConnectable.enumerate]) as appropriate when a proxy is
 * configured; there should be no need to manually wrap a
 * [class@Gio.SocketAddressEnumerator] instance with one.
 *
 */
@interface OGProxyAddressEnumerator : OGSocketAddressEnumerator
{

}

/**
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Methods
 */

- (GProxyAddressEnumerator*)castedGObject;

@end