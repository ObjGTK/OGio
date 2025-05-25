/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFileMonitor.h"

@implementation OGFileMonitor

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_FILE_MONITOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_FILE_MONITOR);
	return gObjectClass;
}

- (GFileMonitor*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_FILE_MONITOR, GFileMonitor);
}

- (bool)cancel
{
	bool returnValue = (bool)g_file_monitor_cancel((GFileMonitor*)[self castedGObject]);

	return returnValue;
}

- (void)emitEventWithChild:(GFile*)child otherFile:(GFile*)otherFile eventType:(GFileMonitorEvent)eventType
{
	g_file_monitor_emit_event((GFileMonitor*)[self castedGObject], child, otherFile, eventType);
}

- (bool)isCancelled
{
	bool returnValue = (bool)g_file_monitor_is_cancelled((GFileMonitor*)[self castedGObject]);

	return returnValue;
}

- (void)setRateLimitWithLimitMsecs:(gint)limitMsecs
{
	g_file_monitor_set_rate_limit((GFileMonitor*)[self castedGObject], limitMsecs);
}


@end