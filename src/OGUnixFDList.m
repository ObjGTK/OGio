/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixFDList.h"

@implementation OGUnixFDList

- (instancetype)init
{
	GUnixFDList* gobjectValue = G_UNIX_FD_LIST(g_unix_fd_list_new());

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

- (instancetype)initFromArrayWithFds:(const gint*)fds nfds:(gint)nfds
{
	GUnixFDList* gobjectValue = G_UNIX_FD_LIST(g_unix_fd_list_new_from_array(fds, nfds));

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

- (GUnixFDList*)castedGObject
{
	return G_UNIX_FD_LIST([self gObject]);
}

- (gint)append:(gint)fd
{
	GError* err = NULL;

	gint returnValue = g_unix_fd_list_append([self castedGObject], fd, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (gint)get:(gint)index
{
	GError* err = NULL;

	gint returnValue = g_unix_fd_list_get([self castedGObject], index, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (gint)length
{
	gint returnValue = g_unix_fd_list_get_length([self castedGObject]);

	return returnValue;
}

- (const gint*)peekFds:(gint*)length
{
	const gint* returnValue = g_unix_fd_list_peek_fds([self castedGObject], length);

	return returnValue;
}

- (gint*)stealFds:(gint*)length
{
	gint* returnValue = g_unix_fd_list_steal_fds([self castedGObject], length);

	return returnValue;
}


@end