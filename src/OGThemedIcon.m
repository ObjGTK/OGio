/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGThemedIcon.h"

@implementation OGThemedIcon

- (instancetype)init:(OFString*)iconname
{
	GThemedIcon* gobjectValue = G_THEMED_ICON(g_themed_icon_new([iconname UTF8String]));

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

- (instancetype)initFromNamesWithIconnames:(char**)iconnames len:(int)len
{
	GThemedIcon* gobjectValue = G_THEMED_ICON(g_themed_icon_new_from_names(iconnames, len));

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

- (instancetype)initWithDefaultFallbacks:(OFString*)iconname
{
	GThemedIcon* gobjectValue = G_THEMED_ICON(g_themed_icon_new_with_default_fallbacks([iconname UTF8String]));

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

- (GThemedIcon*)castedGObject
{
	return G_THEMED_ICON([self gObject]);
}

- (void)appendName:(OFString*)iconname
{
	g_themed_icon_append_name([self castedGObject], [iconname UTF8String]);
}

- (const gchar* const*)names
{
	const gchar* const* returnValue = g_themed_icon_get_names([self castedGObject]);

	return returnValue;
}

- (void)prependName:(OFString*)iconname
{
	g_themed_icon_prepend_name([self castedGObject], [iconname UTF8String]);
}


@end