/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixoutputstream.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

/**
 * #GInetAddress represents an IPv4 or IPv6 internet address. Use
 * g_resolver_lookup_by_name() or g_resolver_lookup_by_name_async() to
 * look up the #GInetAddress for a hostname. Use
 * g_resolver_lookup_by_address() or
 * g_resolver_lookup_by_address_async() to look up the hostname for a
 * #GInetAddress.
 * 
 * To actually connect to a remote host, you will need a
 * #GInetSocketAddress (which includes a #GInetAddress as well as a
 * port number).
 *
 */
@interface OGInetAddress : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)initAny:(GSocketFamily)family;
- (instancetype)initFromBytesWithBytes:(const guint8*)bytes family:(GSocketFamily)family;
- (instancetype)initFromString:(OFString*)string;
- (instancetype)initLoopback:(GSocketFamily)family;

/**
 * Methods
 */

- (GInetAddress*)castedGObject;

/**
 * Checks if two #GInetAddress instances are equal, e.g. the same address.
 *
 * @param otherAddress Another #GInetAddress.
 * @return %TRUE if @address and @other_address are equal, %FALSE otherwise.
 */
- (bool)equal:(OGInetAddress*)otherAddress;

/**
 * Gets @address's family
 *
 * @return @address's family
 */
- (GSocketFamily)family;

/**
 * Tests whether @address is the "any" address for its family.
 *
 * @return %TRUE if @address is the "any" address for its family.
 */
- (bool)isAny;

/**
 * Tests whether @address is a link-local address (that is, if it
 * identifies a host on a local network that is not connected to the
 * Internet).
 *
 * @return %TRUE if @address is a link-local address.
 */
- (bool)isLinkLocal;

/**
 * Tests whether @address is the loopback address for its family.
 *
 * @return %TRUE if @address is the loopback address for its family.
 */
- (bool)isLoopback;

/**
 * Tests whether @address is a global multicast address.
 *
 * @return %TRUE if @address is a global multicast address.
 */
- (bool)isMcGlobal;

/**
 * Tests whether @address is a link-local multicast address.
 *
 * @return %TRUE if @address is a link-local multicast address.
 */
- (bool)isMcLinkLocal;

/**
 * Tests whether @address is a node-local multicast address.
 *
 * @return %TRUE if @address is a node-local multicast address.
 */
- (bool)isMcNodeLocal;

/**
 * Tests whether @address is an organization-local multicast address.
 *
 * @return %TRUE if @address is an organization-local multicast address.
 */
- (bool)isMcOrgLocal;

/**
 * Tests whether @address is a site-local multicast address.
 *
 * @return %TRUE if @address is a site-local multicast address.
 */
- (bool)isMcSiteLocal;

/**
 * Tests whether @address is a multicast address.
 *
 * @return %TRUE if @address is a multicast address.
 */
- (bool)isMulticast;

/**
 * Tests whether @address is a site-local address such as 10.0.0.1
 * (that is, the address identifies a host on a local network that can
 * not be reached directly from the Internet, but which may have
 * outgoing Internet connectivity via a NAT or firewall).
 *
 * @return %TRUE if @address is a site-local address.
 */
- (bool)isSiteLocal;

/**
 * Gets the size of the native raw binary address for @address. This
 * is the size of the data that you get from g_inet_address_to_bytes().
 *
 * @return the number of bytes used for the native version of @address.
 */
- (gsize)nativeSize;

/**
 * Gets the raw binary address data from @address.
 *
 * @return a pointer to an internal array of the bytes in @address,
 * which should not be modified, stored, or freed. The size of this
 * array can be gotten with g_inet_address_get_native_size().
 */
- (const guint8*)toBytes;

/**
 * Converts @address to string form.
 *
 * @return a representation of @address as a string, which should be
 * freed after use.
 */
- (OFString*)toString;

@end