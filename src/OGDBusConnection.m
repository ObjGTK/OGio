/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusConnection.h"

#import "OGMenuModel.h"
#import "OGDBusMessage.h"
#import "OGDBusAuthObserver.h"
#import "OGIOStream.h"
#import "OGCancellable.h"
#import "OGUnixFDList.h"
#import "OGCredentials.h"

@implementation OGDBusConnection

+ (void)newWithStream:(OGIOStream*)stream guid:(OFString*)guid flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_new([stream castedGObject], [guid UTF8String], flags, [observer castedGObject], [cancellable castedGObject], callback, userData);
}

+ (void)newForAddressWithAddress:(OFString*)address flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_new_for_address([address UTF8String], flags, [observer castedGObject], [cancellable castedGObject], callback, userData);
}

- (instancetype)initFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_dbus_connection_new_finish(res, &err));

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

- (instancetype)initForAddressFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_dbus_connection_new_for_address_finish(res, &err));

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

- (instancetype)initForAddressSyncWithAddress:(OFString*)address flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_dbus_connection_new_for_address_sync([address UTF8String], flags, [observer castedGObject], [cancellable castedGObject], &err));

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

- (instancetype)initSyncWithStream:(OGIOStream*)stream guid:(OFString*)guid flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_dbus_connection_new_sync([stream castedGObject], [guid UTF8String], flags, [observer castedGObject], [cancellable castedGObject], &err));

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

- (GDBusConnection*)castedGObject
{
	return G_DBUS_CONNECTION([self gObject]);
}

- (guint)addFilterWithFilterFunction:(GDBusMessageFilterFunction)filterFunction userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc
{
	guint returnValue = g_dbus_connection_add_filter([self castedGObject], filterFunction, userData, userDataFreeFunc);

	return returnValue;
}

- (void)callWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_call([self castedGObject], [busName UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [methodName UTF8String], parameters, replyType, flags, timeoutMsec, [cancellable castedGObject], callback, userData);
}

