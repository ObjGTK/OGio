/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixoutputstream.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

@class OGUnixFDList;

/**
 * A type for representing D-Bus messages that can be sent or received
 * on a #GDBusConnection.
 *
 */
@interface OGDBusMessage : OGObject
{

}

/**
 * Functions
 */

/**
 * Utility function to calculate how many bytes are needed to
 * completely deserialize the D-Bus message stored at @blob.
 *
 * @param blob A blob representing a binary D-Bus message.
 * @param blobLen The length of @blob (must be at least 16).
 * @return Number of bytes needed or -1 if @error is set (e.g. if
 * @blob contains invalid data or not enough data is available to
 * determine the size).
 */
+ (gssize)bytesNeededWithBlob:(guchar*)blob blobLen:(gsize)blobLen;

/**
 * Constructors
 */
- (instancetype)init;
- (instancetype)initFromBlobWithBlob:(guchar*)blob blobLen:(gsize)blobLen capabilities:(GDBusCapabilityFlags)capabilities;
- (instancetype)initMethodCallWithName:(OFString*)name path:(OFString*)path interface:(OFString*)interface method:(OFString*)method;
- (instancetype)initSignalWithPath:(OFString*)path interface:(OFString*)interface signal:(OFString*)signal;

/**
 * Methods
 */

- (GDBusMessage*)castedGObject;

/**
 * Copies @message. The copy is a deep copy and the returned
 * #GDBusMessage is completely identical except that it is guaranteed
 * to not be locked.
 * 
 * This operation can fail if e.g. @message contains file descriptors
 * and the per-process or system-wide open files limit is reached.
 *
 * @return A new #GDBusMessage or %NULL if @error is set.
 *     Free with g_object_unref().
 */
- (OGDBusMessage*)copy;

/**
 * Convenience to get the first item in the body of @message.
 *
 * @return The string item or %NULL if the first item in the body of
 * @message is not a string.
 */
- (OFString*)arg0;

/**
 * Gets the body of a message.
 *
 * @return A #GVariant or %NULL if the body is
 * empty. Do not free, it is owned by @message.
 */
- (GVariant*)body;

/**
 * Gets the byte order of @message.
 *
 * @return The byte order.
 */
- (GDBusMessageByteOrder)byteOrder;

/**
 * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_DESTINATION header field.
 *
 * @return The value.
 */
- (OFString*)destination;

/**
 * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_ERROR_NAME header field.
 *
 * @return The value.
 */
- (OFString*)errorName;

/**
 * Gets the flags for @message.
 *
 * @return Flags that are set (typically values from the #GDBusMessageFlags enumeration bitwise ORed together).
 */
- (GDBusMessageFlags)flags;

/**
 * Gets a header field on @message.
 * 
 * The caller is responsible for checking the type of the returned #GVariant
 * matches what is expected.
 *
 * @param headerField A 8-bit unsigned integer (typically a value from the #GDBusMessageHeaderField enumeration)
 * @return A #GVariant with the value if the header was found, %NULL
 * otherwise. Do not free, it is owned by @message.
 */
- (GVariant*)header:(GDBusMessageHeaderField)headerField;

/**
 * Gets an array of all header fields on @message that are set.
 *
 * @return An array of header fields
 * terminated by %G_DBUS_MESSAGE_HEADER_FIELD_INVALID.  Each element
 * is a #guchar. Free with g_free().
 */
- (guchar*)headerFields;

/**
 * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_INTERFACE header field.
 *
 * @return The value.
 */
- (OFString*)interface;

/**
 * Checks whether @message is locked. To monitor changes to this
 * value, conncet to the #GObject::notify signal to listen for changes
 * on the #GDBusMessage:locked property.
 *
 * @return %TRUE if @message is locked, %FALSE otherwise.
 */
- (bool)locked;

/**
 * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_MEMBER header field.
 *
 * @return The value.
 */
- (OFString*)member;

/**
 * Gets the type of @message.
 *
 * @return A 8-bit unsigned integer (typically a value from the #GDBusMessageType enumeration).
 */
- (GDBusMessageType)messageType;

