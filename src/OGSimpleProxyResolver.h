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
 * #GSimpleProxyResolver is a simple #GProxyResolver implementation
 * that handles a single default proxy, multiple URI-scheme-specific
 * proxies, and a list of hosts that proxies should not be used for.
 * 
 * #GSimpleProxyResolver is never the default proxy resolver, but it
 * can be used as the base class for another proxy resolver
 * implementation, or it can be created and used manually, such as
 * with g_socket_client_set_proxy_resolver().
 *
 */
@interface OGSimpleProxyResolver : OGObject
{

}

/**
 * Functions
 */

/**
 * Creates a new #GSimpleProxyResolver. See
 * #GSimpleProxyResolver:default-proxy and
 * #GSimpleProxyResolver:ignore-hosts for more details on how the
 * arguments are interpreted.
 *
 * @param defaultProxy the default proxy to use, eg
 *     "socks://192.168.1.1"
 * @param ignoreHosts an optional list of hosts/IP addresses
 *     to not use a proxy for.
 * @return a new #GSimpleProxyResolver
 */
+ (GProxyResolver*)newWithDefaultProxy:(OFString*)defaultProxy ignoreHosts:(gchar**)ignoreHosts;

/**
 * Methods
 */

- (GSimpleProxyResolver*)castedGObject;

/**
 * Sets the default proxy on @resolver, to be used for any URIs that
 * don't match #GSimpleProxyResolver:ignore-hosts or a proxy set
 * via g_simple_proxy_resolver_set_uri_proxy().
 * 
 * If @default_proxy starts with "socks://",
 * #GSimpleProxyResolver will treat it as referring to all three of
 * the socks5, socks4a, and socks4 proxy types.
 *
 * @param defaultProxy the default proxy to use
 */
- (void)setDefaultProxy:(OFString*)defaultProxy;

/**
 * Sets the list of ignored hosts.
 * 
 * See #GSimpleProxyResolver:ignore-hosts for more details on how the
 * @ignore_hosts argument is interpreted.
 *
 * @param ignoreHosts %NULL-terminated list of hosts/IP addresses
 *     to not use a proxy for
 */
- (void)setIgnoreHosts:(gchar**)ignoreHosts;

/**
 * Adds a URI-scheme-specific proxy to @resolver; URIs whose scheme
 * matches @uri_scheme (and which don't match
 * #GSimpleProxyResolver:ignore-hosts) will be proxied via @proxy.
 * 
 * As with #GSimpleProxyResolver:default-proxy, if @proxy starts with
 * "socks://", #GSimpleProxyResolver will treat it
 * as referring to all three of the socks5, socks4a, and socks4 proxy
 * types.
 *
 * @param uriScheme the URI scheme to add a proxy for
 * @param proxy the proxy to use for @uri_scheme
 */
- (void)setUriProxyWithUriScheme:(OFString*)uriScheme proxy:(OFString*)proxy;

@end