- (GVariant*)callFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GVariant* returnValue = g_dbus_connection_call_finish([self castedGObject], res, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GVariant*)callSyncWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GVariant* returnValue = g_dbus_connection_call_sync([self castedGObject], [busName UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [methodName UTF8String], parameters, replyType, flags, timeoutMsec, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)callWithUnixFdListWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_call_with_unix_fd_list([self castedGObject], [busName UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [methodName UTF8String], parameters, replyType, flags, timeoutMsec, [fdList castedGObject], [cancellable castedGObject], callback, userData);
}

- (GVariant*)callWithUnixFdListFinishWithOutFdList:(GUnixFDList**)outFdList res:(GAsyncResult*)res
{
	GError* err = NULL;

	GVariant* returnValue = g_dbus_connection_call_with_unix_fd_list_finish([self castedGObject], outFdList, res, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GVariant*)callWithUnixFdListSyncWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList outFdList:(GUnixFDList**)outFdList cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GVariant* returnValue = g_dbus_connection_call_with_unix_fd_list_sync([self castedGObject], [busName UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [methodName UTF8String], parameters, replyType, flags, timeoutMsec, [fdList castedGObject], outFdList, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)closeWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_close([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)closeFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	bool returnValue = g_dbus_connection_close_finish([self castedGObject], res, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)closeSync:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_dbus_connection_close_sync([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)emitSignalWithDestinationBusName:(OFString*)destinationBusName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName signalName:(OFString*)signalName parameters:(GVariant*)parameters
{
	GError* err = NULL;

	bool returnValue = g_dbus_connection_emit_signal([self castedGObject], [destinationBusName UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [signalName UTF8String], parameters, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (guint)exportActionGroupWithObjectPath:(OFString*)objectPath actionGroup:(GActionGroup*)actionGroup
{
	GError* err = NULL;

	guint returnValue = g_dbus_connection_export_action_group([self castedGObject], [objectPath UTF8String], actionGroup, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (guint)exportMenuModelWithObjectPath:(OFString*)objectPath menu:(OGMenuModel*)menu
{
	GError* err = NULL;

	guint returnValue = g_dbus_connection_export_menu_model([self castedGObject], [objectPath UTF8String], [menu castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)flushWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_flush([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)flushFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	bool returnValue = g_dbus_connection_flush_finish([self castedGObject], res, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)flushSync:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_dbus_connection_flush_sync([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GDBusCapabilityFlags)capabilities
{
	GDBusCapabilityFlags returnValue = g_dbus_connection_get_capabilities([self castedGObject]);

	return returnValue;
}

- (bool)exitOnClose
{
	bool returnValue = g_dbus_connection_get_exit_on_close([self castedGObject]);

	return returnValue;
}

- (GDBusConnectionFlags)flags
{
	GDBusConnectionFlags returnValue = g_dbus_connection_get_flags([self castedGObject]);

	return returnValue;
}

- (OFString*)guid
{
	const gchar* gobjectValue = g_dbus_connection_get_guid([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (guint32)lastSerial
{
	guint32 returnValue = g_dbus_connection_get_last_serial([self castedGObject]);

	return returnValue;
}

- (OGCredentials*)peerCredentials
{
	GCredentials* gobjectValue = G_CREDENTIALS(g_dbus_connection_get_peer_credentials([self castedGObject]));

	OGCredentials* returnValue = [OGCredentials wrapperFor:gobjectValue];
	return returnValue;
}

- (OGIOStream*)stream
{
	GIOStream* gobjectValue = G_IO_STREAM(g_dbus_connection_get_stream([self castedGObject]));

	OGIOStream* returnValue = [OGIOStream wrapperFor:gobjectValue];
	return returnValue;
}

- (OFString*)uniqueName
{
	const gchar* gobjectValue = g_dbus_connection_get_unique_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = g_dbus_connection_is_closed([self castedGObject]);

	return returnValue;
}

- (guint)registerObjectWithObjectPath:(OFString*)objectPath interfaceInfo:(GDBusInterfaceInfo*)interfaceInfo vtable:(const GDBusInterfaceVTable*)vtable userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc
{
	GError* err = NULL;

	guint returnValue = g_dbus_connection_register_object([self castedGObject], [objectPath UTF8String], interfaceInfo, vtable, userData, userDataFreeFunc, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (guint)registerObjectWithClosuresWithObjectPath:(OFString*)objectPath interfaceInfo:(GDBusInterfaceInfo*)interfaceInfo methodCallClosure:(GClosure*)methodCallClosure getPropertyClosure:(GClosure*)getPropertyClosure setPropertyClosure:(GClosure*)setPropertyClosure
{
	GError* err = NULL;

	guint returnValue = g_dbus_connection_register_object_with_closures([self castedGObject], [objectPath UTF8String], interfaceInfo, methodCallClosure, getPropertyClosure, setPropertyClosure, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (guint)registerSubtreeWithObjectPath:(OFString*)objectPath vtable:(const GDBusSubtreeVTable*)vtable flags:(GDBusSubtreeFlags)flags userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc
{
	GError* err = NULL;

	guint returnValue = g_dbus_connection_register_subtree([self castedGObject], [objectPath UTF8String], vtable, flags, userData, userDataFreeFunc, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)removeFilter:(guint)filterId
{
	g_dbus_connection_remove_filter([self castedGObject], filterId);
}

- (bool)sendMessageWithMessage:(OGDBusMessage*)message flags:(GDBusSendMessageFlags)flags outSerial:(volatile guint32*)outSerial
{
	GError* err = NULL;

	bool returnValue = g_dbus_connection_send_message([self castedGObject], [message castedGObject], flags, outSerial, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)sendMessageWithReplyWithMessage:(OGDBusMessage*)message flags:(GDBusSendMessageFlags)flags timeoutMsec:(gint)timeoutMsec outSerial:(volatile guint32*)outSerial cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_send_message_with_reply([self castedGObject], [message castedGObject], flags, timeoutMsec, outSerial, [cancellable castedGObject], callback, userData);
}

- (OGDBusMessage*)sendMessageWithReplyFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_connection_send_message_with_reply_finish([self castedGObject], res, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGDBusMessage* returnValue = [OGDBusMessage wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGDBusMessage*)sendMessageWithReplySyncWithMessage:(OGDBusMessage*)message flags:(GDBusSendMessageFlags)flags timeoutMsec:(gint)timeoutMsec outSerial:(volatile guint32*)outSerial cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_connection_send_message_with_reply_sync([self castedGObject], [message castedGObject], flags, timeoutMsec, outSerial, [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGDBusMessage* returnValue = [OGDBusMessage wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)setExitOnClose:(bool)exitOnClose
{
	g_dbus_connection_set_exit_on_close([self castedGObject], exitOnClose);
}

- (guint)signalSubscribeWithSender:(OFString*)sender interfaceName:(OFString*)interfaceName member:(OFString*)member objectPath:(OFString*)objectPath arg0:(OFString*)arg0 flags:(GDBusSignalFlags)flags callback:(GDBusSignalCallback)callback userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc
{
	guint returnValue = g_dbus_connection_signal_subscribe([self castedGObject], [sender UTF8String], [interfaceName UTF8String], [member UTF8String], [objectPath UTF8String], [arg0 UTF8String], flags, callback, userData, userDataFreeFunc);

	return returnValue;
}

- (void)signalUnsubscribe:(guint)subscriptionId
{
	g_dbus_connection_signal_unsubscribe([self castedGObject], subscriptionId);
}

- (void)startMessageProcessing
{
	g_dbus_connection_start_message_processing([self castedGObject]);
}

- (void)unexportActionGroup:(guint)exportId
{
	g_dbus_connection_unexport_action_group([self castedGObject], exportId);
}

- (void)unexportMenuModel:(guint)exportId
{
	g_dbus_connection_unexport_menu_model([self castedGObject], exportId);
}

- (bool)unregisterObject:(guint)registrationId
{
	bool returnValue = g_dbus_connection_unregister_object([self castedGObject], registrationId);

	return returnValue;
}

- (bool)unregisterSubtree:(guint)registrationId
{
	bool returnValue = g_dbus_connection_unregister_subtree([self castedGObject], registrationId);

	return returnValue;
}


@end