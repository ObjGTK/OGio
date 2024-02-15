/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketListener.h"

#import "OGCancellable.h"
#import "OGSocketAddress.h"
#import "OGSocketConnection.h"
#import "OGSocket.h"

@implementation OGSocketListener

- (instancetype)init
{
	GSocketListener* gobjectValue = G_SOCKET_LISTENER(g_socket_listener_new());

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

- (GSocketListener*)castedGObject
{
	return G_SOCKET_LISTENER([self gObject]);
}

- (OGSocketConnection*)acceptWithSourceObject:(GObject**)sourceObject cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = G_SOCKET_CONNECTION(g_socket_listener_accept([self castedGObject], sourceObject, [cancellable castedGObject], &err));

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

- (void)acceptAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_listener_accept_async([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (OGSocketConnection*)acceptFinishWithResult:(GAsyncResult*)result sourceObject:(GObject**)sourceObject
{
	GError* err = NULL;

	GSocketConnection* gobjectValue = G_SOCKET_CONNECTION(g_socket_listener_accept_finish([self castedGObject], result, sourceObject, &err));

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

- (OGSocket*)acceptSocketWithSourceObject:(GObject**)sourceObject cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocket* gobjectValue = G_SOCKET(g_socket_listener_accept_socket([self castedGObject], sourceObject, [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocket* returnValue = [OGSocket withGObject:gobjectValue];
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

	GSocket* gobjectValue = G_SOCKET(g_socket_listener_accept_socket_finish([self castedGObject], result, sourceObject, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocket* returnValue = [OGSocket withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (bool)addAddressWithAddress:(OGSocketAddress*)address type:(GSocketType)type protocol:(GSocketProtocol)protocol sourceObject:(GObject*)sourceObject effectiveAddress:(GSocketAddress**)effectiveAddress
{
	GError* err = NULL;

	bool returnValue = g_socket_listener_add_address([self castedGObject], [address castedGObject], type, protocol, sourceObject, effectiveAddress, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (guint16)addAnyInetPort:(GObject*)sourceObject
{
	GError* err = NULL;

	guint16 returnValue = g_socket_listener_add_any_inet_port([self castedGObject], sourceObject, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)addInetPortWithPort:(guint16)port sourceObject:(GObject*)sourceObject
{
	GError* err = NULL;

	bool returnValue = g_socket_listener_add_inet_port([self castedGObject], port, sourceObject, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)addSocketWithSocket:(OGSocket*)socket sourceObject:(GObject*)sourceObject
{
	GError* err = NULL;

	bool returnValue = g_socket_listener_add_socket([self castedGObject], [socket castedGObject], sourceObject, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)close
{
	g_socket_listener_close([self castedGObject]);
}

- (void)setBacklog:(int)listenBacklog
{
	g_socket_listener_set_backlog([self castedGObject], listenBacklog);
}


@end