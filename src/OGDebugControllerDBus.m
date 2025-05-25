/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDebugControllerDBus.h"

#import "OGCancellable.h"
#import "OGDBusConnection.h"

@implementation OGDebugControllerDBus

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DEBUG_CONTROLLER_DBUS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DEBUG_CONTROLLER_DBUS);
	return gObjectClass;
}

+ (instancetype)debugControllerDBusWithConnection:(OGDBusConnection*)connection cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDebugControllerDBus* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_debug_controller_dbus_new([connection castedGObject], [cancellable castedGObject], &err), G_TYPE_DEBUG_CONTROLLER_DBUS, GDebugControllerDBus);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDebugControllerDBus* wrapperObject;
	@try {
		wrapperObject = [[OGDebugControllerDBus alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GDebugControllerDBus*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DEBUG_CONTROLLER_DBUS, GDebugControllerDBus);
}

- (void)stop
{
	g_debug_controller_dbus_stop([self castedGObject]);
}


@end