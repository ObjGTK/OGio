/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGAppInfoMonitor.h"

@implementation OGAppInfoMonitor

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_APP_INFO_MONITOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (OGAppInfoMonitor*)get
{
	GAppInfoMonitor* gobjectValue = g_app_info_monitor_get();

	OGAppInfoMonitor* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GAppInfoMonitor*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GAppInfoMonitor, GAppInfoMonitor);
}


@end