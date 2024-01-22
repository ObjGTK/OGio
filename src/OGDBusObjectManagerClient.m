/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusObjectManagerClient.h"

#import "OGDBusConnection.h"
#import "OGCancellable.h"

@implementation OGDBusObjectManagerClient

+ (void)newWithConnection:(OGDBusConnection*)connection flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_object_manager_client_new([connection castedGObject], flags, [name UTF8String], [objectPath UTF8String], getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, [cancellable castedGObject], callback, userData);
}

+ (void)newForBusWithBusType:(GBusType)busType flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_object_manager_client_new_for_bus(busType, flags, [name UTF8String], [objectPath UTF8String], getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, [cancellable castedGObject], callback, userData);
}

- (instancetype)initFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusObjectManagerClient* gobjectValue = G_DBUS_OBJECT_MANAGER_CLIENT(g_dbus_object_manager_client_new_finish(res, &err));

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

- (instancetype)initForBusFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusObjectManagerClient* gobjectValue = G_DBUS_OBJECT_MANAGER_CLIENT(g_dbus_object_manager_client_new_for_bus_finish(res, &err));

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

- (instancetype)initForBusSyncWithBusType:(GBusType)busType flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusObjectManagerClient* gobjectValue = G_DBUS_OBJECT_MANAGER_CLIENT(g_dbus_object_manager_client_new_for_bus_sync(busType, flags, [name UTF8String], [objectPath UTF8String], getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, [cancellable castedGObject], &err));

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

- (instancetype)initSyncWithConnection:(OGDBusConnection*)connection flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusObjectManagerClient* gobjectValue = G_DBUS_OBJECT_MANAGER_CLIENT(g_dbus_object_manager_client_new_sync([connection castedGObject], flags, [name UTF8String], [objectPath UTF8String], getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, [cancellable castedGObject], &err));

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

- (GDBusObjectManagerClient*)castedGObject
{
	return G_DBUS_OBJECT_MANAGER_CLIENT([self gObject]);
}

- (OGDBusConnection*)connection
{
	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_dbus_object_manager_client_get_connection([self castedGObject]));

	OGDBusConnection* returnValue = [OGDBusConnection wrapperFor:gobjectValue];
	return returnValue;
}

- (GDBusObjectManagerClientFlags)flags
{
	GDBusObjectManagerClientFlags returnValue = g_dbus_object_manager_client_get_flags([self castedGObject]);

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