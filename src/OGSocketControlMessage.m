/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketControlMessage.h"

@implementation OGSocketControlMessage

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SOCKET_CONTROL_MESSAGE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SOCKET_CONTROL_MESSAGE);
	return gObjectClass;
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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SOCKET_CONTROL_MESSAGE, GSocketControlMessage);
}

- (int)level
{
	int returnValue = (int)g_socket_control_message_get_level((GSocketControlMessage*)[self castedGObject]);

	return returnValue;
}

- (int)msgType
{
	int returnValue = (int)g_socket_control_message_get_msg_type((GSocketControlMessage*)[self castedGObject]);

	return returnValue;
}

- (gsize)size
{
	gsize returnValue = (gsize)g_socket_control_message_get_size((GSocketControlMessage*)[self castedGObject]);

	return returnValue;
}

- (void)serializeWithData:(gpointer)data
{
	g_socket_control_message_serialize((GSocketControlMessage*)[self castedGObject], data);
}


@end