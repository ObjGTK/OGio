/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDebugControllerDBus.h"

#import "OGDBusConnection.h"
#import "OGCancellable.h"

@implementation OGDebugControllerDBus

- (instancetype)initWithConnection:(OGDBusConnection*)connection cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDebugControllerDBus* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_debug_controller_dbus_new([connection castedGObject], [cancellable castedGObject], &err), GDebugControllerDBus, GDebugControllerDBus);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (GDebugControllerDBus*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GDebugControllerDBus, GDebugControllerDBus);
}

- (void)stop
{
	g_debug_controller_dbus_stop([self castedGObject]);
}


@end