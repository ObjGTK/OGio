/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTestDBus.h"

@implementation OGTestDBus

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TEST_DBUS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (void)unset
{
	g_test_dbus_unset();
}

+ (instancetype)testDBusWithFlags:(GTestDBusFlags)flags
{
	GTestDBus* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_test_dbus_new(flags), GTestDBus, GTestDBus);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGTestDBus* wrapperObject;
	@try {
		wrapperObject = [[OGTestDBus alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GTestDBus*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GTestDBus, GTestDBus);
}

- (void)addServiceDirWithPath:(OFString*)path
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
	GTestDBusFlags returnValue = (GTestDBusFlags)g_test_dbus_get_flags([self castedGObject]);

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