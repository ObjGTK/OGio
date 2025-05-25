/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenuModel.h"

@class OGMenuItem;

/**
 * `GMenu` is a simple implementation of [class@Gio.MenuModel].
 * You populate a `GMenu` by adding [class@Gio.MenuItem] instances to it.
 * 
 * There are some convenience functions to allow you to directly
 * add items (avoiding [class@Gio.MenuItem]) for the common cases. To add
 * a regular item, use [method@Gio.Menu.insert]. To add a section, use
 * [method@Gio.Menu.insert_section]. To add a submenu, use
 * [method@Gio.Menu.insert_submenu].
 *
 */
@interface OGMenu : OGMenuModel
{

}

/**
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Constructors
 */
+ (instancetype)menu;

/**
 * Methods
 */

- (GMenu*)castedGObject;

/**
 * Convenience function for appending a normal menu item to the end of
 * @menu.  Combine g_menu_item_new() and g_menu_insert_item() for a more
 * flexible alternative.
 *
 * @param label the section label, or %NULL
 * @param detailedAction the detailed action string, or %NULL
 */
- (void)appendWithLabel:(OFString*)label detailedAction:(OFString*)detailedAction;

/**
 * Appends @item to the end of @menu.
 * 
 * See g_menu_insert_item() for more information.
 *
 * @param item a #GMenuItem to append
 */
- (void)appendItem:(OGMenuItem*)item;

/**
 * Convenience function for appending a section menu item to the end of
 * @menu.  Combine g_menu_item_new_section() and g_menu_insert_item() for a
 * more flexible alternative.
 *
 * @param label the section label, or %NULL
 * @param section a #GMenuModel with the items of the section
 */
- (void)appendSectionWithLabel:(OFString*)label section:(OGMenuModel*)section;

/**
 * Convenience function for appending a submenu menu item to the end of
 * @menu.  Combine g_menu_item_new_submenu() and g_menu_insert_item() for a
 * more flexible alternative.
 *
 * @param label the section label, or %NULL
 * @param submenu a #GMenuModel with the items of the submenu
 */
- (void)appendSubmenuWithLabel:(OFString*)label submenu:(OGMenuModel*)submenu;

/**
 * Marks @menu as frozen.
 * 
 * After the menu is frozen, it is an error to attempt to make any
 * changes to it.  In effect this means that the #GMenu API must no
 * longer be used.
 * 
 * This function causes g_menu_model_is_mutable() to begin returning
 * %FALSE, which has some positive performance implications.
 *
 */
- (void)freeze;

/**
 * Convenience function for inserting a normal menu item into @menu.
 * Combine g_menu_item_new() and g_menu_insert_item() for a more flexible
 * alternative.
 *
 * @param position the position at which to insert the item
 * @param label the section label, or %NULL
 * @param detailedAction the detailed action string, or %NULL
 */
- (void)insertWithPosition:(gint)position label:(OFString*)label detailedAction:(OFString*)detailedAction;

/**
 * Inserts @item into @menu.
 * 
 * The "insertion" is actually done by copying all of the attribute and
 * link values of @item and using them to form a new item within @menu.
 * As such, @item itself is not really inserted, but rather, a menu item
 * that is exactly the same as the one presently described by @item.
 * 
 * This means that @item is essentially useless after the insertion
 * occurs.  Any changes you make to it are ignored unless it is inserted
 * again (at which point its updated values will be copied).
 * 
 * You should probably just free @item once you're done.
 * 
 * There are many convenience functions to take care of common cases.
 * See g_menu_insert(), g_menu_insert_section() and
 * g_menu_insert_submenu() as well as "prepend" and "append" variants of
 * each of these functions.
 *
 * @param position the position at which to insert the item
 * @param item the #GMenuItem to insert
 */
- (void)insertItemWithPosition:(gint)position item:(OGMenuItem*)item;

/**
 * Convenience function for inserting a section menu item into @menu.
 * Combine g_menu_item_new_section() and g_menu_insert_item() for a more
 * flexible alternative.
 *
 * @param position the position at which to insert the item
 * @param label the section label, or %NULL
 * @param section a #GMenuModel with the items of the section
 */
- (void)insertSectionWithPosition:(gint)position label:(OFString*)label section:(OGMenuModel*)section;

/**
 * Convenience function for inserting a submenu menu item into @menu.
 * Combine g_menu_item_new_submenu() and g_menu_insert_item() for a more
 * flexible alternative.
 *
 * @param position the position at which to insert the item
 * @param label the section label, or %NULL
 * @param submenu a #GMenuModel with the items of the submenu
 */
- (void)insertSubmenuWithPosition:(gint)position label:(OFString*)label submenu:(OGMenuModel*)submenu;

/**
 * Convenience function for prepending a normal menu item to the start
 * of @menu.  Combine g_menu_item_new() and g_menu_insert_item() for a more
 * flexible alternative.
 *
 * @param label the section label, or %NULL
 * @param detailedAction the detailed action string, or %NULL
 */
- (void)prependWithLabel:(OFString*)label detailedAction:(OFString*)detailedAction;

/**
 * Prepends @item to the start of @menu.
 * 
 * See g_menu_insert_item() for more information.
 *
 * @param item a #GMenuItem to prepend
 */
- (void)prependItem:(OGMenuItem*)item;

/**
 * Convenience function for prepending a section menu item to the start
 * of @menu.  Combine g_menu_item_new_section() and g_menu_insert_item() for
 * a more flexible alternative.
 *
 * @param label the section label, or %NULL
 * @param section a #GMenuModel with the items of the section
 */
- (void)prependSectionWithLabel:(OFString*)label section:(OGMenuModel*)section;

/**
 * Convenience function for prepending a submenu menu item to the start
 * of @menu.  Combine g_menu_item_new_submenu() and g_menu_insert_item() for
 * a more flexible alternative.
 *
 * @param label the section label, or %NULL
 * @param submenu a #GMenuModel with the items of the submenu
 */
- (void)prependSubmenuWithLabel:(OFString*)label submenu:(OGMenuModel*)submenu;

/**
 * Removes an item from the menu.
 * 
 * @position gives the index of the item to remove.
 * 
 * It is an error if position is not in range the range from 0 to one
 * less than the number of items in the menu.
 * 
 * It is not possible to remove items by identity since items are added
 * to the menu simply by copying their links and attributes (ie:
 * identity of the item itself is not preserved).
 *
 * @param position the position of the item to remove
 */
- (void)removeWithPosition:(gint)position;

/**
 * Removes all items in the menu.
 *
 */
- (void)removeAll;

@end