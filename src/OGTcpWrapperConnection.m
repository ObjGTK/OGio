/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTcpWrapperConnection.h"

#import "OGSocket.h"
#import "OGIOStream.h"
#import "OGSocketConnection.h"

@implementation OGTcpWrapperConnection

- (instancetype)initWithBaseIoStream:(OGIOStream*)baseIoStream socket:(OGSocket*)socket
{
	GTcpWrapperConnection* gobjectValue = G_TCP_WRAPPER_CONNECTION(g_tcp_wrapper_connection_new([baseIoStream castedGObject], [socket castedGObject]));

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

- (GTcpWrapperConnection*)castedGObject
{
	return G_TCP_WRAPPER_CONNECTION([self gObject]);
}

- (OGIOStream*)baseIoStream
{
	GIOStream* gobjectValue = G_IO_STREAM(g_tcp_wrapper_connection_get_base_io_stream([self castedGObject]));

	OGIOStream* returnValue = [OGIOStream withGObject:gobjectValue];
	return returnValue;
}


@end