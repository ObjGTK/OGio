/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFileMonitor.h"

@implementation OGFileMonitor

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_FILE_MONITOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (GFileMonitor*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GFileMonitor, GFileMonitor);
}

- (bool)cancel
{
	bool returnValue = (bool)g_file_monitor_cancel([self castedGObject]);

	return returnValue;
}

- (void)emitEventWithChild:(GFile*)child otherFile:(GFile*)otherFile eventType:(GFileMonitorEvent)eventType
{
	g_file_monitor_emit_event([self castedGObject], child, otherFile, eventType);
}

- (bool)isCancelled
{
	bool returnValue = (bool)g_file_monitor_is_cancelled([self castedGObject]);

	return returnValue;
}

- (void)setRateLimit:(gint)limitMsecs
{
	g_file_monitor_set_rate_limit([self castedGObject], limitMsecs);
}


@end