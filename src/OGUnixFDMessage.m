/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixFDMessage.h"

#import "OGUnixFDList.h"

@implementation OGUnixFDMessage

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_UNIX_FD_MESSAGE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_UNIX_FD_MESSAGE);
	return gObjectClass;
}

+ (instancetype)unixFDMessage
{
	GUnixFDMessage* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_fd_message_new(), G_TYPE_UNIX_FD_MESSAGE, GUnixFDMessage);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGUnixFDMessage* wrapperObject;
	@try {
		wrapperObject = [[OGUnixFDMessage alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)unixFDMessageWithFdList:(OGUnixFDList*)fdList
{
	GUnixFDMessage* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_fd_message_new_with_fd_list([fdList castedGObject]), G_TYPE_UNIX_FD_MESSAGE, GUnixFDMessage);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGUnixFDMessage* wrapperObject;
	@try {
		wrapperObject = [[OGUnixFDMessage alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GUnixFDMessage*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_UNIX_FD_MESSAGE, GUnixFDMessage);
}

- (bool)appendFd:(gint)fd
{
	GError* err = NULL;

	bool returnValue = (bool)g_unix_fd_message_append_fd([self castedGObject], fd, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OGUnixFDList*)fdList
{
	GUnixFDList* gobjectValue = g_unix_fd_message_get_fd_list([self castedGObject]);

	OGUnixFDList* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (gint*)stealFdsWithLength:(gint*)length
{
	gint* returnValue = (gint*)g_unix_fd_message_steal_fds([self castedGObject], length);

	return returnValue;
}


@end