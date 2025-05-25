/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGListStore.h"

@implementation OGListStore

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_LIST_STORE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_LIST_STORE);
	return gObjectClass;
}

+ (instancetype)listStoreWithItemType:(GType)itemType
{
	GListStore* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_list_store_new(itemType), G_TYPE_LIST_STORE, GListStore);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGListStore* wrapperObject;
	@try {
		wrapperObject = [[OGListStore alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GListStore*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_LIST_STORE, GListStore);
}

- (void)appendWithItem:(gpointer)item
{
	g_list_store_append([self castedGObject], item);
}

- (bool)findWithItem:(gpointer)item position:(guint*)position
{
	bool returnValue = (bool)g_list_store_find([self castedGObject], item, position);

	return returnValue;
}

- (bool)findWithEqualFuncWithItem:(gpointer)item equalFunc:(GEqualFunc)equalFunc position:(guint*)position
{
	bool returnValue = (bool)g_list_store_find_with_equal_func([self castedGObject], item, equalFunc, position);

	return returnValue;
}

- (bool)findWithEqualFuncFullWithItem:(gpointer)item equalFunc:(GEqualFuncFull)equalFunc userData:(gpointer)userData position:(guint*)position
{
	bool returnValue = (bool)g_list_store_find_with_equal_func_full([self castedGObject], item, equalFunc, userData, position);

	return returnValue;
}

- (void)insertWithPosition:(guint)position item:(gpointer)item
{
	g_list_store_insert([self castedGObject], position, item);
}

- (guint)insertSortedWithItem:(gpointer)item compareFunc:(GCompareDataFunc)compareFunc userData:(gpointer)userData
{
	guint returnValue = (guint)g_list_store_insert_sorted([self castedGObject], item, compareFunc, userData);

	return returnValue;
}

- (void)removeWithPosition:(guint)position
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