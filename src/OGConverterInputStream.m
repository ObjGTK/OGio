/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGConverterInputStream.h"

#import "OGInputStream.h"

@implementation OGConverterInputStream

- (instancetype)initWithBaseStream:(OGInputStream*)baseStream converter:(GConverter*)converter
{
	GConverterInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_converter_input_stream_new([baseStream castedGObject], converter), GConverterInputStream, GConverterInputStream);

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

- (GConverterInputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GConverterInputStream, GConverterInputStream);
}

- (GConverter*)converter
{
	GConverter* returnValue = g_converter_input_stream_get_converter([self castedGObject]);

	return returnValue;
}


@end