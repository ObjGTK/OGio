/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusActionGroup.h"

#import "OGDBusConnection.h"

@implementation OGDBusActionGroup

+ (OGDBusActionGroup*)getWithConnection:(OGDBusConnection*)connection busName:(OFString*)busName objectPath:(OFString*)objectPath
{
	GDBusActionGroup* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_action_group_get([connection castedGObject], [busName UTF8String], [objectPath UTF8String]), GDBusActionGroup, GDBusActionGroup);

	OGDBusActionGroup* returnValue = [OGDBusActionGroup withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GDBusActionGroup*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GDBusActionGroup, GDBusActionGroup);
}


@end