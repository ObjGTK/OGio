/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketListener.h"

#import "OGCancellable.h"
#import "OGSocket.h"
#import "OGSocketAddress.h"
#import "OGSocketConnection.h"

@implementation OGSocketListener

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SOCKET_LISTENER;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (instancetype)socketListener
{
	GSocketListener* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_socket_listener_new(), GSocketListener, GSocketListener);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSocketListener* wrapperObject;
	@try {
		wrapperObject = [[OGSocketListener alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSocketListener*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSocketListener, GSocketListener);
}

- (OGSocketConnection*)acceptWithSourceObject:(GObject**)sourceObject cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = g_socket_listener_accept([self castedGObject], sourceObject, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)acceptAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_listener_accept_async([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (OGSocketConnection*)acceptFinishWithResult:(GAsyncResult*)result sourceObject:(GObject**)sourceObject
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = g_socket_listener_accept_finish([self castedGObject], result, sourceObject, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGSocket*)acceptSocketWithSourceObject:(GObject**)sourceObject cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocket* gobjectValue = g_socket_listener_accept_socket([self castedGObject], sourceObject, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocket* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)acceptSocketAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_listener_accept_socket_async([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (OGSocket*)acceptSocketFinishWithResult:(GAsyncResult*)result sourceObject:(GObject**)sourceObject
{
	GError* err = NULL;

	GSocket* gobjectValue = g_socket_listener_accept_socket_finish([self castedGObject], result, sourceObject, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocket* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (bool)addAddress:(OGSocketAddress*)address type:(GSocketType)type protocol:(GSocketProtocol)protocol sourceObject:(OGObject*)sourceObject effectiveAddress:(GSocketAddress**)effectiveAddress
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_listener_add_address([self castedGObject], [address castedGObject], type, protocol, [sourceObject gObject], effectiveAddress, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (guint16)addAnyInetPortWithSourceObject:(OGObject*)sourceObject
{
	GError* err = NULL;

	guint16 returnValue = (guint16)g_socket_listener_add_any_inet_port([self castedGObject], [sourceObject gObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)addInetPort:(guint16)port sourceObject:(OGObject*)sourceObject
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_listener_add_inet_port([self castedGObject], port, [sourceObject gObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)addSocket:(OGSocket*)socket sourceObject:(OGObject*)sourceObject
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_listener_add_socket([self castedGObject], [socket castedGObject], [sourceObject gObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)close
{
	g_socket_listener_close([self castedGObject]);
}

- (void)setBacklogWithListenBacklog:(int)listenBacklog
{
	g_socket_listener_set_backlog([self castedGObject], listenBacklog);
}


@end