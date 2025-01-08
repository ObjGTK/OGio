/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixFDMessage.h"

#import "OGUnixFDList.h"

@implementation OGUnixFDMessage

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_UNIX_FD_MESSAGE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)init
{
	GUnixFDMessage* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_fd_message_new(), GUnixFDMessage, GUnixFDMessage);

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

- (instancetype)initWithFdList:(OGUnixFDList*)fdList
{
	GUnixFDMessage* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_fd_message_new_with_fd_list([fdList castedGObject]), GUnixFDMessage, GUnixFDMessage);

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

- (GUnixFDMessage*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GUnixFDMessage, GUnixFDMessage);
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

- (gint*)stealFds:(gint*)length
{
	gint* returnValue = (gint*)g_unix_fd_message_steal_fds([self castedGObject], length);

	return returnValue;
}


@end