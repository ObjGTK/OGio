/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGEmblemedIcon.h"

#import "OGEmblem.h"

@implementation OGEmblemedIcon

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_EMBLEMED_ICON;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_EMBLEMED_ICON);
	return gObjectClass;
}

+ (instancetype)emblemedIconWithIcon:(GIcon*)icon emblem:(OGEmblem*)emblem
{
	GEmblemedIcon* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_emblemed_icon_new(icon, [emblem castedGObject]), G_TYPE_EMBLEMED_ICON, GEmblemedIcon);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGEmblemedIcon* wrapperObject;
	@try {
		wrapperObject = [[OGEmblemedIcon alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GEmblemedIcon*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_EMBLEMED_ICON, GEmblemedIcon);
}

- (void)addEmblem:(OGEmblem*)emblem
{
	g_emblemed_icon_add_emblem((GEmblemedIcon*)[self castedGObject], [emblem castedGObject]);
}

- (void)clearEmblems
{
	g_emblemed_icon_clear_emblems((GEmblemedIcon*)[self castedGObject]);
}

- (GList*)emblems
{
	GList* returnValue = (GList*)g_emblemed_icon_get_emblems((GEmblemedIcon*)[self castedGObject]);

	return returnValue;
}

- (GIcon*)icon
{
	GIcon* returnValue = (GIcon*)g_emblemed_icon_get_icon((GEmblemedIcon*)[self castedGObject]);

	return returnValue;
}


@end