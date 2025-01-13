/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketConnection.h"

#import "OGCancellable.h"
#import "OGSocket.h"
#import "OGSocketAddress.h"

@implementation OGSocketConnection

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SOCKET_CONNECTION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GType)factoryLookupTypeWithFamily:(GSocketFamily)family type:(GSocketType)type protocolId:(gint)protocolId
{
	GType returnValue = (GType)g_socket_connection_factory_lookup_type(family, type, protocolId);

	return returnValue;
}

+ (void)factoryRegisterTypeWithGtype:(GType)gtype family:(GSocketFamily)family type:(GSocketType)type protocol:(gint)protocol
{
	g_socket_connection_factory_register_type(gtype, family, type, protocol);
}

- (GSocketConnection*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSocketConnection, GSocketConnection);
}

- (bool)connectWithAddress:(OGSocketAddress*)address cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_connection_connect([self castedGObject], [address castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)connectAsyncWithAddress:(OGSocketAddress*)address cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_connection_connect_async([self castedGObject], [address castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)connectFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_connection_connect_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OGSocketAddress*)localAddress
{
	GError* err = NULL;

	GSocketAddress* gobjectValue = g_socket_connection_get_local_address([self castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketAddress* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocketAddress*)remoteAddress
{
	GError* err = NULL;

	GSocketAddress* gobjectValue = g_socket_connection_get_remote_address([self castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketAddress* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocket*)socket
{
	GSocket* gobjectValue = g_socket_connection_get_socket([self castedGObject]);

	OGSocket* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (bool)isConnected
{
	bool returnValue = (bool)g_socket_connection_is_connected([self castedGObject]);

	return returnValue;
}


@end