/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixMountMonitor.h"

@implementation OGUnixMountMonitor

+ (OGUnixMountMonitor*)get
{
	GUnixMountMonitor* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_mount_monitor_get(), GUnixMountMonitor, GUnixMountMonitor);

	OGUnixMountMonitor* returnValue = [OGUnixMountMonitor withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (instancetype)init
{
	GUnixMountMonitor* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_mount_monitor_new(), GUnixMountMonitor, GUnixMountMonitor);

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

- (GUnixMountMonitor*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GUnixMountMonitor, GUnixMountMonitor);
}

- (void)setRateLimit:(int)limitMsec
{
	g_unix_mount_monitor_set_rate_limit([self castedGObject], limitMsec);
}


@end