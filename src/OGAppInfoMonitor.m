/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGAppInfoMonitor.h"

@implementation OGAppInfoMonitor

+ (OGAppInfoMonitor*)get
{
	GAppInfoMonitor* gobjectValue = G_APP_INFO_MONITOR(g_app_info_monitor_get());

	OGAppInfoMonitor* returnValue = [OGAppInfoMonitor withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GAppInfoMonitor*)castedGObject
{
	return G_APP_INFO_MONITOR([self gObject]);
}


@end