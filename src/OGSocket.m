/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocket.h"

#import "OGCancellable.h"
#import "OGCredentials.h"
#import "OGInetAddress.h"
#import "OGSocketAddress.h"
#import "OGSocketConnection.h"
#import "OGSocketControlMessage.h"

@implementation OGSocket

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SOCKET;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SOCKET);
	return gObjectClass;
}

+ (instancetype)socketWithFamily:(GSocketFamily)family type:(GSocketType)type protocol:(GSocketProtocol)protocol
{
	GError* err = NULL;

	GSocket* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_socket_new(family, type, protocol, &err), G_TYPE_SOCKET, GSocket);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocket* wrapperObject;
	@try {
		wrapperObject = [[OGSocket alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)socketFromFd:(gint)fd
{
	GError* err = NULL;

	GSocket* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_socket_new_from_fd(fd, &err), G_TYPE_SOCKET, GSocket);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocket* wrapperObject;
	@try {
		wrapperObject = [[OGSocket alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSocket*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SOCKET, GSocket);
}

- (OGSocket*)acceptWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocket* gobjectValue = g_socket_accept((GSocket*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocket* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (bool)bindWithAddress:(OGSocketAddress*)address allowReuse:(bool)allowReuse
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_bind((GSocket*)[self castedGObject], [address castedGObject], allowReuse, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)checkConnectResult
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_check_connect_result((GSocket*)[self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)close
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_close((GSocket*)[self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GIOCondition)conditionCheckWithCondition:(GIOCondition)condition
{
	GIOCondition returnValue = (GIOCondition)g_socket_condition_check((GSocket*)[self castedGObject], condition);

	return returnValue;
}

- (bool)conditionTimedWaitWithCondition:(GIOCondition)condition timeoutUs:(gint64)timeoutUs cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_condition_timed_wait((GSocket*)[self castedGObject], condition, timeoutUs, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)conditionWaitWithCondition:(GIOCondition)condition cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_condition_wait((GSocket*)[self castedGObject], condition, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)connectWithAddress:(OGSocketAddress*)address cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_connect((GSocket*)[self castedGObject], [address castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OGSocketConnection*)connectionFactoryCreateConnection
{
	GSocketConnection* gobjectValue = g_socket_connection_factory_create_connection((GSocket*)[self castedGObject]);

	OGSocketConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GSource*)createSourceWithCondition:(GIOCondition)condition cancellable:(OGCancellable*)cancellable
{
	GSource* returnValue = (GSource*)g_socket_create_source((GSocket*)[self castedGObject], condition, [cancellable castedGObject]);

	return returnValue;
}

- (gssize)availableBytes
{
	gssize returnValue = (gssize)g_socket_get_available_bytes((GSocket*)[self castedGObject]);

	return returnValue;
}

- (bool)blocking
{
	bool returnValue = (bool)g_socket_get_blocking((GSocket*)[self castedGObject]);

	return returnValue;
}

- (bool)broadcast
{
	bool returnValue = (bool)g_socket_get_broadcast((GSocket*)[self castedGObject]);

	return returnValue;
}

- (OGCredentials*)credentials
{
	GError* err = NULL;

	GCredentials* gobjectValue = g_socket_get_credentials((GSocket*)[self castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGCredentials* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GSocketFamily)family
{
	GSocketFamily returnValue = (GSocketFamily)g_socket_get_family((GSocket*)[self castedGObject]);

	return returnValue;
}

- (int)fd
{
	int returnValue = (int)g_socket_get_fd((GSocket*)[self castedGObject]);

	return returnValue;
}

- (bool)keepalive
{
	bool returnValue = (bool)g_socket_get_keepalive((GSocket*)[self castedGObject]);

	return returnValue;
}

- (gint)listenBacklog
{
	gint returnValue = (gint)g_socket_get_listen_backlog((GSocket*)[self castedGObject]);

	return returnValue;
}

- (OGSocketAddress*)localAddress
{
	GError* err = NULL;

	GSocketAddress* gobjectValue = g_socket_get_local_address((GSocket*)[self castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketAddress* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (bool)multicastLoopback
{
	bool returnValue = (bool)g_socket_get_multicast_loopback((GSocket*)[self castedGObject]);

	return returnValue;
}

- (guint)multicastTtl
{
	guint returnValue = (guint)g_socket_get_multicast_ttl((GSocket*)[self castedGObject]);

	return returnValue;
}

- (bool)optionWithLevel:(gint)level optname:(gint)optname value:(gint*)value
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_get_option((GSocket*)[self castedGObject], level, optname, value, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GSocketProtocol)protocol
{
	GSocketProtocol returnValue = (GSocketProtocol)g_socket_get_protocol((GSocket*)[self castedGObject]);

	return returnValue;
}

- (OGSocketAddress*)remoteAddress
{
	GError* err = NULL;

	GSocketAddress* gobjectValue = g_socket_get_remote_address((GSocket*)[self castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketAddress* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GSocketType)socketType
{
	GSocketType returnValue = (GSocketType)g_socket_get_socket_type((GSocket*)[self castedGObject]);

	return returnValue;
}

- (guint)timeout
{
	guint returnValue = (guint)g_socket_get_timeout((GSocket*)[self castedGObject]);

	return returnValue;
}

- (guint)ttl
{
	guint returnValue = (guint)g_socket_get_ttl((GSocket*)[self castedGObject]);

	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = (bool)g_socket_is_closed((GSocket*)[self castedGObject]);

	return returnValue;
}

- (bool)isConnected
{
	bool returnValue = (bool)g_socket_is_connected((GSocket*)[self castedGObject]);

	return returnValue;
}

- (bool)joinMulticastGroup:(OGInetAddress*)group sourceSpecific:(bool)sourceSpecific iface:(OFString*)iface
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_join_multicast_group((GSocket*)[self castedGObject], [group castedGObject], sourceSpecific, [iface UTF8String], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)joinMulticastGroupSsm:(OGInetAddress*)group sourceSpecific:(OGInetAddress*)sourceSpecific iface:(OFString*)iface
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_join_multicast_group_ssm((GSocket*)[self castedGObject], [group castedGObject], [sourceSpecific castedGObject], [iface UTF8String], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)leaveMulticastGroup:(OGInetAddress*)group sourceSpecific:(bool)sourceSpecific iface:(OFString*)iface
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_leave_multicast_group((GSocket*)[self castedGObject], [group castedGObject], sourceSpecific, [iface UTF8String], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)leaveMulticastGroupSsm:(OGInetAddress*)group sourceSpecific:(OGInetAddress*)sourceSpecific iface:(OFString*)iface
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_leave_multicast_group_ssm((GSocket*)[self castedGObject], [group castedGObject], [sourceSpecific castedGObject], [iface UTF8String], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)listen
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_listen((GSocket*)[self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)receiveWithBuffer:(OFString*)buffer size:(gsize)size cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_socket_receive((GSocket*)[self castedGObject], g_strdup([buffer UTF8String]), size, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GBytes*)receiveBytesWithSize:(gsize)size timeoutUs:(gint64)timeoutUs cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GBytes* returnValue = (GBytes*)g_socket_receive_bytes((GSocket*)[self castedGObject], size, timeoutUs, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GBytes*)receiveBytesFromWithAddress:(GSocketAddress**)address size:(gsize)size timeoutUs:(gint64)timeoutUs cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GBytes* returnValue = (GBytes*)g_socket_receive_bytes_from((GSocket*)[self castedGObject], address, size, timeoutUs, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)receiveFromWithAddress:(GSocketAddress**)address buffer:(OFString*)buffer size:(gsize)size cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_socket_receive_from((GSocket*)[self castedGObject], address, g_strdup([buffer UTF8String]), size, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)receiveMessageWithAddress:(GSocketAddress**)address vectors:(GInputVector*)vectors numVectors:(gint)numVectors messages:(GSocketControlMessage***)messages numMessages:(gint*)numMessages flags:(gint*)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_socket_receive_message((GSocket*)[self castedGObject], address, vectors, numVectors, messages, numMessages, flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gint)receiveMessages:(GInputMessage*)messages numMessages:(guint)numMessages flags:(gint)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gint returnValue = (gint)g_socket_receive_messages((GSocket*)[self castedGObject], messages, numMessages, flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)receiveWithBlockingWithBuffer:(OFString*)buffer size:(gsize)size blocking:(bool)blocking cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_socket_receive_with_blocking((GSocket*)[self castedGObject], g_strdup([buffer UTF8String]), size, blocking, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)sendWithBuffer:(OFString*)buffer size:(gsize)size cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_socket_send((GSocket*)[self castedGObject], [buffer UTF8String], size, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)sendMessageWithAddress:(OGSocketAddress*)address vectors:(GOutputVector*)vectors numVectors:(gint)numVectors messages:(GSocketControlMessage**)messages numMessages:(gint)numMessages flags:(gint)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_socket_send_message((GSocket*)[self castedGObject], [address castedGObject], vectors, numVectors, messages, numMessages, flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GPollableReturn)sendMessageWithTimeoutWithAddress:(OGSocketAddress*)address vectors:(const GOutputVector*)vectors numVectors:(gint)numVectors messages:(GSocketControlMessage**)messages numMessages:(gint)numMessages flags:(gint)flags timeoutUs:(gint64)timeoutUs bytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GPollableReturn returnValue = (GPollableReturn)g_socket_send_message_with_timeout((GSocket*)[self castedGObject], [address castedGObject], vectors, numVectors, messages, numMessages, flags, timeoutUs, bytesWritten, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gint)sendMessages:(GOutputMessage*)messages numMessages:(guint)numMessages flags:(gint)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gint returnValue = (gint)g_socket_send_messages((GSocket*)[self castedGObject], messages, numMessages, flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)sendToWithAddress:(OGSocketAddress*)address buffer:(OFString*)buffer size:(gsize)size cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_socket_send_to((GSocket*)[self castedGObject], [address castedGObject], [buffer UTF8String], size, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)sendWithBlockingWithBuffer:(OFString*)buffer size:(gsize)size blocking:(bool)blocking cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_socket_send_with_blocking((GSocket*)[self castedGObject], [buffer UTF8String], size, blocking, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)setBlocking:(bool)blocking
{
	g_socket_set_blocking((GSocket*)[self castedGObject], blocking);
}

- (void)setBroadcast:(bool)broadcast
{
	g_socket_set_broadcast((GSocket*)[self castedGObject], broadcast);
}

- (void)setKeepalive:(bool)keepalive
{
	g_socket_set_keepalive((GSocket*)[self castedGObject], keepalive);
}

- (void)setListenBacklog:(gint)backlog
{
	g_socket_set_listen_backlog((GSocket*)[self castedGObject], backlog);
}

- (void)setMulticastLoopback:(bool)loopback
{
	g_socket_set_multicast_loopback((GSocket*)[self castedGObject], loopback);
}

- (void)setMulticastTtl:(guint)ttl
{
	g_socket_set_multicast_ttl((GSocket*)[self castedGObject], ttl);
}

- (bool)setOptionWithLevel:(gint)level optname:(gint)optname value:(gint)value
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_set_option((GSocket*)[self castedGObject], level, optname, value, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)setTimeout:(guint)timeout
{
	g_socket_set_timeout((GSocket*)[self castedGObject], timeout);
}

- (void)setTtl:(guint)ttl
{
	g_socket_set_ttl((GSocket*)[self castedGObject], ttl);
}

- (bool)shutdownWithShutdownRead:(bool)shutdownRead shutdownWrite:(bool)shutdownWrite
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_shutdown((GSocket*)[self castedGObject], shutdownRead, shutdownWrite, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)speaksIpv4
{
	bool returnValue = (bool)g_socket_speaks_ipv4((GSocket*)[self castedGObject]);

	return returnValue;
}


@end