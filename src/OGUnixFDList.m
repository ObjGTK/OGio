/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixFDList.h"

@implementation OGUnixFDList

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_UNIX_FD_LIST;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)init
{
	GUnixFDList* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_fd_list_new(), GUnixFDList, GUnixFDList);

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
	GUnixFDList* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_fd_list_new_from_array(fds, nfds), GUnixFDList, GUnixFDList);

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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GUnixFDList, GUnixFDList);
}

- (gint)append:(gint)fd
{
	GError* err = NULL;

	gint returnValue = (gint)g_unix_fd_list_append([self castedGObject], fd, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gint)get:(gint)index
{
	GError* err = NULL;

	gint returnValue = (gint)g_unix_fd_list_get([self castedGObject], index, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gint)length
{
	gint returnValue = (gint)g_unix_fd_list_get_length([self castedGObject]);

	return returnValue;
}

- (const gint*)peekFds:(gint*)length
{
	const gint* returnValue = (const gint*)g_unix_fd_list_peek_fds([self castedGObject], length);

	return returnValue;
}

- (gint*)stealFds:(gint*)length
{
	gint* returnValue = (gint*)g_unix_fd_list_steal_fds([self castedGObject], length);

	return returnValue;
}


@end