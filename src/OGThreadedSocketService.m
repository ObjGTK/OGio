/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGThreadedSocketService.h"

@implementation OGThreadedSocketService

- (instancetype)init:(int)maxThreads
{
	GThreadedSocketService* gobjectValue = G_THREADED_SOCKET_SERVICE(g_threaded_socket_service_new(maxThreads));

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
	return G_THREADED_SOCKET_SERVICE([self gObject]);
}


@end