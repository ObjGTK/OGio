/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#define G_SETTINGS_ENABLE_BACKEND

#include <gio/gsettingsbackend.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixfdmessage.h>
#include <gio/gio.h>

#import <OGObject/OGObject.h>

/**
 * The #GSettingsBackend interface defines a generic interface for
 * non-strictly-typed data that is stored in a hierarchy. To implement
 * an alternative storage backend for #GSettings, you need to implement
 * the #GSettingsBackend interface and then make it implement the
 * extension point %G_SETTINGS_BACKEND_EXTENSION_POINT_NAME.
 * 
 * The interface defines methods for reading and writing values, a
 * method for determining if writing of certain values will fail
 * (lockdown) and a change notification mechanism.
 * 
 * The semantics of the interface are very precisely defined and
 * implementations must carefully adhere to the expectations of
 * callers that are documented on each of the interface methods.
 * 
 * Some of the #GSettingsBackend functions accept or return a #GTree.
 * These trees always have strings as keys and #GVariant as values.
 * g_settings_backend_create_tree() is a convenience function to create
 * suitable trees.
 * 
 * The #GSettingsBackend API is exported to allow third-party
 * implementations, but does not carry the same stability guarantees
 * as the public GIO API. For this reason, you have to define the
 * C preprocessor symbol %G_SETTINGS_ENABLE_BACKEND before including
 * `gio/gsettingsbackend.h`.
 *
 */
@interface OGSettingsBackend : OGObject
{

}

/**
 * Functions
 */

/**
 * Calculate the longest common prefix of all keys in a tree and write
 * out an array of the key names relative to that prefix and,
 * optionally, the value to store at each of those keys.
 * 
 * You must free the value returned in @path, @keys and @values using
 * g_free().  You should not attempt to free or unref the contents of
 * @keys or @values.
 *
 * @param tree a #GTree containing the changes
 * @param path the location to save the path
 * @param keys the
 *        location to save the relative keys
 * @param values the location to save the values, or %NULL
 */
+ (void)flattenTreeWithTree:(GTree*)tree path:(gchar**)path keys:(const gchar***)keys values:(GVariant***)values;

/**
 * Returns the default #GSettingsBackend. It is possible to override
 * the default by setting the `GSETTINGS_BACKEND` environment variable
 * to the name of a settings backend.
 * 
 * The user gets a reference to the backend.
 *
 * @return the default #GSettingsBackend,
 *     which will be a dummy (memory) settings backend if no other settings
 *     backend is available.
 */
+ (OGSettingsBackend*)default;

/**
 * Methods
 */

- (GSettingsBackend*)castedGObject;

/**
 * Signals that a single key has possibly changed.  Backend
 * implementations should call this if a key has possibly changed its
 * value.
 * 
 * @key must be a valid key (ie starting with a slash, not containing
 * '//', and not ending with a slash).
 * 
 * The implementation must call this function during any call to
 * g_settings_backend_write(), before the call returns (except in the
 * case that no keys are actually changed and it cares to detect this
 * fact).  It may not rely on the existence of a mainloop for
 * dispatching the signal later.
 * 
 * The implementation may call this function at any other time it likes
 * in response to other events (such as changes occurring outside of the
 * program).  These calls may originate from a mainloop or may originate
 * in response to any other action (including from calls to
 * g_settings_backend_write()).
 * 
 * In the case that this call is in response to a call to
 * g_settings_backend_write() then @origin_tag must be set to the same
 * value that was passed to that call.
 *
 * @param key the name of the key
 * @param originTag the origin tag
 */
- (void)changedWithKey:(OFString*)key originTag:(gpointer)originTag;

/**
 * This call is a convenience wrapper.  It gets the list of changes from
 * @tree, computes the longest common prefix and calls
 * g_settings_backend_changed().
 *
 * @param tree a #GTree containing the changes
 * @param originTag the origin tag
 */
- (void)changedTreeWithTree:(GTree*)tree originTag:(gpointer)originTag;

/**
 * Signals that a list of keys have possibly changed.  Backend
 * implementations should call this if keys have possibly changed their
 * values.
 * 
 * @path must be a valid path (ie starting and ending with a slash and
 * not containing '//').  Each string in @items must form a valid key
 * name when @path is prefixed to it (ie: each item must not start or
 * end with '/' and must not contain '//').
 * 
 * The meaning of this signal is that any of the key names resulting
 * from the contatenation of @path with each item in @items may have
 * changed.
 * 
 * The same rules for when notifications must occur apply as per
 * g_settings_backend_changed().  These two calls can be used
 * interchangeably if exactly one item has changed (although in that
 * case g_settings_backend_changed() is definitely preferred).
 * 
 * For efficiency reasons, the implementation should strive for @path to
 * be as long as possible (ie: the longest common prefix of all of the
 * keys that were changed) but this is not strictly required.
 *
 * @param path the path containing the changes
 * @param items the %NULL-terminated list of changed keys
 * @param originTag the origin tag
 */
- (void)keysChangedWithPath:(OFString*)path items:(const gchar* const*)items originTag:(gpointer)originTag;

/**
 * Signals that all keys below a given path may have possibly changed.
 * Backend implementations should call this if an entire path of keys
 * have possibly changed their values.
 * 
 * @path must be a valid path (ie starting and ending with a slash and
 * not containing '//').
 * 
 * The meaning of this signal is that any of the key which has a name
 * starting with @path may have changed.
 * 
 * The same rules for when notifications must occur apply as per
 * g_settings_backend_changed().  This call might be an appropriate
 * reasponse to a 'reset' call but implementations are also free to
 * explicitly list the keys that were affected by that call if they can
 * easily do so.
 * 
 * For efficiency reasons, the implementation should strive for @path to
 * be as long as possible (ie: the longest common prefix of all of the
 * keys that were changed) but this is not strictly required.  As an
 * example, if this function is called with the path of "/" then every
 * single key in the application will be notified of a possible change.
 *
 * @param path the path containing the changes
 * @param originTag the origin tag
 */
- (void)pathChangedWithPath:(OFString*)path originTag:(gpointer)originTag;

/**
 * Signals that the writability of all keys below a given path may have
 * changed.
 * 
 * Since GSettings performs no locking operations for itself, this call
 * will always be made in response to external events.
 *
 * @param path the name of the path
 */
- (void)pathWritableChanged:(OFString*)path;

/**
 * Signals that the writability of a single key has possibly changed.
 * 
 * Since GSettings performs no locking operations for itself, this call
 * will always be made in response to external events.
 *
 * @param key the name of the key
 */
- (void)writableChanged:(OFString*)key;

@end