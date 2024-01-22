/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenu.h"

#import "OGMenuItem.h"

@implementation OGMenu

- (instancetype)init
{
	GMenu* gobjectValue = G_MENU(g_menu_new());

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

- (GMenu*)castedGObject
{
	return G_MENU([self gObject]);
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

- (void)remove:(gint)position
{
	g_menu_remove([self castedGObject], position);
}

- (void)removeAll
{
	g_menu_remove_all([self castedGObject]);
}


@end