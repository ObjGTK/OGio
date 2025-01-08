/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketService.h"

@implementation OGSocketService

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SOCKET_SERVICE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)init
{
	GSocketService* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_socket_service_new(), GSocketService, GSocketService);

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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSocketService, GSocketService);
}

- (bool)isActive
{
	bool returnValue = (bool)g_socket_service_is_active([self castedGObject]);

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