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

@class OGCancellable;
@class OGSocketAddress;
@class OGSocketConnection;

/**
 * `GSocketClient` is a lightweight high-level utility class for connecting to
 * a network host using a connection oriented socket type.
 * 
 * You create a `GSocketClient` object, set any options you want, and then
 * call a sync or async connect operation, which returns a
 * [class@Gio.SocketConnection] subclass on success.
 * 
 * The type of the [class@Gio.SocketConnection] object returned depends on the
 * type of the underlying socket that is in use. For instance, for a TCP/IP
 * connection it will be a [class@Gio.TcpConnection].
 * 
 * As `GSocketClient` is a lightweight object, you don't need to cache it. You
 * can just create a new one any time you need one.
 *
 */
@interface OGSocketClient : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)socketClient;

/**
 * Methods
 */

- (GSocketClient*)castedGObject;

/**
 * Enable proxy protocols to be handled by the application. When the
 * indicated proxy protocol is returned by the #GProxyResolver,
 * #GSocketClient will consider this protocol as supported but will
 * not try to find a #GProxy instance to handle handshaking. The
 * application must check for this case by calling
 * g_socket_connection_get_remote_address() on the returned
 * #GSocketConnection, and seeing if it's a #GProxyAddress of the
 * appropriate type, to determine whether or not it needs to handle
 * the proxy handshaking itself.
 * 
 * This should be used for proxy protocols that are dialects of
 * another protocol such as HTTP proxy. It also allows cohabitation of
 * proxy protocols that are reused between protocols. A good example
 * is HTTP. It can be used to proxy HTTP, FTP and Gopher and can also
 * be use as generic socket proxy through the HTTP CONNECT method.
 * 
 * When the proxy is detected as being an application proxy, TLS handshake
 * will be skipped. This is required to let the application do the proxy
 * specific handshake.
 *
 * @param protocol The proxy protocol
 */
- (void)addApplicationProxyWithProtocol:(OFString*)protocol;

/**
 * Tries to resolve the @connectable and make a network connection to it.
 * 
 * Upon a successful connection, a new #GSocketConnection is constructed
 * and returned.  The caller owns this new object and must drop their
 * reference to it when finished with it.
 * 
 * The type of the #GSocketConnection object returned depends on the type of
 * the underlying socket that is used. For instance, for a TCP/IP connection
 * it will be a #GTcpConnection.
 * 
 * The socket created will be the same family as the address that the
 * @connectable resolves to, unless family is set with g_socket_client_set_family()
 * or indirectly via g_socket_client_set_local_address(). The socket type
 * defaults to %G_SOCKET_TYPE_STREAM but can be set with
 * g_socket_client_set_socket_type().
 * 
 * If a local address is specified with g_socket_client_set_local_address() the
 * socket will be bound to this address before connecting.
 *
 * @param connectable a #GSocketConnectable specifying the remote address.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a #GSocketConnection on success, %NULL on error.
 */
- (OGSocketConnection*)connectWithConnectable:(GSocketConnectable*)connectable cancellable:(OGCancellable*)cancellable;

/**
 * This is the asynchronous version of g_socket_client_connect().
 * 
 * You may wish to prefer the asynchronous version even in synchronous
 * command line programs because, since 2.60, it implements
 * [RFC 8305](https://tools.ietf.org/html/rfc8305) "Happy Eyeballs"
 * recommendations to work around long connection timeouts in networks
 * where IPv6 is broken by performing an IPv4 connection simultaneously
 * without waiting for IPv6 to time out, which is not supported by the
 * synchronous call. (This is not an API guarantee, and may change in
 * the future.)
 * 
 * When the operation is finished @callback will be
 * called. You can then call g_socket_client_connect_finish() to get
 * the result of the operation.
 *
 * @param connectable a #GSocketConnectable specifying the remote address.
 * @param cancellable a #GCancellable, or %NULL
 * @param callback a #GAsyncReadyCallback
 * @param userData user data for the callback
 */
- (void)connectAsyncWithConnectable:(GSocketConnectable*)connectable cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an async connect operation. See g_socket_client_connect_async()
 *
 * @param result a #GAsyncResult.
 * @return a #GSocketConnection on success, %NULL on error.
 */
