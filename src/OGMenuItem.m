/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenuItem.h"

#import "OGMenuModel.h"

@implementation OGMenuItem

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_MENU_ITEM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (instancetype)menuItemWithLabel:(OFString*)label detailedAction:(OFString*)detailedAction
{
	GMenuItem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_menu_item_new([label UTF8String], [detailedAction UTF8String]), GMenuItem, GMenuItem);

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

+ (instancetype)menuItemFromModelWithModel:(OGMenuModel*)model itemIndex:(gint)itemIndex
{
	GMenuItem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_menu_item_new_from_model([model castedGObject], itemIndex), GMenuItem, GMenuItem);

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
	GMenuItem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_menu_item_new_section([label UTF8String], [section castedGObject]), GMenuItem, GMenuItem);

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
	GMenuItem* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_menu_item_new_submenu([label UTF8String], [submenu castedGObject]), GMenuItem, GMenuItem);

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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GMenuItem, GMenuItem);
}

- (GVariant*)attributeValueWithAttribute:(OFString*)attribute expectedType:(const GVariantType*)expectedType
{
	GVariant* returnValue = (GVariant*)g_menu_item_get_attribute_value([self castedGObject], [attribute UTF8String], expectedType);

	return returnValue;
}

- (OGMenuModel*)link:(OFString*)link
{
	GMenuModel* gobjectValue = g_menu_item_get_link([self castedGObject], [link UTF8String]);

	OGMenuModel* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)setActionAndTargetValueWithAction:(OFString*)action targetValue:(GVariant*)targetValue
{
	g_menu_item_set_action_and_target_value([self castedGObject], [action UTF8String], targetValue);
}

- (void)setAttributeValueWithAttribute:(OFString*)attribute value:(GVariant*)value
{
	g_menu_item_set_attribute_value([self castedGObject], [attribute UTF8String], value);
}

- (void)setDetailedAction:(OFString*)detailedAction
{
	g_menu_item_set_detailed_action([self castedGObject], [detailedAction UTF8String]);
}

- (void)setIcon:(GIcon*)icon
{
	g_menu_item_set_icon([self castedGObject], icon);
}

- (void)setLabel:(OFString*)label
{
	g_menu_item_set_label([self castedGObject], [label UTF8String]);
}

- (void)setLinkWithLink:(OFString*)link model:(OGMenuModel*)model
{
	g_menu_item_set_link([self castedGObject], [link UTF8String], [model castedGObject]);
}

- (void)setSection:(OGMenuModel*)section
{
	g_menu_item_set_section([self castedGObject], [section castedGObject]);
}

- (void)setSubmenu:(OGMenuModel*)submenu
{
	g_menu_item_set_submenu([self castedGObject], [submenu castedGObject]);
}


@end