/**
 * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FDS header field.
 *
 * @return The value.
 */
- (guint32)numUnixFds;

/**
 * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_PATH header field.
 *
 * @return The value.
 */
- (OFString*)path;

/**
 * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_REPLY_SERIAL header field.
 *
 * @return The value.
 */
- (guint32)replySerial;

/**
 * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_SENDER header field.
 *
 * @return The value.
 */
- (OFString*)sender;

/**
 * Gets the serial for @message.
 *
 * @return A #guint32.
 */
- (guint32)serial;

/**
 * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE header field.
 * 
 * This will always be non-%NULL, but may be an empty string.
 *
 * @return The value.
 */
- (OFString*)signature;

/**
 * Gets the UNIX file descriptors associated with @message, if any.
 * 
 * This method is only available on UNIX.
 * 
 * The file descriptors normally correspond to %G_VARIANT_TYPE_HANDLE
 * values in the body of the message. For example,
 * if g_variant_get_handle() returns 5, that is intended to be a reference
 * to the file descriptor that can be accessed by
 * `g_unix_fd_list_get (list, 5, ...)`.
 *
 * @return A #GUnixFDList or %NULL if no file descriptors are
 * associated. Do not free, this object is owned by @message.
 */
- (OGUnixFDList*)unixFdList;

/**
 * If @message is locked, does nothing. Otherwise locks the message.
 *
 */
- (void)lock;

/**
 * Creates a new #GDBusMessage that is an error reply to @method_call_message.
 *
 * @param errorName A valid D-Bus error name.
 * @param errorMessage The D-Bus error message.
 * @return A #GDBusMessage. Free with g_object_unref().
 */
- (OGDBusMessage*)newMethodErrorLiteralWithErrorName:(OFString*)errorName errorMessage:(OFString*)errorMessage;

/**
 * Like g_dbus_message_new_method_error() but intended for language bindings.
 *
 * @param errorName A valid D-Bus error name.
 * @param errorMessageFormat The D-Bus error message in a printf() format.
 * @param varArgs Arguments for @error_message_format.
 * @return A #GDBusMessage. Free with g_object_unref().
 */
- (OGDBusMessage*)newMethodErrorValistWithErrorName:(OFString*)errorName errorMessageFormat:(OFString*)errorMessageFormat varArgs:(va_list)varArgs;

/**
 * Creates a new #GDBusMessage that is a reply to @method_call_message.
 *
 * @return #GDBusMessage. Free with g_object_unref().
 */
- (OGDBusMessage*)newMethodReply;

/**
 * Produces a human-readable multi-line description of @message.
 * 
 * The contents of the description has no ABI guarantees, the contents
 * and formatting is subject to change at any time. Typical output
 * looks something like this:
 * |[
 * Flags:   none
 * Version: 0
 * Serial:  4
 * Headers:
 *   path -> objectpath '/org/gtk/GDBus/TestObject'
 *   interface -> 'org.gtk.GDBus.TestInterface'
 *   member -> 'GimmeStdout'
 *   destination -> ':1.146'
 * Body: ()
 * UNIX File Descriptors:
 *   (none)
 * ]|
 * or
 * |[
 * Flags:   no-reply-expected
 * Version: 0
 * Serial:  477
 * Headers:
 *   reply-serial -> uint32 4
 *   destination -> ':1.159'
 *   sender -> ':1.146'
 *   num-unix-fds -> uint32 1
 * Body: ()
 * UNIX File Descriptors:
 *   fd 12: dev=0:10,mode=020620,ino=5,uid=500,gid=5,rdev=136:2,size=0,atime=1273085037,mtime=1273085851,ctime=1272982635
 * ]|
 *
 * @param indent Indentation level.
 * @return A string that should be freed with g_free().
 */
- (OFString*)print:(guint)indent;

/**
 * Sets the body @message. As a side-effect the
 * %G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE header field is set to the
 * type string of @body (or cleared if @body is %NULL).
 * 
 * If @body is floating, @message assumes ownership of @body.
 *
 * @param body Either %NULL or a #GVariant that is a tuple.
 */
