/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketService.h"

@implementation OGSocketService

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SOCKET_SERVICE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SOCKET_SERVICE);
	return gObjectClass;
}

+ (instancetype)socketService
{
	GSocketService* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_socket_service_new(), G_TYPE_SOCKET_SERVICE, GSocketService);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSocketService* wrapperObject;
	@try {
		wrapperObject = [[OGSocketService alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSocketService*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SOCKET_SERVICE, GSocketService);
}

- (bool)isActive
{
	bool returnValue = (bool)g_socket_service_is_active((GSocketService*)[self castedGObject]);

	return returnValue;
}

- (void)start
{
	g_socket_service_start((GSocketService*)[self castedGObject]);
}

- (void)stop
{
	g_socket_service_stop((GSocketService*)[self castedGObject]);
}


@end