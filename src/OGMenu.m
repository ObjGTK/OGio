/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenu.h"

#import "OGMenuItem.h"

@implementation OGMenu

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_MENU;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_MENU);
	return gObjectClass;
}

+ (instancetype)menu
{
	GMenu* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_menu_new(), G_TYPE_MENU, GMenu);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMenu* wrapperObject;
	@try {
		wrapperObject = [[OGMenu alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GMenu*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_MENU, GMenu);
}

- (void)appendWithLabel:(OFString*)label detailedAction:(OFString*)detailedAction
{
	g_menu_append([self castedGObject], [label UTF8String], [detailedAction UTF8String]);
}

- (void)appendItem:(OGMenuItem*)item
{
	g_menu_append_item([self castedGObject], [item castedGObject]);
}

- (void)appendSectionWithLabel:(OFString*)label section:(OGMenuModel*)section
{
	g_menu_append_section([self castedGObject], [label UTF8String], [section castedGObject]);
}

- (void)appendSubmenuWithLabel:(OFString*)label submenu:(OGMenuModel*)submenu
{
	g_menu_append_submenu([self castedGObject], [label UTF8String], [submenu castedGObject]);
}

- (void)freeze
{
	g_menu_freeze([self castedGObject]);
}

- (void)insertWithPosition:(gint)position label:(OFString*)label detailedAction:(OFString*)detailedAction
{
	g_menu_insert([self castedGObject], position, [label UTF8String], [detailedAction UTF8String]);
}

- (void)insertItemWithPosition:(gint)position item:(OGMenuItem*)item
{
	g_menu_insert_item([self castedGObject], position, [item castedGObject]);
}

- (void)insertSectionWithPosition:(gint)position label:(OFString*)label section:(OGMenuModel*)section
{
	g_menu_insert_section([self castedGObject], position, [label UTF8String], [section castedGObject]);
}

- (void)insertSubmenuWithPosition:(gint)position label:(OFString*)label submenu:(OGMenuModel*)submenu
{
	g_menu_insert_submenu([self castedGObject], position, [label UTF8String], [submenu castedGObject]);
}

- (void)prependWithLabel:(OFString*)label detailedAction:(OFString*)detailedAction
{
	g_menu_prepend([self castedGObject], [label UTF8String], [detailedAction UTF8String]);
}

- (void)prependItem:(OGMenuItem*)item
{
	g_menu_prepend_item([self castedGObject], [item castedGObject]);
}

- (void)prependSectionWithLabel:(OFString*)label section:(OGMenuModel*)section
{
	g_menu_prepend_section([self castedGObject], [label UTF8String], [section castedGObject]);
}

- (void)prependSubmenuWithLabel:(OFString*)label submenu:(OGMenuModel*)submenu
{
	g_menu_prepend_submenu([self castedGObject], [label UTF8String], [submenu castedGObject]);
}

- (void)removeWithPosition:(gint)position
{
	g_menu_remove([self castedGObject], position);
}

- (void)removeAll
{
	g_menu_remove_all([self castedGObject]);
}


@end