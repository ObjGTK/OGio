/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixFDMessage.h"

#import "OGUnixFDList.h"

@implementation OGUnixFDMessage

- (instancetype)init
{
	GUnixFDMessage* gobjectValue = G_UNIX_FD_MESSAGE(g_unix_fd_message_new());

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
	GUnixFDMessage* gobjectValue = G_UNIX_FD_MESSAGE(g_unix_fd_message_new_with_fd_list([fdList castedGObject]));

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
	return G_UNIX_FD_MESSAGE([self gObject]);
}

- (bool)appendFd:(gint)fd
{
	GError* err = NULL;

	bool returnValue = g_unix_fd_message_append_fd([self castedGObject], fd, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (OGUnixFDList*)fdList
{
	GUnixFDList* gobjectValue = G_UNIX_FD_LIST(g_unix_fd_message_get_fd_list([self castedGObject]));

	OGUnixFDList* returnValue = [OGUnixFDList withGObject:gobjectValue];
	return returnValue;
}

- (gint*)stealFds:(gint*)length
{
	gint* returnValue = g_unix_fd_message_steal_fds([self castedGObject], length);

	return returnValue;
}


@end