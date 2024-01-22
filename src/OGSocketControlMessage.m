/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketControlMessage.h"

@implementation OGSocketControlMessage

+ (OGSocketControlMessage*)deserializeWithLevel:(int)level type:(int)type size:(gsize)size data:(gpointer)data
{
	GSocketControlMessage* gobjectValue = G_SOCKET_CONTROL_MESSAGE(g_socket_control_message_deserialize(level, type, size, data));

	OGSocketControlMessage* returnValue = [OGSocketControlMessage wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GSocketControlMessage*)castedGObject
{
	return G_SOCKET_CONTROL_MESSAGE([self gObject]);
}

- (int)level
{
	int returnValue = g_socket_control_message_get_level([self castedGObject]);

	return returnValue;
}

- (int)msgType
{
	int returnValue = g_socket_control_message_get_msg_type([self castedGObject]);

	return returnValue;
}

- (gsize)size
{
	gsize returnValue = g_socket_control_message_get_size([self castedGObject]);

	return returnValue;
}

- (void)serialize:(gpointer)data
{
	g_socket_control_message_serialize([self castedGObject], data);
}


@end