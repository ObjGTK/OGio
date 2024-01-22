/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFileIcon.h"

@implementation OGFileIcon

- (instancetype)init:(GFile*)file
{
	GFileIcon* gobjectValue = G_FILE_ICON(g_file_icon_new(file));

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

- (GFileIcon*)castedGObject
{
	return G_FILE_ICON([self gObject]);
}

- (GFile*)file
{
	GFile* returnValue = g_file_icon_get_file([self castedGObject]);

	return returnValue;
}


@end