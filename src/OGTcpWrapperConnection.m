/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTcpWrapperConnection.h"

#import "OGSocketConnection.h"
#import "OGSocket.h"
#import "OGIOStream.h"

@implementation OGTcpWrapperConnection

- (instancetype)initWithBaseIoStream:(OGIOStream*)baseIoStream socket:(OGSocket*)socket
{
	GTcpWrapperConnection* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tcp_wrapper_connection_new([baseIoStream castedGObject], [socket castedGObject]), GTcpWrapperConnection, GTcpWrapperConnection);

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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GTcpWrapperConnection, GTcpWrapperConnection);
}

- (OGIOStream*)baseIoStream
{
	GIOStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tcp_wrapper_connection_get_base_io_stream([self castedGObject]), GIOStream, GIOStream);

	OGIOStream* returnValue = [OGIOStream withGObject:gobjectValue];
	return returnValue;
}


@end