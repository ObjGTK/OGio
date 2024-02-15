/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

/**
 * #GNetworkAddress provides an easy way to resolve a hostname and
 * then attempt to connect to that host, handling the possibility of
 * multiple IP addresses and multiple address families.
 * 
 * The enumeration results of resolved addresses *may* be cached as long
 * as this object is kept alive which may have unexpected results if
 * alive for too long.
 * 
 * See #GSocketConnectable for an example of using the connectable
 * interface.
 *
 */
@interface OGNetworkAddress : OGObject
{

}

/**
 * Functions
 */

/**
 * Creates a new #GSocketConnectable for connecting to the given
 * @hostname and @port. May fail and return %NULL in case
 * parsing @host_and_port fails.
 * 
 * @host_and_port may be in any of a number of recognised formats; an IPv6
 * address, an IPv4 address, or a domain name (in which case a DNS
 * lookup is performed). Quoting with [] is supported for all address
 * types. A port override may be specified in the usual way with a
 * colon.
 * 
 * If no port is specified in @host_and_port then @default_port will be
 * used as the port number to connect to.
 * 
 * In general, @host_and_port is expected to be provided by the user
 * (allowing them to give the hostname, and a port override if necessary)
 * and @default_port is expected to be provided by the application.
 * 
 * (The port component of @host_and_port can also be specified as a
 * service name rather than as a numeric port, but this functionality
 * is deprecated, because it depends on the contents of /etc/services,
 * which is generally quite sparse on platforms other than Linux.)
 *
 * @param hostAndPort the hostname and optionally a port
 * @param defaultPort the default port if not in @host_and_port
 * @return the new
 *   #GNetworkAddress, or %NULL on error
 */
+ (GSocketConnectable*)parseWithHostAndPort:(OFString*)hostAndPort defaultPort:(guint16)defaultPort;

/**
 * Creates a new #GSocketConnectable for connecting to the given
 * @uri. May fail and return %NULL in case parsing @uri fails.
 * 
 * Using this rather than g_network_address_new() or
 * g_network_address_parse() allows #GSocketClient to determine
 * when to use application-specific proxy protocols.
 *
 * @param uri the hostname and optionally a port
 * @param defaultPort The default port if none is found in the URI
 * @return the new
 *   #GNetworkAddress, or %NULL on error
 */
+ (GSocketConnectable*)parseUriWithUri:(OFString*)uri defaultPort:(guint16)defaultPort;

/**
 * Constructors
 */
- (instancetype)initWithHostname:(OFString*)hostname port:(guint16)port;
- (instancetype)initLoopback:(guint16)port;

/**
 * Methods
 */

- (GNetworkAddress*)castedGObject;

/**
 * Gets @addr's hostname. This might be either UTF-8 or ASCII-encoded,
 * depending on what @addr was created with.
 *
 * @return @addr's hostname
 */
- (OFString*)hostname;

/**
 * Gets @addr's port number
 *
 * @return @addr's port (which may be 0)
 */
- (guint16)port;

/**
 * Gets @addr's scheme
 *
 * @return @addr's scheme (%NULL if not built from URI)
 */
- (OFString*)scheme;

@end