/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGEmblem.h"

@implementation OGEmblem

- (instancetype)init:(GIcon*)icon
{
	GEmblem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_emblem_new(icon), GEmblem, GEmblem);

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

- (instancetype)initWithOriginWithIcon:(GIcon*)icon origin:(GEmblemOrigin)origin
{
	GEmblem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_emblem_new_with_origin(icon, origin), GEmblem, GEmblem);

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

- (GEmblem*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GEmblem, GEmblem);
}

- (GIcon*)icon
{
	GIcon* returnValue = g_emblem_get_icon([self castedGObject]);

	return returnValue;
}

- (GEmblemOrigin)origin
{
	GEmblemOrigin returnValue = g_emblem_get_origin([self castedGObject]);

	return returnValue;
}


@end