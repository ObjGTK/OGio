/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenuModel.h"

#import "OGMenuLinkIter.h"
#import "OGMenuAttributeIter.h"

@implementation OGMenuModel

- (GMenuModel*)castedGObject
{
	return G_MENU_MODEL([self gObject]);
}

- (GVariant*)itemAttributeValueWithItemIndex:(gint)itemIndex attribute:(OFString*)attribute expectedType:(const GVariantType*)expectedType
{
	GVariant* returnValue = g_menu_model_get_item_attribute_value([self castedGObject], itemIndex, [attribute UTF8String], expectedType);

	return returnValue;
}

- (OGMenuModel*)itemLinkWithItemIndex:(gint)itemIndex link:(OFString*)link
{
	GMenuModel* gobjectValue = G_MENU_MODEL(g_menu_model_get_item_link([self castedGObject], itemIndex, [link UTF8String]));

	OGMenuModel* returnValue = [OGMenuModel wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (gint)nitems
{
	gint returnValue = g_menu_model_get_n_items([self castedGObject]);

	return returnValue;
}

- (bool)isMutable
{
	bool returnValue = g_menu_model_is_mutable([self castedGObject]);

	return returnValue;
}

- (void)itemsChangedWithPosition:(gint)position removed:(gint)removed added:(gint)added
{
	g_menu_model_items_changed([self castedGObject], position, removed, added);
}

- (OGMenuAttributeIter*)iterateItemAttributes:(gint)itemIndex
{
	GMenuAttributeIter* gobjectValue = G_MENU_ATTRIBUTE_ITER(g_menu_model_iterate_item_attributes([self castedGObject], itemIndex));

	OGMenuAttributeIter* returnValue = [OGMenuAttributeIter wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGMenuLinkIter*)iterateItemLinks:(gint)itemIndex
{
	GMenuLinkIter* gobjectValue = G_MENU_LINK_ITER(g_menu_model_iterate_item_links([self castedGObject], itemIndex));

	OGMenuLinkIter* returnValue = [OGMenuLinkIter wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}


@end