- (OGSocketConnection*)connectFinishWithResult:(GAsyncResult*)result;

/**
 * This is a helper function for g_socket_client_connect().
 * 
 * Attempts to create a TCP connection to the named host.
 * 
 * @host_and_port may be in any of a number of recognized formats; an IPv6
 * address, an IPv4 address, or a domain name (in which case a DNS
 * lookup is performed).  Quoting with [] is supported for all address
 * types.  A port override may be specified in the usual way with a
 * colon.  Ports may be given as decimal numbers or symbolic names (in
 * which case an /etc/services lookup is performed).
 * 
 * If no port override is given in @host_and_port then @default_port will be
 * used as the port number to connect to.
 * 
 * In general, @host_and_port is expected to be provided by the user (allowing
 * them to give the hostname, and a port override if necessary) and
 * @default_port is expected to be provided by the application.
 * 
 * In the case that an IP address is given, a single connection
 * attempt is made.  In the case that a name is given, multiple
 * connection attempts may be made, in turn and according to the
 * number of address records in DNS, until a connection succeeds.
 * 
 * Upon a successful connection, a new #GSocketConnection is constructed
 * and returned.  The caller owns this new object and must drop their
 * reference to it when finished with it.
 * 
 * In the event of any failure (DNS error, service not found, no hosts
 * connectable) %NULL is returned and @error (if non-%NULL) is set
 * accordingly.
 *
 * @param hostAndPort the name and optionally port of the host to connect to
 * @param defaultPort the default port to connect to
 * @param cancellable a #GCancellable, or %NULL
 * @return a #GSocketConnection on success, %NULL on error.
 */
- (OGSocketConnection*)connectToHostWithHostAndPort:(OFString*)hostAndPort defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable;

/**
 * This is the asynchronous version of g_socket_client_connect_to_host().
 * 
 * When the operation is finished @callback will be
 * called. You can then call g_socket_client_connect_to_host_finish() to get
 * the result of the operation.
 *
 * @param hostAndPort the name and optionally the port of the host to connect to
 * @param defaultPort the default port to connect to
 * @param cancellable a #GCancellable, or %NULL
 * @param callback a #GAsyncReadyCallback
 * @param userData user data for the callback
 */
- (void)connectToHostAsyncWithHostAndPort:(OFString*)hostAndPort defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an async connect operation. See g_socket_client_connect_to_host_async()
 *
 * @param result a #GAsyncResult.
 * @return a #GSocketConnection on success, %NULL on error.
 */
- (OGSocketConnection*)connectToHostFinishWithResult:(GAsyncResult*)result;

/**
 * Attempts to create a TCP connection to a service.
 * 
 * This call looks up the SRV record for @service at @domain for the
 * "tcp" protocol.  It then attempts to connect, in turn, to each of
 * the hosts providing the service until either a connection succeeds
 * or there are no hosts remaining.
 * 
 * Upon a successful connection, a new #GSocketConnection is constructed
 * and returned.  The caller owns this new object and must drop their
 * reference to it when finished with it.
 * 
 * In the event of any failure (DNS error, service not found, no hosts
 * connectable) %NULL is returned and @error (if non-%NULL) is set
 * accordingly.
 *
 * @param domain a domain name
 * @param service the name of the service to connect to
 * @param cancellable a #GCancellable, or %NULL
 * @return a #GSocketConnection if successful, or %NULL on error
 */
- (OGSocketConnection*)connectToServiceWithDomain:(OFString*)domain service:(OFString*)service cancellable:(OGCancellable*)cancellable;

/**
 * This is the asynchronous version of
 * g_socket_client_connect_to_service().
 *
 * @param domain a domain name
 * @param service the name of the service to connect to
 * @param cancellable a #GCancellable, or %NULL
 * @param callback a #GAsyncReadyCallback
 * @param userData user data for the callback
 */
- (void)connectToServiceAsyncWithDomain:(OFString*)domain service:(OFString*)service cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an async connect operation. See g_socket_client_connect_to_service_async()
 *
 * @param result a #GAsyncResult.
 * @return a #GSocketConnection on success, %NULL on error.
 */
- (OGSocketConnection*)connectToServiceFinishWithResult:(GAsyncResult*)result;

