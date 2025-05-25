/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusActionGroup.h"

#import "OGDBusConnection.h"

@implementation OGDBusActionGroup

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DBUS_ACTION_GROUP;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DBUS_ACTION_GROUP);
	return gObjectClass;
}

+ (OGDBusActionGroup*)getWithConnection:(OGDBusConnection*)connection busName:(OFString*)busName objectPath:(OFString*)objectPath
{
	GDBusActionGroup* gobjectValue = g_dbus_action_group_get([connection castedGObject], [busName UTF8String], [objectPath UTF8String]);

	OGDBusActionGroup* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GDBusActionGroup*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DBUS_ACTION_GROUP, GDBusActionGroup);
}


@end