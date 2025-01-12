/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixfdmessage.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gio.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

/**
 * Entry point for using GIO functionality.
 *
 */
@interface OGVfs : OGObject
{

}

/**
 * Functions
 */
+ (void)load;


/**
 * Gets the default #GVfs for the system.
 *
 * @return a #GVfs, which will be the local
 *     file system #GVfs if no other implementation is available.
 */
+ (OGVfs*)default;

/**
 * Gets the local #GVfs for the system.
 *
 * @return a #GVfs.
 */
+ (OGVfs*)local;

/**
 * Methods
 */

- (GVfs*)castedGObject;

/**
 * Gets a #GFile for @path.
 *
 * @param path a string containing a VFS path.
 * @return a #GFile.
 *     Free the returned object with g_object_unref().
 */
- (GFile*)fileForPath:(OFString*)path;

/**
 * Gets a #GFile for @uri.
 * 
 * This operation never fails, but the returned object
 * might not support any I/O operation if the URI
 * is malformed or if the URI scheme is not supported.
 *
 * @param uri a string containing a URI
 * @return a #GFile.
 *     Free the returned object with g_object_unref().
 */
- (GFile*)fileForUri:(OFString*)uri;

/**
 * Gets a list of URI schemes supported by @vfs.
 *
 * @return a %NULL-terminated array of strings.
 *     The returned array belongs to GIO and must
 *     not be freed or modified.
 */
- (const gchar* const*)supportedUriSchemes;

/**
 * Checks if the VFS is active.
 *
 * @return %TRUE if construction of the @vfs was successful
 *     and it is now active.
 */
- (bool)isActive;

/**
 * This operation never fails, but the returned object might
 * not support any I/O operations if the @parse_name cannot
 * be parsed by the #GVfs module.
 *
 * @param parseName a string to be parsed by the VFS module.
 * @return a #GFile for the given @parse_name.
 *     Free the returned object with g_object_unref().
 */
- (GFile*)parseName:(OFString*)parseName;

/**
 * Registers @uri_func and @parse_name_func as the #GFile URI and parse name
 * lookup functions for URIs with a scheme matching @scheme.
 * Note that @scheme is registered only within the running application, as
 * opposed to desktop-wide as it happens with GVfs backends.
 * 
 * When a #GFile is requested with an URI containing @scheme (e.g. through
 * g_file_new_for_uri()), @uri_func will be called to allow a custom
 * constructor. The implementation of @uri_func should not be blocking, and
 * must not call g_vfs_register_uri_scheme() or g_vfs_unregister_uri_scheme().
 * 
 * When g_file_parse_name() is called with a parse name obtained from such file,
 * @parse_name_func will be called to allow the #GFile to be created again. In
 * that case, it's responsibility of @parse_name_func to make sure the parse
 * name matches what the custom #GFile implementation returned when
 * g_file_get_parse_name() was previously called. The implementation of
 * @parse_name_func should not be blocking, and must not call
 * g_vfs_register_uri_scheme() or g_vfs_unregister_uri_scheme().
 * 
 * It's an error to call this function twice with the same scheme. To unregister
 * a custom URI scheme, use g_vfs_unregister_uri_scheme().
 *
 * @param scheme an URI scheme, e.g. "http"
 * @param uriFunc a #GVfsFileLookupFunc
 * @param uriData custom data passed to be passed to @uri_func, or %NULL
 * @param uriDestroy function to be called when unregistering the
 *     URI scheme, or when @vfs is disposed, to free the resources used
 *     by the URI lookup function
 * @param parseNameFunc a #GVfsFileLookupFunc
 * @param parseNameData custom data passed to be passed to
 *     @parse_name_func, or %NULL
 * @param parseNameDestroy function to be called when unregistering the
 *     URI scheme, or when @vfs is disposed, to free the resources used
 *     by the parse name lookup function
 * @return %TRUE if @scheme was successfully registered, or %FALSE if a handler
 *     for @scheme already exists.
 */
- (bool)registerUriSchemeWithScheme:(OFString*)scheme uriFunc:(GVfsFileLookupFunc)uriFunc uriData:(gpointer)uriData uriDestroy:(GDestroyNotify)uriDestroy parseNameFunc:(GVfsFileLookupFunc)parseNameFunc parseNameData:(gpointer)parseNameData parseNameDestroy:(GDestroyNotify)parseNameDestroy;

/**
 * Unregisters the URI handler for @scheme previously registered with
 * g_vfs_register_uri_scheme().
 *
 * @param scheme an URI scheme, e.g. "http"
 * @return %TRUE if @scheme was successfully unregistered, or %FALSE if a
 *     handler for @scheme does not exist.
 */
- (bool)unregisterUriScheme:(OFString*)scheme;

@end