- (void)setBody:(GVariant*)body;

/**
 * Sets the byte order of @message.
 *
 * @param byteOrder The byte order.
 */
- (void)setByteOrder:(GDBusMessageByteOrder)byteOrder;

/**
 * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_DESTINATION header field.
 *
 * @param value The value to set.
 */
- (void)setDestination:(OFString*)value;

/**
 * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_ERROR_NAME header field.
 *
 * @param value The value to set.
 */
- (void)setErrorName:(OFString*)value;

/**
 * Sets the flags to set on @message.
 *
 * @param flags Flags for @message that are set (typically values from the #GDBusMessageFlags
 * enumeration bitwise ORed together).
 */
- (void)setFlags:(GDBusMessageFlags)flags;

/**
 * Sets a header field on @message.
 * 
 * If @value is floating, @message assumes ownership of @value.
 *
 * @param headerField A 8-bit unsigned integer (typically a value from the #GDBusMessageHeaderField enumeration)
 * @param value A #GVariant to set the header field or %NULL to clear the header field.
 */
- (void)setHeaderWithHeaderField:(GDBusMessageHeaderField)headerField value:(GVariant*)value;

/**
 * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_INTERFACE header field.
 *
 * @param value The value to set.
 */
- (void)setInterface:(OFString*)value;

/**
 * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_MEMBER header field.
 *
 * @param value The value to set.
 */
- (void)setMember:(OFString*)value;

/**
 * Sets @message to be of @type.
 *
 * @param type A 8-bit unsigned integer (typically a value from the #GDBusMessageType enumeration).
 */
- (void)setMessageType:(GDBusMessageType)type;

/**
 * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FDS header field.
 *
 * @param value The value to set.
 */
- (void)setNumUnixFds:(guint32)value;

/**
 * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_PATH header field.
 *
 * @param value The value to set.
 */
- (void)setPath:(OFString*)value;

/**
 * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_REPLY_SERIAL header field.
 *
 * @param value The value to set.
 */
- (void)setReplySerial:(guint32)value;

/**
 * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_SENDER header field.
 *
 * @param value The value to set.
 */
- (void)setSender:(OFString*)value;

/**
 * Sets the serial for @message.
 *
 * @param serial A #guint32.
 */
- (void)setSerial:(guint32)serial;

/**
 * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE header field.
 *
 * @param value The value to set.
 */
- (void)setSignature:(OFString*)value;

/**
 * Sets the UNIX file descriptors associated with @message. As a
 * side-effect the %G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FDS header
 * field is set to the number of fds in @fd_list (or cleared if
 * @fd_list is %NULL).
 * 
 * This method is only available on UNIX.
 * 
 * When designing D-Bus APIs that are intended to be interoperable,
 * please note that non-GDBus implementations of D-Bus can usually only
 * access file descriptors if they are referenced by a value of type
 * %G_VARIANT_TYPE_HANDLE in the body of the message.
 *
 * @param fdList A #GUnixFDList or %NULL.
 */
- (void)setUnixFdList:(OGUnixFDList*)fdList;

/**
 * Serializes @message to a blob. The byte order returned by
 * g_dbus_message_get_byte_order() will be used.
 *
 * @param outSize Return location for size of generated blob.
 * @param capabilities A #GDBusCapabilityFlags describing what protocol features are supported.
 * @return A pointer to a
 * valid binary D-Bus message of @out_size bytes generated by @message
 * or %NULL if @error is set. Free with g_free().
 */
- (guchar*)toBlobWithOutSize:(gsize*)outSize capabilities:(GDBusCapabilityFlags)capabilities;

/**
 * If @message is not of type %G_DBUS_MESSAGE_TYPE_ERROR does
 * nothing and returns %FALSE.
 * 
 * Otherwise this method encodes the error in @message as a #GError
 * using g_dbus_error_set_dbus_error() using the information in the
 * %G_DBUS_MESSAGE_HEADER_FIELD_ERROR_NAME header field of @message as
 * well as the first string item in @message's body.
 *
 * @return %TRUE if @error was set, %FALSE otherwise.
 */
- (bool)toGerror;

@end