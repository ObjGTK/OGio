/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusObjectManagerClient.h"

#import "OGCancellable.h"
#import "OGDBusConnection.h"

@implementation OGDBusObjectManagerClient

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DBUS_OBJECT_MANAGER_CLIENT;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (void)newWithConnection:(OGDBusConnection*)connection flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_object_manager_client_new([connection castedGObject], flags, [name UTF8String], [objectPath UTF8String], getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, [cancellable castedGObject], callback, userData);
}

+ (void)newForBusWithBusType:(GBusType)busType flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_object_manager_client_new_for_bus(busType, flags, [name UTF8String], [objectPath UTF8String], getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, [cancellable castedGObject], callback, userData);
}

- (instancetype)initWithResFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusObjectManagerClient* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_object_manager_client_new_finish(res, &err), GDBusObjectManagerClient, GDBusObjectManagerClient);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

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

- (instancetype)initWithResForBusFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusObjectManagerClient* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_object_manager_client_new_for_bus_finish(res, &err), GDBusObjectManagerClient, GDBusObjectManagerClient);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

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

- (instancetype)initForBusSyncWithBusType:(GBusType)busType flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusObjectManagerClient* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_object_manager_client_new_for_bus_sync(busType, flags, [name UTF8String], [objectPath UTF8String], getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, [cancellable castedGObject], &err), GDBusObjectManagerClient, GDBusObjectManagerClient);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

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

- (instancetype)initSyncWithConnection:(OGDBusConnection*)connection flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusObjectManagerClient* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_object_manager_client_new_sync([connection castedGObject], flags, [name UTF8String], [objectPath UTF8String], getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, [cancellable castedGObject], &err), GDBusObjectManagerClient, GDBusObjectManagerClient);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

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

- (GDBusObjectManagerClient*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GDBusObjectManagerClient, GDBusObjectManagerClient);
}

- (OGDBusConnection*)connection
{
	GDBusConnection* gobjectValue = g_dbus_object_manager_client_get_connection([self castedGObject]);

	OGDBusConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (GDBusObjectManagerClientFlags)flags
{
	GDBusObjectManagerClientFlags returnValue = (GDBusObjectManagerClientFlags)g_dbus_object_manager_client_get_flags([self castedGObject]);

	return returnValue;
}

- (OFString*)name
{
	const gchar* gobjectValue = g_dbus_object_manager_client_get_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)nameOwner
{
	gchar* gobjectValue = g_dbus_object_manager_client_get_name_owner([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}


@end