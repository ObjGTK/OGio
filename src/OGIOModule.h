/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixfdmessage.h>
#include <gio/gio.h>

#import <OGObject/OGObject.h>

/**
 * Provides an interface and default functions for loading and unloading
 * modules. This is used internally to make GIO extensible, but can also
 * be used by others to implement module loading.
 *
 */
@interface OGIOModule : OGObject
{

}

/**
 * Functions
 */

/**
 * Optional API for GIO modules to implement.
 * 
 * Should return a list of all the extension points that may be
 * implemented in this module.
 * 
 * This method will not be called in normal use, however it may be
 * called when probing existing modules and recording which extension
 * points that this model is used for. This means we won't have to
 * load and initialize this module unless its needed.
 * 
 * If this function is not implemented by the module the module will
 * always be loaded, initialized and then unloaded on application
 * startup so that it can register its extension points during init.
 * 
 * Note that a module need not actually implement all the extension
 * points that g_io_module_query() returns, since the exact list of
 * extension may depend on runtime issues. However all extension
 * points actually implemented must be returned by g_io_module_query()
 * (if defined).
 * 
 * When installing a module that implements g_io_module_query() you must
 * run gio-querymodules in order to build the cache files required for
 * lazy loading.
 * 
 * Since 2.56, this function should be named `g_io_<modulename>_query`, where
 * `modulename` is the plugin’s filename with the `lib` or `libgio` prefix and
 * everything after the first dot removed, and with `-` replaced with `_`
 * throughout. For example, `libgiognutls-helper.so` becomes `gnutls_helper`.
 * Using the new symbol names avoids name clashes when building modules
 * statically. The old symbol names continue to be supported, but cannot be used
 * for static builds.
 *
 * @return A %NULL-terminated array of strings,
 *     listing the supported extension points of the module. The array
 *     must be suitable for freeing with g_strfreev().
 */
+ (char**)query;

/**
 * Constructors
 */
- (instancetype)init:(OFString*)filename;

/**
 * Methods
 */

- (GIOModule*)castedGObject;

/**
 * Required API for GIO modules to implement.
 * 
 * This function is run after the module has been loaded into GIO,
 * to initialize the module. Typically, this function will call
 * g_io_extension_point_implement().
 * 
 * Since 2.56, this function should be named `g_io_<modulename>_load`, where
 * `modulename` is the plugin’s filename with the `lib` or `libgio` prefix and
 * everything after the first dot removed, and with `-` replaced with `_`
 * throughout. For example, `libgiognutls-helper.so` becomes `gnutls_helper`.
 * Using the new symbol names avoids name clashes when building modules
 * statically. The old symbol names continue to be supported, but cannot be used
 * for static builds.
 *
 */
- (void)load;

/**
 * Required API for GIO modules to implement.
 * 
 * This function is run when the module is being unloaded from GIO,
 * to finalize the module.
 * 
 * Since 2.56, this function should be named `g_io_<modulename>_unload`, where
 * `modulename` is the plugin’s filename with the `lib` or `libgio` prefix and
 * everything after the first dot removed, and with `-` replaced with `_`
 * throughout. For example, `libgiognutls-helper.so` becomes `gnutls_helper`.
 * Using the new symbol names avoids name clashes when building modules
 * statically. The old symbol names continue to be supported, but cannot be used
 * for static builds.
 *
 */
- (void)unload;

@end