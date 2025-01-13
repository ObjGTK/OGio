/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGEmblem.h"

@implementation OGEmblem

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_EMBLEM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (instancetype)emblemWithIcon:(GIcon*)icon
{
	GEmblem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_emblem_new(icon), GEmblem, GEmblem);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGEmblem* wrapperObject;
	@try {
		wrapperObject = [[OGEmblem alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)emblemWithOriginWithIcon:(GIcon*)icon origin:(GEmblemOrigin)origin
{
	GEmblem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_emblem_new_with_origin(icon, origin), GEmblem, GEmblem);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGEmblem* wrapperObject;
	@try {
		wrapperObject = [[OGEmblem alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GEmblem*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GEmblem, GEmblem);
}

- (GIcon*)icon
{
	GIcon* returnValue = (GIcon*)g_emblem_get_icon([self castedGObject]);

	return returnValue;
}

- (GEmblemOrigin)origin
{
	GEmblemOrigin returnValue = (GEmblemOrigin)g_emblem_get_origin([self castedGObject]);

	return returnValue;
}


@end