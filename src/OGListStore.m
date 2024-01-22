/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGListStore.h"

@implementation OGListStore

- (instancetype)init:(GType)itemType
{
	GListStore* gobjectValue = G_LIST_STORE(g_list_store_new(itemType));

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

- (GListStore*)castedGObject
{
	return G_LIST_STORE([self gObject]);
}

- (void)append:(gpointer)item
{
	g_list_store_append([self castedGObject], item);
}

- (bool)findWithItem:(gpointer)item position:(guint*)position
{
	bool returnValue = g_list_store_find([self castedGObject], item, position);

	return returnValue;
}

- (bool)findWithEqualFuncWithItem:(gpointer)item equalFunc:(GEqualFunc)equalFunc position:(guint*)position
{
	bool returnValue = g_list_store_find_with_equal_func([self castedGObject], item, equalFunc, position);

	return returnValue;
}

- (bool)findWithEqualFuncFullWithItem:(gpointer)item equalFunc:(GEqualFuncFull)equalFunc userData:(gpointer)userData position:(guint*)position
{
	bool returnValue = g_list_store_find_with_equal_func_full([self castedGObject], item, equalFunc, userData, position);

	return returnValue;
}

- (void)insertWithPosition:(guint)position item:(gpointer)item
{
	g_list_store_insert([self castedGObject], position, item);
}

- (guint)insertSortedWithItem:(gpointer)item compareFunc:(GCompareDataFunc)compareFunc userData:(gpointer)userData
{
	guint returnValue = g_list_store_insert_sorted([self castedGObject], item, compareFunc, userData);

	return returnValue;
}

- (void)remove:(guint)position
{
	g_list_store_remove([self castedGObject], position);
}

- (void)removeAll
{
	g_list_store_remove_all([self castedGObject]);
}

- (void)sortWithCompareFunc:(GCompareDataFunc)compareFunc userData:(gpointer)userData
{
	g_list_store_sort([self castedGObject], compareFunc, userData);
}

- (void)spliceWithPosition:(guint)position nremovals:(guint)nremovals additions:(gpointer*)additions nadditions:(guint)nadditions
{
	g_list_store_splice([self castedGObject], position, nremovals, additions, nadditions);
}


@end