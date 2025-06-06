/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

/**
 * A `GSocketControlMessage` is a special-purpose utility message that
 * can be sent to or received from a [class@Gio.Socket]. These types of
 * messages are often called ‘ancillary data’.
 * 
 * The message can represent some sort of special instruction to or
 * information from the socket or can represent a special kind of
 * transfer to the peer (for example, sending a file descriptor over
 * a UNIX socket).
 * 
 * These messages are sent with [method@Gio.Socket.send_message] and received
 * with [method@Gio.Socket.receive_message].
 * 
 * To extend the set of control message that can be sent, subclass this
 * class and override the `get_size`, `get_level`, `get_type` and `serialize`
 * methods.
 * 
 * To extend the set of control messages that can be received, subclass
 * this class and implement the `deserialize` method. Also, make sure your
 * class is registered with the [type@GObject.Type] type system before calling
 * [method@Gio.Socket.receive_message] to read such a message.
 *
 */
@interface OGSocketControlMessage : OGObject
{

}

/**
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Tries to deserialize a socket control message of a given
 * @level and @type. This will ask all known (to GType) subclasses
 * of #GSocketControlMessage if they can understand this kind
 * of message and if so deserialize it into a #GSocketControlMessage.
 * 
 * If there is no implementation for this kind of control message, %NULL
 * will be returned.
 *
 * @param level a socket level
 * @param type a socket control message type for the given @level
 * @param size the size of the data in bytes
 * @param data pointer to the message data
 * @return the deserialized message or %NULL
 */
+ (OGSocketControlMessage*)deserializeWithLevel:(int)level type:(int)type size:(gsize)size data:(gpointer)data;

/**
 * Methods
 */

- (GSocketControlMessage*)castedGObject;

/**
 * Returns the "level" (i.e. the originating protocol) of the control message.
 * This is often SOL_SOCKET.
 *
 * @return an integer describing the level
 */
- (int)level;

/**
 * Returns the protocol specific type of the control message.
 * For instance, for UNIX fd passing this would be SCM_RIGHTS.
 *
 * @return an integer describing the type of control message
 */
- (int)msgType;

/**
 * Returns the space required for the control message, not including
 * headers or alignment.
 *
 * @return The number of bytes required.
 */
- (gsize)size;

/**
 * Converts the data in the message to bytes placed in the
 * message.
 * 
 * @data is guaranteed to have enough space to fit the size
 * returned by g_socket_control_message_get_size() on this
 * object.
 *
 * @param data A buffer to write data to
 */
- (void)serializeWithData:(gpointer)data;

@end