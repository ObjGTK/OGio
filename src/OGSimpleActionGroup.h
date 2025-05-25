/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

/**
 * `GSimpleActionGroup` is a hash table filled with [iface@Gio.Action] objects,
 * implementing the [iface@Gio.ActionGroup] and [iface@Gio.ActionMap]
 * interfaces.
 *
 */
@interface OGSimpleActionGroup : OGObject
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
+ (instancetype)simpleActionGroup;

/**
 * Methods
 */

- (GSimpleActionGroup*)castedGObject;

/**
 * A convenience function for creating multiple #GSimpleAction instances
 * and adding them to the action group.
 *
 * @param entries a pointer to the first item in
 *           an array of #GActionEntry structs
 * @param nentries the length of @entries, or -1
 * @param userData the user data for signal connections
 */
- (void)addEntries:(const GActionEntry*)entries nentries:(gint)nentries userData:(gpointer)userData;

/**
 * Adds an action to the action group.
 * 
 * If the action group already contains an action with the same name as
 * @action then the old action is dropped from the group.
 * 
 * The action group takes its own reference on @action.
 *
 * @param action a #GAction
 */
- (void)insertWithAction:(GAction*)action;

/**
 * Looks up the action with the name @action_name in the group.
 * 
 * If no such action exists, returns %NULL.
 *
 * @param actionName the name of an action
 * @return a #GAction, or %NULL
 */
- (GAction*)lookupWithActionName:(OFString*)actionName;

/**
 * Removes the named action from the action group.
 * 
 * If no action of this name is in the group then nothing happens.
 *
 * @param actionName the name of the action
 */
- (void)removeWithActionName:(OFString*)actionName;

@end