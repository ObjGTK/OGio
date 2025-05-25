/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketClient.h"

#import "OGCancellable.h"
#import "OGSocketAddress.h"
#import "OGSocketConnection.h"

@implementation OGSocketClient

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SOCKET_CLIENT;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SOCKET_CLIENT);
	return gObjectClass;
}

+ (instancetype)socketClient
{
	GSocketClient* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_socket_client_new(), G_TYPE_SOCKET_CLIENT, GSocketClient);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSocketClient* wrapperObject;
	@try {
		wrapperObject = [[OGSocketClient alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSocketClient*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SOCKET_CLIENT, GSocketClient);
}

- (void)addApplicationProxyWithProtocol:(OFString*)protocol
{
	g_socket_client_add_application_proxy((GSocketClient*)[self castedGObject], [protocol UTF8String]);
}

- (OGSocketConnection*)connectWithConnectable:(GSocketConnectable*)connectable cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = g_socket_client_connect((GSocketClient*)[self castedGObject], connectable, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)connectAsyncWithConnectable:(GSocketConnectable*)connectable cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_client_connect_async((GSocketClient*)[self castedGObject], connectable, [cancellable castedGObject], callback, userData);
}

- (OGSocketConnection*)connectFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = g_socket_client_connect_finish((GSocketClient*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocketConnection*)connectToHostWithHostAndPort:(OFString*)hostAndPort defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = g_socket_client_connect_to_host((GSocketClient*)[self castedGObject], [hostAndPort UTF8String], defaultPort, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)connectToHostAsyncWithHostAndPort:(OFString*)hostAndPort defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_client_connect_to_host_async((GSocketClient*)[self castedGObject], [hostAndPort UTF8String], defaultPort, [cancellable castedGObject], callback, userData);
}

- (OGSocketConnection*)connectToHostFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = g_socket_client_connect_to_host_finish((GSocketClient*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocketConnection*)connectToServiceWithDomain:(OFString*)domain service:(OFString*)service cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = g_socket_client_connect_to_service((GSocketClient*)[self castedGObject], [domain UTF8String], [service UTF8String], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)connectToServiceAsyncWithDomain:(OFString*)domain service:(OFString*)service cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_client_connect_to_service_async((GSocketClient*)[self castedGObject], [domain UTF8String], [service UTF8String], [cancellable castedGObject], callback, userData);
}

- (OGSocketConnection*)connectToServiceFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = g_socket_client_connect_to_service_finish((GSocketClient*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocketConnection*)connectToUri:(OFString*)uri defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = g_socket_client_connect_to_uri((GSocketClient*)[self castedGObject], [uri UTF8String], defaultPort, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)connectToUriAsync:(OFString*)uri defaultPort:(guint16)defaultPort cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_client_connect_to_uri_async((GSocketClient*)[self castedGObject], [uri UTF8String], defaultPort, [cancellable castedGObject], callback, userData);
}

- (OGSocketConnection*)connectToUriFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = g_socket_client_connect_to_uri_finish((GSocketClient*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (bool)enableProxy
{
	bool returnValue = (bool)g_socket_client_get_enable_proxy((GSocketClient*)[self castedGObject]);

	return returnValue;
}

- (GSocketFamily)family
{
	GSocketFamily returnValue = (GSocketFamily)g_socket_client_get_family((GSocketClient*)[self castedGObject]);

	return returnValue;
}

- (OGSocketAddress*)localAddress
{
	GSocketAddress* gobjectValue = g_socket_client_get_local_address((GSocketClient*)[self castedGObject]);

	OGSocketAddress* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (GSocketProtocol)protocol
{
	GSocketProtocol returnValue = (GSocketProtocol)g_socket_client_get_protocol((GSocketClient*)[self castedGObject]);

	return returnValue;
}

- (GProxyResolver*)proxyResolver
{
	GProxyResolver* returnValue = (GProxyResolver*)g_socket_client_get_proxy_resolver((GSocketClient*)[self castedGObject]);

	return returnValue;
}

- (GSocketType)socketType
{
	GSocketType returnValue = (GSocketType)g_socket_client_get_socket_type((GSocketClient*)[self castedGObject]);

	return returnValue;
}

- (guint)timeout
{
	guint returnValue = (guint)g_socket_client_get_timeout((GSocketClient*)[self castedGObject]);

	return returnValue;
}

- (bool)tls
{
	bool returnValue = (bool)g_socket_client_get_tls((GSocketClient*)[self castedGObject]);

	return returnValue;
}

- (GTlsCertificateFlags)tlsValidationFlags
{
	GTlsCertificateFlags returnValue = (GTlsCertificateFlags)g_socket_client_get_tls_validation_flags((GSocketClient*)[self castedGObject]);

	return returnValue;
}

- (void)setEnableProxy:(bool)enable
{
	g_socket_client_set_enable_proxy((GSocketClient*)[self castedGObject], enable);
}

- (void)setFamily:(GSocketFamily)family
{
	g_socket_client_set_family((GSocketClient*)[self castedGObject], family);
}

- (void)setLocalAddress:(OGSocketAddress*)address
{
	g_socket_client_set_local_address((GSocketClient*)[self castedGObject], [address castedGObject]);
}

- (void)setProtocol:(GSocketProtocol)protocol
{
	g_socket_client_set_protocol((GSocketClient*)[self castedGObject], protocol);
}

- (void)setProxyResolver:(GProxyResolver*)proxyResolver
{
	g_socket_client_set_proxy_resolver((GSocketClient*)[self castedGObject], proxyResolver);
}

- (void)setSocketType:(GSocketType)type
{
	g_socket_client_set_socket_type((GSocketClient*)[self castedGObject], type);
}

- (void)setTimeout:(guint)timeout
{
	g_socket_client_set_timeout((GSocketClient*)[self castedGObject], timeout);
}

- (void)setTls:(bool)tls
{
	g_socket_client_set_tls((GSocketClient*)[self castedGObject], tls);
}

- (void)setTlsValidationFlags:(GTlsCertificateFlags)flags
{
	g_socket_client_set_tls_validation_flags((GSocketClient*)[self castedGObject], flags);
}


@end