/**
 * This is a helper function for g_socket_client_connect().
 * 
 * Attempts to create a TCP connection with a network URI.
 * 
 * @uri may be any valid URI containing an "authority" (hostname/port)
 * component. If a port is not specified in the URI, @default_port
 * will be used. TLS will be negotiated if #GSocketClient:tls is %TRUE.
 * (#GSocketClient does not know to automatically assume TLS for
 * certain URI schemes.)
 * 
 * Using this rather than g_socket_client_connect() or
 * g_socket_client_connect_to_host() allows #GSocketClient to
 * determine when to use application-specific proxy protocols.
 * 
 * Upon a successful connection, a new #GSocketConnection is constructed
 * and returned.  The caller owns this new object and must drop their
 * reference to it when finished with it.
 * 
 * In the event of any failure (DNS error, service not found, no hosts
 * connectable) %NULL is returned and @error (if non-%NULL) is set
 * accordingly.
 *
 * @param uri A network URI
 * @param defaultPort the default port to connect to
 * @param cancellable a #GCancellable, or %NULL
 * @return a #GSocketConnection on success, %NULL on error.
 */
- (OGSocketConnection*)connectToUri:(OFString*)uri defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable;

/**
 * This is the asynchronous version of g_socket_client_connect_to_uri().
 * 
 * When the operation is finished @callback will be
 * called. You can then call g_socket_client_connect_to_uri_finish() to get
 * the result of the operation.
 *
 * @param uri a network uri
 * @param defaultPort the default port to connect to
 * @param cancellable a #GCancellable, or %NULL
 * @param callback a #GAsyncReadyCallback
 * @param userData user data for the callback
 */
- (void)connectToUriAsync:(OFString*)uri defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an async connect operation. See g_socket_client_connect_to_uri_async()
 *
 * @param result a #GAsyncResult.
 * @return a #GSocketConnection on success, %NULL on error.
 */
- (OGSocketConnection*)connectToUriFinishWithResult:(GAsyncResult*)result;

/**
 * Gets the proxy enable state; see g_socket_client_set_enable_proxy()
 *
 * @return whether proxying is enabled
 */
- (bool)enableProxy;

/**
 * Gets the socket family of the socket client.
 * 
 * See g_socket_client_set_family() for details.
 *
 * @return a #GSocketFamily
 */
- (GSocketFamily)family;

/**
 * Gets the local address of the socket client.
 * 
 * See g_socket_client_set_local_address() for details.
 *
 * @return a #GSocketAddress or %NULL. Do not free.
 */
- (OGSocketAddress*)localAddress;

/**
 * Gets the protocol name type of the socket client.
 * 
 * See g_socket_client_set_protocol() for details.
 *
 * @return a #GSocketProtocol
 */
- (GSocketProtocol)protocol;

/**
 * Gets the #GProxyResolver being used by @client. Normally, this will
 * be the resolver returned by g_proxy_resolver_get_default(), but you
 * can override it with g_socket_client_set_proxy_resolver().
 *
 * @return The #GProxyResolver being used by
 *   @client.
 */
- (GProxyResolver*)proxyResolver;

/**
 * Gets the socket type of the socket client.
 * 
 * See g_socket_client_set_socket_type() for details.
 *
 * @return a #GSocketFamily
 */
- (GSocketType)socketType;

/**
 * Gets the I/O timeout time for sockets created by @client.
 * 
 * See g_socket_client_set_timeout() for details.
 *
 * @return the timeout in seconds
 */
- (guint)timeout;

/**
 * Gets whether @client creates TLS connections. See
 * g_socket_client_set_tls() for details.
 *
 * @return whether @client uses TLS
 */
- (bool)tls;

/**
 * Gets the TLS validation flags used creating TLS connections via
 * @client.
 * 
 * This function does not work as originally designed and is impossible
 * to use correctly. See #GSocketClient:tls-validation-flags for more
 * information.
 *
 * @return the TLS validation flags
 */
- (GTlsCertificateFlags)tlsValidationFlags;

/**
 * Sets whether or not @client attempts to make connections via a
 * proxy server. When enabled (the default), #GSocketClient will use a
 * #GProxyResolver to determine if a proxy protocol such as SOCKS is
 * needed, and automatically do the necessary proxy negotiation.
 * 
 * See also g_socket_client_set_proxy_resolver().
 *
 * @param enable whether to enable proxies
 */
