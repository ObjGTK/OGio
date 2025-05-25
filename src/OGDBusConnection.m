/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusConnection.h"

#import "OGCancellable.h"
#import "OGCredentials.h"
#import "OGDBusAuthObserver.h"
#import "OGDBusMessage.h"
#import "OGIOStream.h"
#import "OGMenuModel.h"
#import "OGUnixFDList.h"

@implementation OGDBusConnection

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DBUS_CONNECTION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DBUS_CONNECTION);
	return gObjectClass;
}

+ (void)newWithStream:(OGIOStream*)stream guid:(OFString*)guid flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_new([stream castedGObject], [guid UTF8String], flags, [observer castedGObject], [cancellable castedGObject], callback, userData);
}

+ (void)newForAddress:(OFString*)address flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_new_for_address([address UTF8String], flags, [observer castedGObject], [cancellable castedGObject], callback, userData);
}

+ (instancetype)dBusConnectionFinishWithRes:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusConnection* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_connection_new_finish(res, &err), G_TYPE_DBUS_CONNECTION, GDBusConnection);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusConnection* wrapperObject;
	@try {
		wrapperObject = [[OGDBusConnection alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)dBusConnectionForAddressFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusConnection* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_connection_new_for_address_finish(res, &err), G_TYPE_DBUS_CONNECTION, GDBusConnection);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusConnection* wrapperObject;
	@try {
		wrapperObject = [[OGDBusConnection alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)dBusConnectionForAddressSync:(OFString*)address flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusConnection* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_connection_new_for_address_sync([address UTF8String], flags, [observer castedGObject], [cancellable castedGObject], &err), G_TYPE_DBUS_CONNECTION, GDBusConnection);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusConnection* wrapperObject;
	@try {
		wrapperObject = [[OGDBusConnection alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)dBusConnectionSyncWithStream:(OGIOStream*)stream guid:(OFString*)guid flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusConnection* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_connection_new_sync([stream castedGObject], [guid UTF8String], flags, [observer castedGObject], [cancellable castedGObject], &err), G_TYPE_DBUS_CONNECTION, GDBusConnection);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusConnection* wrapperObject;
	@try {
		wrapperObject = [[OGDBusConnection alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GDBusConnection*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DBUS_CONNECTION, GDBusConnection);
}

- (guint)addFilterWithFilterFunction:(GDBusMessageFilterFunction)filterFunction userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc
{
	guint returnValue = (guint)g_dbus_connection_add_filter((GDBusConnection*)[self castedGObject], filterFunction, userData, userDataFreeFunc);

	return returnValue;
}

- (void)callWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_call((GDBusConnection*)[self castedGObject], [busName UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [methodName UTF8String], parameters, replyType, flags, timeoutMsec, [cancellable castedGObject], callback, userData);
}

- (GVariant*)callFinishWithRes:(GAsyncResult*)res
{
	GError* err = NULL;

	GVariant* returnValue = (GVariant*)g_dbus_connection_call_finish((GDBusConnection*)[self castedGObject], res, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GVariant*)callSyncWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GVariant* returnValue = (GVariant*)g_dbus_connection_call_sync((GDBusConnection*)[self castedGObject], [busName UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [methodName UTF8String], parameters, replyType, flags, timeoutMsec, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)callWithUnixFdListWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_call_with_unix_fd_list((GDBusConnection*)[self castedGObject], [busName UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [methodName UTF8String], parameters, replyType, flags, timeoutMsec, [fdList castedGObject], [cancellable castedGObject], callback, userData);
}

- (GVariant*)callWithUnixFdListFinishWithOutFdList:(GUnixFDList**)outFdList res:(GAsyncResult*)res
{
	GError* err = NULL;

	GVariant* returnValue = (GVariant*)g_dbus_connection_call_with_unix_fd_list_finish((GDBusConnection*)[self castedGObject], outFdList, res, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GVariant*)callWithUnixFdListSyncWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList outFdList:(GUnixFDList**)outFdList cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GVariant* returnValue = (GVariant*)g_dbus_connection_call_with_unix_fd_list_sync((GDBusConnection*)[self castedGObject], [busName UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [methodName UTF8String], parameters, replyType, flags, timeoutMsec, [fdList castedGObject], outFdList, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)closeWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_close((GDBusConnection*)[self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)closeFinishWithRes:(GAsyncResult*)res
{
	GError* err = NULL;

	bool returnValue = (bool)g_dbus_connection_close_finish((GDBusConnection*)[self castedGObject], res, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)closeSyncWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_dbus_connection_close_sync((GDBusConnection*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)emitSignalWithDestinationBusName:(OFString*)destinationBusName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName signalName:(OFString*)signalName parameters:(GVariant*)parameters
{
	GError* err = NULL;

	bool returnValue = (bool)g_dbus_connection_emit_signal((GDBusConnection*)[self castedGObject], [destinationBusName UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [signalName UTF8String], parameters, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (guint)exportActionGroupWithObjectPath:(OFString*)objectPath actionGroup:(GActionGroup*)actionGroup
{
	GError* err = NULL;

	guint returnValue = (guint)g_dbus_connection_export_action_group((GDBusConnection*)[self castedGObject], [objectPath UTF8String], actionGroup, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (guint)exportMenuModelWithObjectPath:(OFString*)objectPath menu:(OGMenuModel*)menu
{
	GError* err = NULL;

	guint returnValue = (guint)g_dbus_connection_export_menu_model((GDBusConnection*)[self castedGObject], [objectPath UTF8String], [menu castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)flushWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_flush((GDBusConnection*)[self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)flushFinishWithRes:(GAsyncResult*)res
{
	GError* err = NULL;

	bool returnValue = (bool)g_dbus_connection_flush_finish((GDBusConnection*)[self castedGObject], res, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)flushSyncWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_dbus_connection_flush_sync((GDBusConnection*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GDBusCapabilityFlags)capabilities
{
	GDBusCapabilityFlags returnValue = (GDBusCapabilityFlags)g_dbus_connection_get_capabilities((GDBusConnection*)[self castedGObject]);

	return returnValue;
}

- (bool)exitOnClose
{
	bool returnValue = (bool)g_dbus_connection_get_exit_on_close((GDBusConnection*)[self castedGObject]);

	return returnValue;
}

- (GDBusConnectionFlags)flags
{
	GDBusConnectionFlags returnValue = (GDBusConnectionFlags)g_dbus_connection_get_flags((GDBusConnection*)[self castedGObject]);

	return returnValue;
}

- (OFString*)guid
{
	const gchar* gobjectValue = g_dbus_connection_get_guid((GDBusConnection*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (guint32)lastSerial
{
	guint32 returnValue = (guint32)g_dbus_connection_get_last_serial((GDBusConnection*)[self castedGObject]);

	return returnValue;
}

- (OGCredentials*)peerCredentials
{
	GCredentials* gobjectValue = g_dbus_connection_get_peer_credentials((GDBusConnection*)[self castedGObject]);

	OGCredentials* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OGIOStream*)stream
{
	GIOStream* gobjectValue = g_dbus_connection_get_stream((GDBusConnection*)[self castedGObject]);

	OGIOStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OFString*)uniqueName
{
	const gchar* gobjectValue = g_dbus_connection_get_unique_name((GDBusConnection*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = (bool)g_dbus_connection_is_closed((GDBusConnection*)[self castedGObject]);

	return returnValue;
}

- (guint)registerObjectWithObjectPath:(OFString*)objectPath interfaceInfo:(GDBusInterfaceInfo*)interfaceInfo vtable:(const GDBusInterfaceVTable*)vtable userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc
{
	GError* err = NULL;

	guint returnValue = (guint)g_dbus_connection_register_object((GDBusConnection*)[self castedGObject], [objectPath UTF8String], interfaceInfo, vtable, userData, userDataFreeFunc, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (guint)registerObjectWithClosuresWithObjectPath:(OFString*)objectPath interfaceInfo:(GDBusInterfaceInfo*)interfaceInfo methodCallClosure:(GClosure*)methodCallClosure getPropertyClosure:(GClosure*)getPropertyClosure setPropertyClosure:(GClosure*)setPropertyClosure
{
	GError* err = NULL;

	guint returnValue = (guint)g_dbus_connection_register_object_with_closures((GDBusConnection*)[self castedGObject], [objectPath UTF8String], interfaceInfo, methodCallClosure, getPropertyClosure, setPropertyClosure, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (guint)registerSubtreeWithObjectPath:(OFString*)objectPath vtable:(const GDBusSubtreeVTable*)vtable flags:(GDBusSubtreeFlags)flags userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc
{
	GError* err = NULL;

	guint returnValue = (guint)g_dbus_connection_register_subtree((GDBusConnection*)[self castedGObject], [objectPath UTF8String], vtable, flags, userData, userDataFreeFunc, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)removeFilterWithFilterId:(guint)filterId
{
	g_dbus_connection_remove_filter((GDBusConnection*)[self castedGObject], filterId);
}

- (bool)sendMessage:(OGDBusMessage*)message flags:(GDBusSendMessageFlags)flags outSerial:(volatile guint32*)outSerial
{
	GError* err = NULL;

	bool returnValue = (bool)g_dbus_connection_send_message((GDBusConnection*)[self castedGObject], [message castedGObject], flags, outSerial, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)sendMessageWithReply:(OGDBusMessage*)message flags:(GDBusSendMessageFlags)flags timeoutMsec:(gint)timeoutMsec outSerial:(volatile guint32*)outSerial cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_connection_send_message_with_reply((GDBusConnection*)[self castedGObject], [message castedGObject], flags, timeoutMsec, outSerial, [cancellable castedGObject], callback, userData);
}

- (OGDBusMessage*)sendMessageWithReplyFinishWithRes:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusMessage* gobjectValue = g_dbus_connection_send_message_with_reply_finish((GDBusConnection*)[self castedGObject], res, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusMessage* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGDBusMessage*)sendMessageWithReplySync:(OGDBusMessage*)message flags:(GDBusSendMessageFlags)flags timeoutMsec:(gint)timeoutMsec outSerial:(volatile guint32*)outSerial cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusMessage* gobjectValue = g_dbus_connection_send_message_with_reply_sync((GDBusConnection*)[self castedGObject], [message castedGObject], flags, timeoutMsec, outSerial, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusMessage* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)setExitOnClose:(bool)exitOnClose
{
	g_dbus_connection_set_exit_on_close((GDBusConnection*)[self castedGObject], exitOnClose);
}

- (guint)signalSubscribeWithSender:(OFString*)sender interfaceName:(OFString*)interfaceName member:(OFString*)member objectPath:(OFString*)objectPath arg0:(OFString*)arg0 flags:(GDBusSignalFlags)flags callback:(GDBusSignalCallback)callback userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc
{
	guint returnValue = (guint)g_dbus_connection_signal_subscribe((GDBusConnection*)[self castedGObject], [sender UTF8String], [interfaceName UTF8String], [member UTF8String], [objectPath UTF8String], [arg0 UTF8String], flags, callback, userData, userDataFreeFunc);

	return returnValue;
}

- (void)signalUnsubscribeWithSubscriptionId:(guint)subscriptionId
{
	g_dbus_connection_signal_unsubscribe((GDBusConnection*)[self castedGObject], subscriptionId);
}

- (void)startMessageProcessing
{
	g_dbus_connection_start_message_processing((GDBusConnection*)[self castedGObject]);
}

- (void)unexportActionGroupWithExportId:(guint)exportId
{
	g_dbus_connection_unexport_action_group((GDBusConnection*)[self castedGObject], exportId);
}

- (void)unexportMenuModelWithExportId:(guint)exportId
{
	g_dbus_connection_unexport_menu_model((GDBusConnection*)[self castedGObject], exportId);
}

- (bool)unregisterObjectWithRegistrationId:(guint)registrationId
{
	bool returnValue = (bool)g_dbus_connection_unregister_object((GDBusConnection*)[self castedGObject], registrationId);

	return returnValue;
}

- (bool)unregisterSubtreeWithRegistrationId:(guint)registrationId
{
	bool returnValue = (bool)g_dbus_connection_unregister_subtree((GDBusConnection*)[self castedGObject], registrationId);

	return returnValue;
}


@end