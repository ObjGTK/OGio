/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixOutputStream.h"

@implementation OGUnixOutputStream

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_UNIX_OUTPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithFd:(gint)fd closeFd:(bool)closeFd
{
	GUnixOutputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_output_stream_new(fd, closeFd), GUnixOutputStream, GUnixOutputStream);

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

- (GUnixOutputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GUnixOutputStream, GUnixOutputStream);
}

- (bool)closeFd
{
	bool returnValue = (bool)g_unix_output_stream_get_close_fd([self castedGObject]);

	return returnValue;
}

- (gint)fd
{
	gint returnValue = (gint)g_unix_output_stream_get_fd([self castedGObject]);

	return returnValue;
}

- (void)setCloseFd:(bool)closeFd
{
	g_unix_output_stream_set_close_fd([self castedGObject], closeFd);
}


@end