/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixInputStream.h"

@implementation OGUnixInputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_UNIX_INPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_UNIX_INPUT_STREAM);
	return gObjectClass;
}

+ (instancetype)unixInputStreamWithFd:(gint)fd closeFd:(bool)closeFd
{
	GUnixInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_input_stream_new(fd, closeFd), G_TYPE_UNIX_INPUT_STREAM, GUnixInputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGUnixInputStream* wrapperObject;
	@try {
		wrapperObject = [[OGUnixInputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GUnixInputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_UNIX_INPUT_STREAM, GUnixInputStream);
}

- (bool)closeFd
{
	bool returnValue = (bool)g_unix_input_stream_get_close_fd((GUnixInputStream*)[self castedGObject]);

	return returnValue;
}

- (gint)fd
{
	gint returnValue = (gint)g_unix_input_stream_get_fd((GUnixInputStream*)[self castedGObject]);

	return returnValue;
}

- (void)setCloseFd:(bool)closeFd
{
	g_unix_input_stream_set_close_fd((GUnixInputStream*)[self castedGObject], closeFd);
}


@end