/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleIOStream.h"

#import "OGInputStream.h"
#import "OGOutputStream.h"

@implementation OGSimpleIOStream

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SIMPLE_IO_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithInputStream:(OGInputStream*)inputStream outputStream:(OGOutputStream*)outputStream
{
	GSimpleIOStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_io_stream_new([inputStream castedGObject], [outputStream castedGObject]), GSimpleIOStream, GSimpleIOStream);

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

- (GSimpleIOStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSimpleIOStream, GSimpleIOStream);
}


@end