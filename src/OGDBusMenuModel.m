/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusMenuModel.h"

#import "OGDBusConnection.h"

@implementation OGDBusMenuModel

+ (OGDBusMenuModel*)getWithConnection:(OGDBusConnection*)connection busName:(OFString*)busName objectPath:(OFString*)objectPath
{
	GDBusMenuModel* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_menu_model_get([connection castedGObject], [busName UTF8String], [objectPath UTF8String]), GDBusMenuModel, GDBusMenuModel);

	OGDBusMenuModel* returnValue = [OGDBusMenuModel withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GDBusMenuModel*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GDBusMenuModel, GDBusMenuModel);
}


@end