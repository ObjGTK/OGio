/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

/**
 * Like [class@Gio.NetworkAddress] does with hostnames, `GNetworkService`
 * provides an easy way to resolve a SRV record, and then attempt to
 * connect to one of the hosts that implements that service, handling
 * service priority/weighting, multiple IP addresses, and multiple
 * address families.
 * 
 * See [struct@Gio.SrvTarget] for more information about SRV records, and see
 * [iface@Gio.SocketConnectable] for an example of using the connectable
 * interface.
 *
 */
@interface OGNetworkService : OGObject
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
+ (instancetype)networkServiceWithService:(OFString*)service protocol:(OFString*)protocol domain:(OFString*)domain;

/**
 * Methods
 */

- (GNetworkService*)castedGObject;

/**
 * Gets the domain that @srv serves. This might be either UTF-8 or
 * ASCII-encoded, depending on what @srv was created with.
 *
 * @return @srv's domain name
 */
- (OFString*)domain;

/**
 * Gets @srv's protocol name (eg, "tcp").
 *
 * @return @srv's protocol name
 */
- (OFString*)protocol;

/**
 * Gets the URI scheme used to resolve proxies. By default, the service name
 * is used as scheme.
 *
 * @return @srv's scheme name
 */
- (OFString*)scheme;

/**
 * Gets @srv's service name (eg, "ldap").
 *
 * @return @srv's service name
 */
- (OFString*)service;

/**
 * Set's the URI scheme used to resolve proxies. By default, the service name
 * is used as scheme.
 *
 * @param scheme a URI scheme
 */
- (void)setScheme:(OFString*)scheme;

@end