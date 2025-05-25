/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusMessage.h"

#import "OGUnixFDList.h"

@implementation OGDBusMessage

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DBUS_MESSAGE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DBUS_MESSAGE);
	return gObjectClass;
}

+ (gssize)bytesNeededWithBlob:(guchar*)blob blobLen:(gsize)blobLen
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_dbus_message_bytes_needed(blob, blobLen, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

+ (instancetype)dBusMessage
{
	GDBusMessage* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_message_new(), G_TYPE_DBUS_MESSAGE, GDBusMessage);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGDBusMessage* wrapperObject;
	@try {
		wrapperObject = [[OGDBusMessage alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)dBusMessageFromBlob:(guchar*)blob blobLen:(gsize)blobLen capabilities:(GDBusCapabilityFlags)capabilities
{
	GError* err = NULL;

	GDBusMessage* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_message_new_from_blob(blob, blobLen, capabilities, &err), G_TYPE_DBUS_MESSAGE, GDBusMessage);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusMessage* wrapperObject;
	@try {
		wrapperObject = [[OGDBusMessage alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)dBusMessageMethodCallWithName:(OFString*)name path:(OFString*)path interface:(OFString*)interface method:(OFString*)method
{
	GDBusMessage* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_message_new_method_call([name UTF8String], [path UTF8String], [interface UTF8String], [method UTF8String]), G_TYPE_DBUS_MESSAGE, GDBusMessage);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGDBusMessage* wrapperObject;
	@try {
		wrapperObject = [[OGDBusMessage alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)dBusMessageSignalWithPath:(OFString*)path interface:(OFString*)interface signal:(OFString*)signal
{
	GDBusMessage* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_message_new_signal([path UTF8String], [interface UTF8String], [signal UTF8String]), G_TYPE_DBUS_MESSAGE, GDBusMessage);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGDBusMessage* wrapperObject;
	@try {
		wrapperObject = [[OGDBusMessage alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GDBusMessage*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DBUS_MESSAGE, GDBusMessage);
}

- (OGDBusMessage*)copy
{
	GError* err = NULL;

	GDBusMessage* gobjectValue = g_dbus_message_copy([self castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusMessage* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OFString*)arg0
{
	const gchar* gobjectValue = g_dbus_message_get_arg0([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)arg0Path
{
	const gchar* gobjectValue = g_dbus_message_get_arg0_path([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GVariant*)body
{
	GVariant* returnValue = (GVariant*)g_dbus_message_get_body([self castedGObject]);

	return returnValue;
}

- (GDBusMessageByteOrder)byteOrder
{
	GDBusMessageByteOrder returnValue = (GDBusMessageByteOrder)g_dbus_message_get_byte_order([self castedGObject]);

	return returnValue;
}

- (OFString*)destination
{
	const gchar* gobjectValue = g_dbus_message_get_destination([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)errorName
{
	const gchar* gobjectValue = g_dbus_message_get_error_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GDBusMessageFlags)flags
{
	GDBusMessageFlags returnValue = (GDBusMessageFlags)g_dbus_message_get_flags([self castedGObject]);

	return returnValue;
}

- (GVariant*)headerWithHeaderField:(GDBusMessageHeaderField)headerField
{
	GVariant* returnValue = (GVariant*)g_dbus_message_get_header([self castedGObject], headerField);

	return returnValue;
}

- (guchar*)headerFields
{
	guchar* returnValue = (guchar*)g_dbus_message_get_header_fields([self castedGObject]);

	return returnValue;
}

- (OFString*)interface
{
	const gchar* gobjectValue = g_dbus_message_get_interface([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)locked
{
	bool returnValue = (bool)g_dbus_message_get_locked([self castedGObject]);

	return returnValue;
}

- (OFString*)member
{
	const gchar* gobjectValue = g_dbus_message_get_member([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GDBusMessageType)messageType
{
	GDBusMessageType returnValue = (GDBusMessageType)g_dbus_message_get_message_type([self castedGObject]);

	return returnValue;
}

- (guint32)numUnixFds
{
	guint32 returnValue = (guint32)g_dbus_message_get_num_unix_fds([self castedGObject]);

	return returnValue;
}

- (OFString*)path
{
	const gchar* gobjectValue = g_dbus_message_get_path([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (guint32)replySerial
{
	guint32 returnValue = (guint32)g_dbus_message_get_reply_serial([self castedGObject]);

	return returnValue;
}

- (OFString*)sender
{
	const gchar* gobjectValue = g_dbus_message_get_sender([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (guint32)serial
{
	guint32 returnValue = (guint32)g_dbus_message_get_serial([self castedGObject]);

	return returnValue;
}

- (OFString*)signature
{
	const gchar* gobjectValue = g_dbus_message_get_signature([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OGUnixFDList*)unixFdList
{
	GUnixFDList* gobjectValue = g_dbus_message_get_unix_fd_list([self castedGObject]);

	OGUnixFDList* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (void)lock
{
	g_dbus_message_lock([self castedGObject]);
}

- (OGDBusMessage*)newMethodErrorLiteralWithErrorName:(OFString*)errorName errorMessage:(OFString*)errorMessage
{
	GDBusMessage* gobjectValue = g_dbus_message_new_method_error_literal([self castedGObject], [errorName UTF8String], [errorMessage UTF8String]);

	OGDBusMessage* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGDBusMessage*)newMethodErrorValistWithErrorName:(OFString*)errorName errorMessageFormat:(OFString*)errorMessageFormat varArgs:(va_list)varArgs
{
	GDBusMessage* gobjectValue = g_dbus_message_new_method_error_valist([self castedGObject], [errorName UTF8String], [errorMessageFormat UTF8String], varArgs);

	OGDBusMessage* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGDBusMessage*)newMethodReply
{
	GDBusMessage* gobjectValue = g_dbus_message_new_method_reply([self castedGObject]);

	OGDBusMessage* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OFString*)printWithIndent:(guint)indent
{
	gchar* gobjectValue = g_dbus_message_print([self castedGObject], indent);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (void)setBody:(GVariant*)body
{
	g_dbus_message_set_body([self castedGObject], body);
}

- (void)setByteOrder:(GDBusMessageByteOrder)byteOrder
{
	g_dbus_message_set_byte_order([self castedGObject], byteOrder);
}

- (void)setDestinationWithValue:(OFString*)value
{
	g_dbus_message_set_destination([self castedGObject], [value UTF8String]);
}

- (void)setErrorNameWithValue:(OFString*)value
{
	g_dbus_message_set_error_name([self castedGObject], [value UTF8String]);
}

- (void)setFlags:(GDBusMessageFlags)flags
{
	g_dbus_message_set_flags([self castedGObject], flags);
}

- (void)setHeaderWithHeaderField:(GDBusMessageHeaderField)headerField value:(GVariant*)value
{
	g_dbus_message_set_header([self castedGObject], headerField, value);
}

- (void)setInterfaceWithValue:(OFString*)value
{
	g_dbus_message_set_interface([self castedGObject], [value UTF8String]);
}

- (void)setMemberWithValue:(OFString*)value
{
	g_dbus_message_set_member([self castedGObject], [value UTF8String]);
}

- (void)setMessageType:(GDBusMessageType)type
{
	g_dbus_message_set_message_type([self castedGObject], type);
}

- (void)setNumUnixFdsWithValue:(guint32)value
{
	g_dbus_message_set_num_unix_fds([self castedGObject], value);
}

- (void)setPathWithValue:(OFString*)value
{
	g_dbus_message_set_path([self castedGObject], [value UTF8String]);
}

- (void)setReplySerialWithValue:(guint32)value
{
	g_dbus_message_set_reply_serial([self castedGObject], value);
}

- (void)setSenderWithValue:(OFString*)value
{
	g_dbus_message_set_sender([self castedGObject], [value UTF8String]);
}

- (void)setSerial:(guint32)serial
{
	g_dbus_message_set_serial([self castedGObject], serial);
}

- (void)setSignatureWithValue:(OFString*)value
{
	g_dbus_message_set_signature([self castedGObject], [value UTF8String]);
}

- (void)setUnixFdList:(OGUnixFDList*)fdList
{
	g_dbus_message_set_unix_fd_list([self castedGObject], [fdList castedGObject]);
}

- (guchar*)toBlobWithOutSize:(gsize*)outSize capabilities:(GDBusCapabilityFlags)capabilities
{
	GError* err = NULL;

	guchar* returnValue = (guchar*)g_dbus_message_to_blob([self castedGObject], outSize, capabilities, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)toGerror
{
	GError* err = NULL;

	bool returnValue = (bool)g_dbus_message_to_gerror([self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end