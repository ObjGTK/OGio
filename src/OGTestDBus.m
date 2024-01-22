/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTestDBus.h"

@implementation OGTestDBus

+ (void)unset
{
	g_test_dbus_unset();
}

- (instancetype)init:(GTestDBusFlags)flags
{
	GTestDBus* gobjectValue = G_TEST_DBUS(g_test_dbus_new(flags));

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

- (GTestDBus*)castedGObject
{
	return G_TEST_DBUS([self gObject]);
}

- (void)addServiceDir:(OFString*)path
{
	g_test_dbus_add_service_dir([self castedGObject], [path UTF8String]);
}

- (void)down
{
	g_test_dbus_down([self castedGObject]);
}

- (OFString*)busAddress
{
	const gchar* gobjectValue = g_test_dbus_get_bus_address([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GTestDBusFlags)flags
{
	GTestDBusFlags returnValue = g_test_dbus_get_flags([self castedGObject]);

	return returnValue;
}

- (void)stop
{
	g_test_dbus_stop([self castedGObject]);
}

- (void)up
{
	g_test_dbus_up([self castedGObject]);
}


@end