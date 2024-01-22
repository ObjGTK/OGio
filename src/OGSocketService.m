/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketService.h"

@implementation OGSocketService

- (instancetype)init
{
	GSocketService* gobjectValue = G_SOCKET_SERVICE(g_socket_service_new());

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

- (GSocketService*)castedGObject
{
	return G_SOCKET_SERVICE([self gObject]);
}

- (bool)isActive
{
	bool returnValue = g_socket_service_is_active([self castedGObject]);

	return returnValue;
}

- (void)start
{
	g_socket_service_start([self castedGObject]);
}

- (void)stop
{
	g_socket_service_stop([self castedGObject]);
}


@end