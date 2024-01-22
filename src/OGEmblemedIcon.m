/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGEmblemedIcon.h"

#import "OGEmblem.h"

@implementation OGEmblemedIcon

- (instancetype)initWithIcon:(GIcon*)icon emblem:(OGEmblem*)emblem
{
	GEmblemedIcon* gobjectValue = G_EMBLEMED_ICON(g_emblemed_icon_new(icon, [emblem castedGObject]));

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

- (GEmblemedIcon*)castedGObject
{
	return G_EMBLEMED_ICON([self gObject]);
}

- (void)addEmblem:(OGEmblem*)emblem
{
	g_emblemed_icon_add_emblem([self castedGObject], [emblem castedGObject]);
}

- (void)clearEmblems
{
	g_emblemed_icon_clear_emblems([self castedGObject]);
}

- (GList*)emblems
{
	GList* returnValue = g_emblemed_icon_get_emblems([self castedGObject]);

	return returnValue;
}

- (GIcon*)icon
{
	GIcon* returnValue = g_emblemed_icon_get_icon([self castedGObject]);

	return returnValue;
}


@end