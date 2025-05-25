/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixMountMonitor.h"

@implementation OGUnixMountMonitor

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_UNIX_MOUNT_MONITOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_UNIX_MOUNT_MONITOR);
	return gObjectClass;
}

+ (OGUnixMountMonitor*)get
{
	GUnixMountMonitor* gobjectValue = g_unix_mount_monitor_get();

	OGUnixMountMonitor* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

+ (instancetype)unixMountMonitor
{
	GUnixMountMonitor* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_mount_monitor_new(), G_TYPE_UNIX_MOUNT_MONITOR, GUnixMountMonitor);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGUnixMountMonitor* wrapperObject;
	@try {
		wrapperObject = [[OGUnixMountMonitor alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GUnixMountMonitor*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_UNIX_MOUNT_MONITOR, GUnixMountMonitor);
}

- (void)setRateLimitWithLimitMsec:(int)limitMsec
{
	g_unix_mount_monitor_set_rate_limit((GUnixMountMonitor*)[self castedGObject], limitMsec);
}


@end