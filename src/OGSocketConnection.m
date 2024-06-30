/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketConnection.h"

#import "OGSocket.h"
#import "OGSocketAddress.h"
#import "OGCancellable.h"

@implementation OGSocketConnection

+ (GType)factoryLookupTypeWithFamily:(GSocketFamily)family type:(GSocketType)type protocolId:(gint)protocolId
{
	GType returnValue = g_socket_connection_factory_lookup_type(family, type, protocolId);

	return returnValue;
}

+ (void)factoryRegisterTypeWithGtype:(GType)gtype family:(GSocketFamily)family type:(GSocketType)type protocol:(gint)protocol
{
	g_socket_connection_factory_register_type(gtype, family, type, protocol);
}

- (GSocketConnection*)castedGObject
{
	return G_SOCKET_CONNECTION([self gObject]);
}

- (bool)connectWithAddress:(OGSocketAddress*)address cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_socket_connection_connect([self castedGObject], [address castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)connectAsyncWithAddress:(OGSocketAddress*)address cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_connection_connect_async([self castedGObject], [address castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)connectFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = g_socket_connection_connect_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (OGSocketAddress*)localAddress
{
	GError* err = NULL;

	GSocketAddress* gobjectValue = G_SOCKET_ADDRESS(g_socket_connection_get_local_address([self castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketAddress* returnValue = [OGSocketAddress withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocketAddress*)remoteAddress
{
	GError* err = NULL;

	GSocketAddress* gobjectValue = G_SOCKET_ADDRESS(g_socket_connection_get_remote_address([self castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketAddress* returnValue = [OGSocketAddress withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocket*)socket
{
	GSocket* gobjectValue = G_SOCKET(g_socket_connection_get_socket([self castedGObject]));

	OGSocket* returnValue = [OGSocket withGObject:gobjectValue];
	return returnValue;
}

- (bool)isConnected
{
	bool returnValue = g_socket_connection_is_connected([self castedGObject]);

	return returnValue;
}


@end