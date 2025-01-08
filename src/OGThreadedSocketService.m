/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGThreadedSocketService.h"

@implementation OGThreadedSocketService

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_THREADED_SOCKET_SERVICE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithMaxThreads:(int)maxThreads
{
	GThreadedSocketService* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_threaded_socket_service_new(maxThreads), GThreadedSocketService, GThreadedSocketService);

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

- (GThreadedSocketService*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GThreadedSocketService, GThreadedSocketService);
}


@end