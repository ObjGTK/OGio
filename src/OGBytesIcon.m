/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGBytesIcon.h"

@implementation OGBytesIcon

- (instancetype)init:(GBytes*)bytes
{
	GBytesIcon* gobjectValue = G_BYTES_ICON(g_bytes_icon_new(bytes));

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

- (GBytesIcon*)castedGObject
{
	return G_BYTES_ICON([self gObject]);
}

- (GBytes*)bytes
{
	GBytes* returnValue = g_bytes_icon_get_bytes([self castedGObject]);

	return returnValue;
}


@end