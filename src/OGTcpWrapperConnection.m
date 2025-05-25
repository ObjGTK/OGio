/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTcpWrapperConnection.h"

#import "OGIOStream.h"
#import "OGSocket.h"
#import "OGSocketConnection.h"

@implementation OGTcpWrapperConnection

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TCP_WRAPPER_CONNECTION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_TCP_WRAPPER_CONNECTION);
	return gObjectClass;
}

+ (instancetype)tcpWrapperConnectionWithBaseIoStream:(OGIOStream*)baseIoStream socket:(OGSocket*)socket
{
	GTcpWrapperConnection* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tcp_wrapper_connection_new([baseIoStream castedGObject], [socket castedGObject]), G_TYPE_TCP_WRAPPER_CONNECTION, GTcpWrapperConnection);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGTcpWrapperConnection* wrapperObject;
	@try {
		wrapperObject = [[OGTcpWrapperConnection alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GTcpWrapperConnection*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_TCP_WRAPPER_CONNECTION, GTcpWrapperConnection);
}

- (OGIOStream*)baseIoStream
{
	GIOStream* gobjectValue = g_tcp_wrapper_connection_get_base_io_stream([self castedGObject]);

	OGIOStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}


@end