/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInetSocketAddress.h"

#import "OGInetAddress.h"

@implementation OGInetSocketAddress

- (instancetype)initWithAddress:(OGInetAddress*)address port:(guint16)port
{
	GInetSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_socket_address_new([address castedGObject], port), GInetSocketAddress, GInetSocketAddress);

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

- (instancetype)initFromStringWithAddress:(OFString*)address port:(guint)port
{
	GInetSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_socket_address_new_from_string([address UTF8String], port), GInetSocketAddress, GInetSocketAddress);

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

- (GInetSocketAddress*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GInetSocketAddress, GInetSocketAddress);
}

- (OGInetAddress*)address
{
	GInetAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_socket_address_get_address([self castedGObject]), GInetAddress, GInetAddress);

	OGInetAddress* returnValue = [OGInetAddress withGObject:gobjectValue];
	return returnValue;
}

- (guint32)flowinfo
{
	guint32 returnValue = g_inet_socket_address_get_flowinfo([self castedGObject]);

	return returnValue;
}

- (guint16)port
{
	guint16 returnValue = g_inet_socket_address_get_port([self castedGObject]);

	return returnValue;
}

- (guint32)scopeId
{
	guint32 returnValue = g_inet_socket_address_get_scope_id([self castedGObject]);

	return returnValue;
}


@end