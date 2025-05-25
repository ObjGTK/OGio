/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixFDList.h"

@implementation OGUnixFDList

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_UNIX_FD_LIST;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_UNIX_FD_LIST);
	return gObjectClass;
}

+ (instancetype)unixFDList
{
	GUnixFDList* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_fd_list_new(), G_TYPE_UNIX_FD_LIST, GUnixFDList);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGUnixFDList* wrapperObject;
	@try {
		wrapperObject = [[OGUnixFDList alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)unixFDListFromArrayWithFds:(const gint*)fds nfds:(gint)nfds
{
	GUnixFDList* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_fd_list_new_from_array(fds, nfds), G_TYPE_UNIX_FD_LIST, GUnixFDList);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGUnixFDList* wrapperObject;
	@try {
		wrapperObject = [[OGUnixFDList alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GUnixFDList*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_UNIX_FD_LIST, GUnixFDList);
}

- (gint)appendWithFd:(gint)fd
{
	GError* err = NULL;

	gint returnValue = (gint)g_unix_fd_list_append((GUnixFDList*)[self castedGObject], fd, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gint)getWithIndex:(gint)index
{
	GError* err = NULL;

	gint returnValue = (gint)g_unix_fd_list_get((GUnixFDList*)[self castedGObject], index, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gint)length
{
	gint returnValue = (gint)g_unix_fd_list_get_length((GUnixFDList*)[self castedGObject]);

	return returnValue;
}

- (const gint*)peekFdsWithLength:(gint*)length
{
	const gint* returnValue = (const gint*)g_unix_fd_list_peek_fds((GUnixFDList*)[self castedGObject], length);

	return returnValue;
}

- (gint*)stealFdsWithLength:(gint*)length
{
	gint* returnValue = (gint*)g_unix_fd_list_steal_fds((GUnixFDList*)[self castedGObject], length);

	return returnValue;
}


@end