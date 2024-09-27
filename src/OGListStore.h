/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>

#import <OGObject/OGObject.h>

/**
 * `GListStore` is a simple implementation of [iface@Gio.ListModel] that stores
 * all items in memory.
 * 
 * It provides insertions, deletions, and lookups in logarithmic time
 * with a fast path for the common case of iterating the list linearly.
 *
 */
@interface OGListStore : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)init:(GType)itemType;

/**
 * Methods
 */

- (GListStore*)castedGObject;

/**
 * Appends @item to @store. @item must be of type #GListStore:item-type.
 * 
 * This function takes a ref on @item.
 * 
 * Use g_list_store_splice() to append multiple items at the same time
 * efficiently.
 *
 * @param item the new item
 */
- (void)append:(gpointer)item;

/**
 * Looks up the given @item in the list store by looping over the items until
 * the first occurrence of @item. If @item was not found, then @position will
 * not be set, and this method will return %FALSE.
 * 
 * If you need to compare the two items with a custom comparison function, use
 * g_list_store_find_with_equal_func() with a custom #GEqualFunc instead.
 *
 * @param item an item
 * @param position the first position of @item, if it was found.
 * @return Whether @store contains @item. If it was found, @position will be
 * set to the position where @item occurred for the first time.
 */
- (bool)findWithItem:(gpointer)item position:(guint*)position;

/**
 * Looks up the given @item in the list store by looping over the items and
 * comparing them with @equal_func until the first occurrence of @item which
 * matches. If @item was not found, then @position will not be set, and this
 * method will return %FALSE.
 * 
 * @item is always passed as second parameter to @equal_func.
 * 
 * Since GLib 2.76 it is possible to pass `NULL` for @item.
 *
 * @param item an item
 * @param equalFunc A custom equality check function
 * @param position the first position of @item, if it was found.
 * @return Whether @store contains @item. If it was found, @position will be
 * set to the position where @item occurred for the first time.
 */
- (bool)findWithEqualFuncWithItem:(gpointer)item equalFunc:(GEqualFunc)equalFunc position:(guint*)position;

/**
 * Like g_list_store_find_with_equal_func() but with an additional @user_data
 * that is passed to @equal_func.
 * 
 * @item is always passed as second parameter to @equal_func.
 * 
 * Since GLib 2.76 it is possible to pass `NULL` for @item.
 *
 * @param item an item
 * @param equalFunc A custom equality check function
 * @param userData user data for @equal_func
 * @param position the first position of @item, if it was found.
 * @return Whether @store contains @item. If it was found, @position will be
 * set to the position where @item occurred for the first time.
 */
- (bool)findWithEqualFuncFullWithItem:(gpointer)item equalFunc:(GEqualFuncFull)equalFunc userData:(gpointer)userData position:(guint*)position;

/**
 * Inserts @item into @store at @position. @item must be of type
 * #GListStore:item-type or derived from it. @position must be smaller
 * than the length of the list, or equal to it to append.
 * 
 * This function takes a ref on @item.
 * 
 * Use g_list_store_splice() to insert multiple items at the same time
 * efficiently.
 *
 * @param position the position at which to insert the new item
 * @param item the new item
 */
- (void)insertWithPosition:(guint)position item:(gpointer)item;

/**
 * Inserts @item into @store at a position to be determined by the
 * @compare_func.
 * 
 * The list must already be sorted before calling this function or the
 * result is undefined.  Usually you would approach this by only ever
 * inserting items by way of this function.
 * 
 * This function takes a ref on @item.
 *
 * @param item the new item
 * @param compareFunc pairwise comparison function for sorting
 * @param userData user data for @compare_func
 * @return the position at which @item was inserted
 */
- (guint)insertSortedWithItem:(gpointer)item compareFunc:(GCompareDataFunc)compareFunc userData:(gpointer)userData;

/**
 * Removes the item from @store that is at @position. @position must be
 * smaller than the current length of the list.
 * 
 * Use g_list_store_splice() to remove multiple items at the same time
 * efficiently.
 *
 * @param position the position of the item that is to be removed
 */
- (void)remove:(guint)position;

/**
 * Removes all items from @store.
 *
 */
- (void)removeAll;

/**
 * Sort the items in @store according to @compare_func.
 *
 * @param compareFunc pairwise comparison function for sorting
 * @param userData user data for @compare_func
 */
- (void)sortWithCompareFunc:(GCompareDataFunc)compareFunc userData:(gpointer)userData;

/**
 * Changes @store by removing @n_removals items and adding @n_additions
 * items to it. @additions must contain @n_additions items of type
 * #GListStore:item-type.  %NULL is not permitted.
 * 
 * This function is more efficient than g_list_store_insert() and
 * g_list_store_remove(), because it only emits
 * #GListModel::items-changed once for the change.
 * 
 * This function takes a ref on each item in @additions.
 * 
 * The parameters @position and @n_removals must be correct (ie:
 * @position + @n_removals must be less than or equal to the length of
 * the list at the time this function is called).
 *
 * @param position the position at which to make the change
 * @param nremovals the number of items to remove
 * @param additions the items to add
 * @param nadditions the number of items to add
 */
- (void)spliceWithPosition:(guint)position nremovals:(guint)nremovals additions:(gpointer*)additions nadditions:(guint)nadditions;

@end