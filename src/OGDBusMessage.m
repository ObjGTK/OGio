/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusMessage.h"

#import "OGUnixFDList.h"

@implementation OGDBusMessage

+ (gssize)bytesNeededWithBlob:(guchar*)blob blobLen:(gsize)blobLen
{
	GError* err = NULL;

	gssize returnValue = g_dbus_message_bytes_needed(blob, blobLen, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (instancetype)init
{
	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_message_new());

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

- (instancetype)initFromBlobWithBlob:(guchar*)blob blobLen:(gsize)blobLen capabilities:(GDBusCapabilityFlags)capabilities
{
	GError* err = NULL;

	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_message_new_from_blob(blob, blobLen, capabilities, &err));

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

- (instancetype)initMethodCallWithName:(OFString*)name path:(OFString*)path interface:(OFString*)interface method:(OFString*)method
{
	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_message_new_method_call([name UTF8String], [path UTF8String], [interface UTF8String], [method UTF8String]));

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

- (instancetype)initSignalWithPath:(OFString*)path interface:(OFString*)interface signal:(OFString*)signal
{
	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_message_new_signal([path UTF8String], [interface UTF8String], [signal UTF8String]));

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

- (GDBusMessage*)castedGObject
{
	return G_DBUS_MESSAGE([self gObject]);
}

- (OGDBusMessage*)copy
{
	GError* err = NULL;

	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_message_copy([self castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGDBusMessage* returnValue = [OGDBusMessage withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OFString*)arg0
{
	const gchar* gobjectValue = g_dbus_message_get_arg0([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GVariant*)body
{
	GVariant* returnValue = g_dbus_message_get_body([self castedGObject]);

	return returnValue;
}

- (GDBusMessageByteOrder)byteOrder
{
	GDBusMessageByteOrder returnValue = g_dbus_message_get_byte_order([self castedGObject]);

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
	GDBusMessageFlags returnValue = g_dbus_message_get_flags([self castedGObject]);

	return returnValue;
}

- (GVariant*)header:(GDBusMessageHeaderField)headerField
{
	GVariant* returnValue = g_dbus_message_get_header([self castedGObject], headerField);

	return returnValue;
}

- (guchar*)headerFields
{
	guchar* returnValue = g_dbus_message_get_header_fields([self castedGObject]);

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
	bool returnValue = g_dbus_message_get_locked([self castedGObject]);

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
	GDBusMessageType returnValue = g_dbus_message_get_message_type([self castedGObject]);

	return returnValue;
}

- (guint32)numUnixFds
{
	guint32 returnValue = g_dbus_message_get_num_unix_fds([self castedGObject]);

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
	guint32 returnValue = g_dbus_message_get_reply_serial([self castedGObject]);

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
	guint32 returnValue = g_dbus_message_get_serial([self castedGObject]);

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
	GUnixFDList* gobjectValue = G_UNIX_FD_LIST(g_dbus_message_get_unix_fd_list([self castedGObject]));

	OGUnixFDList* returnValue = [OGUnixFDList withGObject:gobjectValue];
	return returnValue;
}

- (void)lock
{
	g_dbus_message_lock([self castedGObject]);
}

- (OGDBusMessage*)newMethodErrorLiteralWithErrorName:(OFString*)errorName errorMessage:(OFString*)errorMessage
{
	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_message_new_method_error_literal([self castedGObject], [errorName UTF8String], [errorMessage UTF8String]));

	OGDBusMessage* returnValue = [OGDBusMessage withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGDBusMessage*)newMethodErrorValistWithErrorName:(OFString*)errorName errorMessageFormat:(OFString*)errorMessageFormat varArgs:(va_list)varArgs
{
	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_message_new_method_error_valist([self castedGObject], [errorName UTF8String], [errorMessageFormat UTF8String], varArgs));

	OGDBusMessage* returnValue = [OGDBusMessage withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGDBusMessage*)newMethodReply
{
	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_message_new_method_reply([self castedGObject]));

	OGDBusMessage* returnValue = [OGDBusMessage withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OFString*)print:(guint)indent
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

- (void)setDestination:(OFString*)value
{
	g_dbus_message_set_destination([self castedGObject], [value UTF8String]);
}

- (void)setErrorName:(OFString*)value
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

- (void)setInterface:(OFString*)value
{
	g_dbus_message_set_interface([self castedGObject], [value UTF8String]);
}

- (void)setMember:(OFString*)value
{
	g_dbus_message_set_member([self castedGObject], [value UTF8String]);
}

- (void)setMessageType:(GDBusMessageType)type
{
	g_dbus_message_set_message_type([self castedGObject], type);
}

- (void)setNumUnixFds:(guint32)value
{
	g_dbus_message_set_num_unix_fds([self castedGObject], value);
}

- (void)setPath:(OFString*)value
{
	g_dbus_message_set_path([self castedGObject], [value UTF8String]);
}

- (void)setReplySerial:(guint32)value
{
	g_dbus_message_set_reply_serial([self castedGObject], value);
}

- (void)setSender:(OFString*)value
{
	g_dbus_message_set_sender([self castedGObject], [value UTF8String]);
}

- (void)setSerial:(guint32)serial
{
	g_dbus_message_set_serial([self castedGObject], serial);
}

- (void)setSignature:(OFString*)value
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

	guchar* returnValue = g_dbus_message_to_blob([self castedGObject], outSize, capabilities, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)toGerror
{
	GError* err = NULL;

	bool returnValue = g_dbus_message_to_gerror([self castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}


@end