/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketClient.h"

#import "OGSocketConnection.h"
#import "OGSocketAddress.h"
#import "OGCancellable.h"

@implementation OGSocketClient

- (instancetype)init
{
	GSocketClient* gobjectValue = G_SOCKET_CLIENT(g_socket_client_new());

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (GSocketClient*)castedGObject
{
	return G_SOCKET_CLIENT([self gObject]);
}

- (void)addApplicationProxy:(OFString*)protocol
{
	g_socket_client_add_application_proxy([self castedGObject], [protocol UTF8String]);
}

- (OGSocketConnection*)connectWithConnectable:(GSocketConnectable*)connectable cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = G_SOCKET_CONNECTION(g_socket_client_connect([self castedGObject], connectable, [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketConnection* returnValue = [OGSocketConnection withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)connectAsyncWithConnectable:(GSocketConnectable*)connectable cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_client_connect_async([self castedGObject], connectable, [cancellable castedGObject], callback, userData);
}

- (OGSocketConnection*)connectFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = G_SOCKET_CONNECTION(g_socket_client_connect_finish([self castedGObject], result, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketConnection* returnValue = [OGSocketConnection withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocketConnection*)connectToHostWithHostAndPort:(OFString*)hostAndPort defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = G_SOCKET_CONNECTION(g_socket_client_connect_to_host([self castedGObject], [hostAndPort UTF8String], defaultPort, [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketConnection* returnValue = [OGSocketConnection withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)connectToHostAsyncWithHostAndPort:(OFString*)hostAndPort defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_client_connect_to_host_async([self castedGObject], [hostAndPort UTF8String], defaultPort, [cancellable castedGObject], callback, userData);
}

- (OGSocketConnection*)connectToHostFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = G_SOCKET_CONNECTION(g_socket_client_connect_to_host_finish([self castedGObject], result, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketConnection* returnValue = [OGSocketConnection withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocketConnection*)connectToServiceWithDomain:(OFString*)domain service:(OFString*)service cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = G_SOCKET_CONNECTION(g_socket_client_connect_to_service([self castedGObject], [domain UTF8String], [service UTF8String], [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketConnection* returnValue = [OGSocketConnection withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)connectToServiceAsyncWithDomain:(OFString*)domain service:(OFString*)service cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_client_connect_to_service_async([self castedGObject], [domain UTF8String], [service UTF8String], [cancellable castedGObject], callback, userData);
}

- (OGSocketConnection*)connectToServiceFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = G_SOCKET_CONNECTION(g_socket_client_connect_to_service_finish([self castedGObject], result, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketConnection* returnValue = [OGSocketConnection withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocketConnection*)connectToUriWithUri:(OFString*)uri defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = G_SOCKET_CONNECTION(g_socket_client_connect_to_uri([self castedGObject], [uri UTF8String], defaultPort, [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketConnection* returnValue = [OGSocketConnection withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)connectToUriAsyncWithUri:(OFString*)uri defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_client_connect_to_uri_async([self castedGObject], [uri UTF8String], defaultPort, [cancellable castedGObject], callback, userData);
}

- (OGSocketConnection*)connectToUriFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = G_SOCKET_CONNECTION(g_socket_client_connect_to_uri_finish([self castedGObject], result, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketConnection* returnValue = [OGSocketConnection withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (bool)enableProxy
{
	bool returnValue = g_socket_client_get_enable_proxy([self castedGObject]);

	return returnValue;
}

- (GSocketFamily)family
{
	GSocketFamily returnValue = g_socket_client_get_family([self castedGObject]);

	return returnValue;
}

- (OGSocketAddress*)localAddress
{
	GSocketAddress* gobjectValue = G_SOCKET_ADDRESS(g_socket_client_get_local_address([self castedGObject]));

	OGSocketAddress* returnValue = [OGSocketAddress withGObject:gobjectValue];
	return returnValue;
}

- (GSocketProtocol)protocol
{
	GSocketProtocol returnValue = g_socket_client_get_protocol([self castedGObject]);

	return returnValue;
}

- (GProxyResolver*)proxyResolver
{
	GProxyResolver* returnValue = g_socket_client_get_proxy_resolver([self castedGObject]);

	return returnValue;
}

- (GSocketType)socketType
{
	GSocketType returnValue = g_socket_client_get_socket_type([self castedGObject]);

	return returnValue;
}

- (guint)timeout
{
	guint returnValue = g_socket_client_get_timeout([self castedGObject]);

	return returnValue;
}

- (bool)tls
{
	bool returnValue = g_socket_client_get_tls([self castedGObject]);

	return returnValue;
}

- (GTlsCertificateFlags)tlsValidationFlags
{
	GTlsCertificateFlags returnValue = g_socket_client_get_tls_validation_flags([self castedGObject]);

	return returnValue;
}

- (void)setEnableProxy:(bool)enable
{
	g_socket_client_set_enable_proxy([self castedGObject], enable);
}

- (void)setFamily:(GSocketFamily)family
{
	g_socket_client_set_family([self castedGObject], family);
}

- (void)setLocalAddress:(OGSocketAddress*)address
{
	g_socket_client_set_local_address([self castedGObject], [address castedGObject]);
}

- (void)setProtocol:(GSocketProtocol)protocol
{
	g_socket_client_set_protocol([self castedGObject], protocol);
}

- (void)setProxyResolver:(GProxyResolver*)proxyResolver
{
	g_socket_client_set_proxy_resolver([self castedGObject], proxyResolver);
}

- (void)setSocketType:(GSocketType)type
{
	g_socket_client_set_socket_type([self castedGObject], type);
}

- (void)setTimeout:(guint)timeout
{
	g_socket_client_set_timeout([self castedGObject], timeout);
}

- (void)setTls:(bool)tls
{
	g_socket_client_set_tls([self castedGObject], tls);
}

- (void)setTlsValidationFlags:(GTlsCertificateFlags)flags
{
	g_socket_client_set_tls_validation_flags([self castedGObject], flags);
}


@end