- (void)setEnableProxy:(bool)enable;

/**
 * Sets the socket family of the socket client.
 * If this is set to something other than %G_SOCKET_FAMILY_INVALID
 * then the sockets created by this object will be of the specified
 * family.
 * 
 * This might be useful for instance if you want to force the local
 * connection to be an ipv4 socket, even though the address might
 * be an ipv6 mapped to ipv4 address.
 *
 * @param family a #GSocketFamily
 */
- (void)setFamily:(GSocketFamily)family;

/**
 * Sets the local address of the socket client.
 * The sockets created by this object will bound to the
 * specified address (if not %NULL) before connecting.
 * 
 * This is useful if you want to ensure that the local
 * side of the connection is on a specific port, or on
 * a specific interface.
 *
 * @param address a #GSocketAddress, or %NULL
 */
- (void)setLocalAddress:(OGSocketAddress*)address;

/**
 * Sets the protocol of the socket client.
 * The sockets created by this object will use of the specified
 * protocol.
 * 
 * If @protocol is %G_SOCKET_PROTOCOL_DEFAULT that means to use the default
 * protocol for the socket family and type.
 *
 * @param protocol a #GSocketProtocol
 */
- (void)setProtocol:(GSocketProtocol)protocol;

/**
 * Overrides the #GProxyResolver used by @client. You can call this if
 * you want to use specific proxies, rather than using the system
 * default proxy settings.
 * 
 * Note that whether or not the proxy resolver is actually used
 * depends on the setting of #GSocketClient:enable-proxy, which is not
 * changed by this function (but which is %TRUE by default)
 *
 * @param proxyResolver a #GProxyResolver, or %NULL for the
 *   default.
 */
- (void)setProxyResolver:(GProxyResolver*)proxyResolver;

/**
 * Sets the socket type of the socket client.
 * The sockets created by this object will be of the specified
 * type.
 * 
 * It doesn't make sense to specify a type of %G_SOCKET_TYPE_DATAGRAM,
 * as GSocketClient is used for connection oriented services.
 *
 * @param type a #GSocketType
 */
- (void)setSocketType:(GSocketType)type;

/**
 * Sets the I/O timeout for sockets created by @client. @timeout is a
 * time in seconds, or 0 for no timeout (the default).
 * 
 * The timeout value affects the initial connection attempt as well,
 * so setting this may cause calls to g_socket_client_connect(), etc,
 * to fail with %G_IO_ERROR_TIMED_OUT.
 *
 * @param timeout the timeout
 */
- (void)setTimeout:(guint)timeout;

/**
 * Sets whether @client creates TLS (aka SSL) connections. If @tls is
 * %TRUE, @client will wrap its connections in a #GTlsClientConnection
 * and perform a TLS handshake when connecting.
 * 
 * Note that since #GSocketClient must return a #GSocketConnection,
 * but #GTlsClientConnection is not a #GSocketConnection, this
 * actually wraps the resulting #GTlsClientConnection in a
 * #GTcpWrapperConnection when returning it. You can use
 * g_tcp_wrapper_connection_get_base_io_stream() on the return value
 * to extract the #GTlsClientConnection.
 * 
 * If you need to modify the behavior of the TLS handshake (eg, by
 * setting a client-side certificate to use, or connecting to the
 * #GTlsConnection::accept-certificate signal), you can connect to
 * @client's #GSocketClient::event signal and wait for it to be
 * emitted with %G_SOCKET_CLIENT_TLS_HANDSHAKING, which will give you
 * a chance to see the #GTlsClientConnection before the handshake
 * starts.
 *
 * @param tls whether to use TLS
 */
- (void)setTls:(bool)tls;

/**
 * Sets the TLS validation flags used when creating TLS connections
 * via @client. The default value is %G_TLS_CERTIFICATE_VALIDATE_ALL.
 * 
 * This function does not work as originally designed and is impossible
 * to use correctly. See #GSocketClient:tls-validation-flags for more
 * information.
 *
 * @param flags the validation flags
 */
- (void)setTlsValidationFlags:(GTlsCertificateFlags)flags;

@end