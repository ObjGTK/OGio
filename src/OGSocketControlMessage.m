/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketControlMessage.h"

@implementation OGSocketControlMessage

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SOCKET_CONTROL_MESSAGE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (OGSocketControlMessage*)deserializeWithLevel:(int)level type:(int)type size:(gsize)size data:(gpointer)data
{
	GSocketControlMessage* gobjectValue = g_socket_control_message_deserialize(level, type, size, data);

	OGSocketControlMessage* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GSocketControlMessage*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSocketControlMessage, GSocketControlMessage);
}

- (int)level
{
	int returnValue = (int)g_socket_control_message_get_level([self castedGObject]);

	return returnValue;
}

- (int)msgType
{
	int returnValue = (int)g_socket_control_message_get_msg_type([self castedGObject]);

	return returnValue;
}

- (gsize)size
{
	gsize returnValue = (gsize)g_socket_control_message_get_size([self castedGObject]);

	return returnValue;
}

- (void)serializeWithData:(gpointer)data
{
	g_socket_control_message_serialize([self castedGObject], data);
}


@end