/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenuModel.h"

#import "OGMenuAttributeIter.h"
#import "OGMenuLinkIter.h"

@implementation OGMenuModel

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_MENU_MODEL;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_MENU_MODEL);
	return gObjectClass;
}

- (GMenuModel*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_MENU_MODEL, GMenuModel);
}

- (GVariant*)itemAttributeValueWithItemIndex:(gint)itemIndex attribute:(OFString*)attribute expectedType:(const GVariantType*)expectedType
{
	GVariant* returnValue = (GVariant*)g_menu_model_get_item_attribute_value([self castedGObject], itemIndex, [attribute UTF8String], expectedType);

	return returnValue;
}

- (OGMenuModel*)itemLinkWithItemIndex:(gint)itemIndex link:(OFString*)link
{
	GMenuModel* gobjectValue = g_menu_model_get_item_link([self castedGObject], itemIndex, [link UTF8String]);

	OGMenuModel* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (gint)nitems
{
	gint returnValue = (gint)g_menu_model_get_n_items([self castedGObject]);

	return returnValue;
}

- (bool)isMutable
{
	bool returnValue = (bool)g_menu_model_is_mutable([self castedGObject]);

	return returnValue;
}

- (void)itemsChangedWithPosition:(gint)position removed:(gint)removed added:(gint)added
{
	g_menu_model_items_changed([self castedGObject], position, removed, added);
}

- (OGMenuAttributeIter*)iterateItemAttributesWithItemIndex:(gint)itemIndex
{
	GMenuAttributeIter* gobjectValue = g_menu_model_iterate_item_attributes([self castedGObject], itemIndex);

	OGMenuAttributeIter* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGMenuLinkIter*)iterateItemLinksWithItemIndex:(gint)itemIndex
{
	GMenuLinkIter* gobjectValue = g_menu_model_iterate_item_links([self castedGObject], itemIndex);

	OGMenuLinkIter* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}


@end