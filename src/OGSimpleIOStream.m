/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleIOStream.h"

#import "OGInputStream.h"
#import "OGOutputStream.h"

@implementation OGSimpleIOStream

- (instancetype)initWithInputStream:(OGInputStream*)inputStream outputStream:(OGOutputStream*)outputStream
{
	GSimpleIOStream* gobjectValue = G_SIMPLE_IO_STREAM(g_simple_io_stream_new([inputStream castedGObject], [outputStream castedGObject]));

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
	return G_SIMPLE_IO_STREAM([self gObject]);
}


@end