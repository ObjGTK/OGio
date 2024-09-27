/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGConverterOutputStream.h"

#import "OGOutputStream.h"

@implementation OGConverterOutputStream

- (instancetype)initWithBaseStream:(OGOutputStream*)baseStream converter:(GConverter*)converter
{
	GConverterOutputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_converter_output_stream_new([baseStream castedGObject], converter), GConverterOutputStream, GConverterOutputStream);

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

- (GConverterOutputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GConverterOutputStream, GConverterOutputStream);
}

- (GConverter*)converter
{
	GConverter* returnValue = g_converter_output_stream_get_converter([self castedGObject]);

	return returnValue;
}


@end