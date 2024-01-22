/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketAddressEnumerator.h"

/**
 * #GProxyAddressEnumerator is a wrapper around #GSocketAddressEnumerator which
 * takes the #GSocketAddress instances returned by the #GSocketAddressEnumerator
 * and wraps them in #GProxyAddress instances, using the given
 * #GProxyAddressEnumerator:proxy-resolver.
 * 
 * This enumerator will be returned (for example, by
 * g_socket_connectable_enumerate()) as appropriate when a proxy is configured;
 * there should be no need to manually wrap a #GSocketAddressEnumerator instance
 * with one.
 *
 */
@interface OGProxyAddressEnumerator : OGSocketAddressEnumerator
{

}


/**
 * Methods
 */

- (GProxyAddressEnumerator*)castedGObject;

@end