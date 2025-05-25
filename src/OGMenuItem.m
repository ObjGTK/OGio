/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenuItem.h"

#import "OGMenuModel.h"

@implementation OGMenuItem

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_MENU_ITEM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_MENU_ITEM);
	return gObjectClass;
}

+ (instancetype)menuItemWithLabel:(OFString*)label detailedAction:(OFString*)detailedAction
{
	GMenuItem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_menu_item_new([label UTF8String], [detailedAction UTF8String]), G_TYPE_MENU_ITEM, GMenuItem);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMenuItem* wrapperObject;
	@try {
		wrapperObject = [[OGMenuItem alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)menuItemFromModel:(OGMenuModel*)model itemIndex:(gint)itemIndex
{
	GMenuItem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_menu_item_new_from_model([model castedGObject], itemIndex), G_TYPE_MENU_ITEM, GMenuItem);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMenuItem* wrapperObject;
	@try {
		wrapperObject = [[OGMenuItem alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)menuItemSectionWithLabel:(OFString*)label section:(OGMenuModel*)section
{
	GMenuItem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_menu_item_new_section([label UTF8String], [section castedGObject]), G_TYPE_MENU_ITEM, GMenuItem);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMenuItem* wrapperObject;
	@try {
		wrapperObject = [[OGMenuItem alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)menuItemSubmenuWithLabel:(OFString*)label submenu:(OGMenuModel*)submenu
{
	GMenuItem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_menu_item_new_submenu([label UTF8String], [submenu castedGObject]), G_TYPE_MENU_ITEM, GMenuItem);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMenuItem* wrapperObject;
	@try {
		wrapperObject = [[OGMenuItem alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GMenuItem*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_MENU_ITEM, GMenuItem);
}

- (GVariant*)attributeValueWithAttribute:(OFString*)attribute expectedType:(const GVariantType*)expectedType
{
	GVariant* returnValue = (GVariant*)g_menu_item_get_attribute_value((GMenuItem*)[self castedGObject], [attribute UTF8String], expectedType);

	return returnValue;
}

- (OGMenuModel*)linkWithLink:(OFString*)link
{
	GMenuModel* gobjectValue = g_menu_item_get_link((GMenuItem*)[self castedGObject], [link UTF8String]);

	OGMenuModel* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)setActionAndTargetValue:(OFString*)action targetValue:(GVariant*)targetValue
{
	g_menu_item_set_action_and_target_value((GMenuItem*)[self castedGObject], [action UTF8String], targetValue);
}

- (void)setAttributeValue:(OFString*)attribute value:(GVariant*)value
{
	g_menu_item_set_attribute_value((GMenuItem*)[self castedGObject], [attribute UTF8String], value);
}

- (void)setDetailedAction:(OFString*)detailedAction
{
	g_menu_item_set_detailed_action((GMenuItem*)[self castedGObject], [detailedAction UTF8String]);
}

- (void)setIcon:(GIcon*)icon
{
	g_menu_item_set_icon((GMenuItem*)[self castedGObject], icon);
}

- (void)setLabel:(OFString*)label
{
	g_menu_item_set_label((GMenuItem*)[self castedGObject], [label UTF8String]);
}

- (void)setLink:(OFString*)link model:(OGMenuModel*)model
{
	g_menu_item_set_link((GMenuItem*)[self castedGObject], [link UTF8String], [model castedGObject]);
}

- (void)setSection:(OGMenuModel*)section
{
	g_menu_item_set_section((GMenuItem*)[self castedGObject], [section castedGObject]);
}

- (void)setSubmenu:(OGMenuModel*)submenu
{
	g_menu_item_set_submenu((GMenuItem*)[self castedGObject], [submenu castedGObject]);
}


@end