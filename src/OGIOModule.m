/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGIOModule.h"

@implementation OGIOModule

+ (char**)query
{
	char** returnValue = g_io_module_query();

	return returnValue;
}

- (instancetype)init:(OFString*)filename
{
	GIOModule* gobjectValue = G_IO_MODULE(g_io_module_new([filename UTF8String]));

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

- (GIOModule*)castedGObject
{
	return G_IO_MODULE([self gObject]);
}

- (void)load
{
	g_io_module_load([self castedGObject]);
}

- (void)unload
{
	g_io_module_unload([self castedGObject]);
}


@end