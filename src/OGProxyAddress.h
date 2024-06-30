/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInetSocketAddress.h"

@class OGInetAddress;
@class OGSocketAddress;

/**
 * Support for proxied #GInetSocketAddress.
 *
 */
@interface OGProxyAddress : OGInetSocketAddress
{

}


/**
 * Constructors
 */
- (instancetype)initWithInetaddr:(OGInetAddress*)inetaddr port:(guint16)port protocol:(OFString*)protocol destHostname:(OFString*)destHostname destPort:(guint16)destPort username:(OFString*)username password:(OFString*)password;

/**
 * Methods
 */

- (GProxyAddress*)castedGObject;

/**
 * Gets @proxy's destination hostname; that is, the name of the host
 * that will be connected to via the proxy, not the name of the proxy
 * itself.
 *
 * @return the @proxy's destination hostname
 */
- (OFString*)destinationHostname;

/**
 * Gets @proxy's destination port; that is, the port on the
 * destination host that will be connected to via the proxy, not the
 * port number of the proxy itself.
 *
 * @return the @proxy's destination port
 */
- (guint16)destinationPort;

/**
 * Gets the protocol that is being spoken to the destination
 * server; eg, "http" or "ftp".
 *
 * @return the @proxy's destination protocol
 */
- (OFString*)destinationProtocol;

/**
 * Gets @proxy's password.
 *
 * @return the @proxy's password
 */
- (OFString*)password;

/**
 * Gets @proxy's protocol. eg, "socks" or "http"
 *
 * @return the @proxy's protocol
 */
- (OFString*)protocol;

/**
 * Gets the proxy URI that @proxy was constructed from.
 *
 * @return the @proxy's URI, or %NULL if unknown
 */
- (OFString*)uri;

/**
 * Gets @proxy's username.
 *
 * @return the @proxy's username
 */
- (OFString*)username;

@end