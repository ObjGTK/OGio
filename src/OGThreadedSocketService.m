/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGThreadedSocketService.h"

@implementation OGThreadedSocketService

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_THREADED_SOCKET_SERVICE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_THREADED_SOCKET_SERVICE);
	return gObjectClass;
}

+ (instancetype)threadedSocketServiceWithMaxThreads:(int)maxThreads
{
	GThreadedSocketService* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_threaded_socket_service_new(maxThreads), G_TYPE_THREADED_SOCKET_SERVICE, GThreadedSocketService);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGThreadedSocketService* wrapperObject;
	@try {
		wrapperObject = [[OGThreadedSocketService alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GThreadedSocketService*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_THREADED_SOCKET_SERVICE, GThreadedSocketService);
}


@end