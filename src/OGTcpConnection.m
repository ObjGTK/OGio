/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTcpConnection.h"

@implementation OGTcpConnection

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TCP_CONNECTION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_TCP_CONNECTION);
	return gObjectClass;
}

- (GTcpConnection*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_TCP_CONNECTION, GTcpConnection);
}

- (bool)gracefulDisconnect
{
	bool returnValue = (bool)g_tcp_connection_get_graceful_disconnect((GTcpConnection*)[self castedGObject]);

	return returnValue;
}

- (void)setGracefulDisconnect:(bool)gracefulDisconnect
{
	g_tcp_connection_set_graceful_disconnect((GTcpConnection*)[self castedGObject], gracefulDisconnect);
}


@end