/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGAppInfoMonitor.h"

@implementation OGAppInfoMonitor

+ (OGAppInfoMonitor*)get
{
	GAppInfoMonitor* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_app_info_monitor_get(), GAppInfoMonitor, GAppInfoMonitor);

	OGAppInfoMonitor* returnValue = [OGAppInfoMonitor withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GAppInfoMonitor*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GAppInfoMonitor, GAppInfoMonitor);
}


@end