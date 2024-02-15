/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

@class OGAppLaunchContext;

/**
 * #GDesktopAppInfo is an implementation of #GAppInfo based on
 * desktop files.
 * 
 * Note that `<gio/gdesktopappinfo.h>` belongs to the UNIX-specific
 * GIO interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file when using it.
 *
 */
@interface OGDesktopAppInfo : OGObject
{

}

/**
 * Functions
 */

/**
 * Gets all applications that implement @interface.
 * 
 * An application implements an interface if that interface is listed in
 * the Implements= line of the desktop file of the application.
 *
 * @param interface the name of the interface
 * @return a list of #GDesktopAppInfo
 * objects.
 */
+ (GList*)implementations:(OFString*)interface;

/**
 * Searches desktop files for ones that match @search_string.
 * 
 * The return value is an array of strvs.  Each strv contains a list of
 * applications that matched @search_string with an equal score.  The
 * outer list is sorted by score so that the first strv contains the
 * best-matching applications, and so on.
 * The algorithm for determining matches is undefined and may change at
 * any time.
 * 
 * None of the search results are subjected to the normal validation
 * checks performed by g_desktop_app_info_new() (for example, checking that
 * the executable referenced by a result exists), and so it is possible for
 * g_desktop_app_info_new() to return %NULL when passed an app ID returned by
 * this function. It is expected that calling code will do this when
 * subsequently creating a #GDesktopAppInfo for each result.
 *
 * @param searchString the search string to use
 * @return a
 *   list of strvs.  Free each item with g_strfreev() and free the outer
 *   list with g_free().
 */
+ (gchar***)search:(OFString*)searchString;

/**
 * do not use this API.  Since 2.42 the value of the
 * `XDG_CURRENT_DESKTOP` environment variable will be used.
 *
 * @param desktopEnv a string specifying what desktop this is
 */
+ (void)setDesktopEnv:(OFString*)desktopEnv;

/**
 * Constructors
 */
- (instancetype)init:(OFString*)desktopId;
- (instancetype)initFromFilename:(OFString*)filename;
- (instancetype)initFromKeyfile:(GKeyFile*)keyFile;

/**
 * Methods
 */

- (GDesktopAppInfo*)castedGObject;

/**
 * Gets the user-visible display name of the "additional application
 * action" specified by @action_name.
 * 
 * This corresponds to the "Name" key within the keyfile group for the
 * action.
 *
 * @param actionName the name of the action as from
 *   g_desktop_app_info_list_actions()
 * @return the locale-specific action name
 */
- (OFString*)actionName:(OFString*)actionName;

/**
 * Looks up a boolean value in the keyfile backing @info.
 * 
 * The @key is looked up in the "Desktop Entry" group.
 *
 * @param key the key to look up
 * @return the boolean value, or %FALSE if the key
 *     is not found
 */
- (bool)boolean:(OFString*)key;

/**
 * Gets the categories from the desktop file.
 *
 * @return The unparsed Categories key from the desktop file;
 *     i.e. no attempt is made to split it by ';' or validate it.
 */
- (OFString*)categories;

/**
 * When @info was created from a known filename, return it.  In some
 * situations such as the #GDesktopAppInfo returned from
 * g_desktop_app_info_new_from_keyfile(), this function will return %NULL.
 *
 * @return The full path to the file for @info,
 *     or %NULL if not known.
 */
- (OFString*)filename;

/**
 * Gets the generic name from the desktop file.
 *
 * @return The value of the GenericName key
 */
- (OFString*)genericName;

/**
 * A desktop file is hidden if the Hidden key in it is
 * set to True.
 *
 * @return %TRUE if hidden, %FALSE otherwise.
 */
- (bool)isHidden;

/**
 * Gets the keywords from the desktop file.
 *
 * @return The value of the Keywords key
 */
- (const char* const*)keywords;

/**
 * Looks up a localized string value in the keyfile backing @info
 * translated to the current locale.
 * 
 * The @key is looked up in the "Desktop Entry" group.
 *
 * @param key the key to look up
 * @return a newly allocated string, or %NULL if the key
 *     is not found
 */
- (char*)localeString:(OFString*)key;

/**
 * Gets the value of the NoDisplay key, which helps determine if the
 * application info should be shown in menus. See
 * %G_KEY_FILE_DESKTOP_KEY_NO_DISPLAY and g_app_info_should_show().
 *
 * @return The value of the NoDisplay key
 */
- (bool)nodisplay;

/**
 * Checks if the application info should be shown in menus that list available
 * applications for a specific name of the desktop, based on the
 * `OnlyShowIn` and `NotShowIn` keys.
 * 
 * @desktop_env should typically be given as %NULL, in which case the
 * `XDG_CURRENT_DESKTOP` environment variable is consulted.  If you want
 * to override the default mechanism then you may specify @desktop_env,
 * but this is not recommended.
 * 
 * Note that g_app_info_should_show() for @info will include this check (with
 * %NULL for @desktop_env) as well as additional checks.
 *
 * @param desktopEnv a string specifying a desktop name
 * @return %TRUE if the @info should be shown in @desktop_env according to the
 * `OnlyShowIn` and `NotShowIn` keys, %FALSE
 * otherwise.
 */
- (bool)showIn:(OFString*)desktopEnv;

/**
 * Retrieves the StartupWMClass field from @info. This represents the
 * WM_CLASS property of the main window of the application, if launched
 * through @info.
 *
 * @return the startup WM class, or %NULL if none is set
 * in the desktop file.
 */
- (OFString*)startupWmClass;

/**
 * Looks up a string value in the keyfile backing @info.
 * 
 * The @key is looked up in the "Desktop Entry" group.
 *
 * @param key the key to look up
 * @return a newly allocated string, or %NULL if the key
 *     is not found
 */
- (char*)string:(OFString*)key;

/**
 * Looks up a string list value in the keyfile backing @info.
 * 
 * The @key is looked up in the "Desktop Entry" group.
 *
 * @param key the key to look up
 * @param length return location for the number of returned strings, or %NULL
 * @return a %NULL-terminated string array or %NULL if the specified
 *  key cannot be found. The array should be freed with g_strfreev().
 */
- (gchar**)stringListWithKey:(OFString*)key length:(gsize*)length;

/**
 * Returns whether @key exists in the "Desktop Entry" group
 * of the keyfile backing @info.
 *
 * @param key the key to look up
 * @return %TRUE if the @key exists
 */
- (bool)hasKey:(OFString*)key;

/**
 * Activates the named application action.
 * 
 * You may only call this function on action names that were
 * returned from g_desktop_app_info_list_actions().
 * 
 * Note that if the main entry of the desktop file indicates that the
 * application supports startup notification, and @launch_context is
 * non-%NULL, then startup notification will be used when activating the
 * action (and as such, invocation of the action on the receiving side
 * must signal the end of startup notification when it is completed).
 * This is the expected behaviour of applications declaring additional
 * actions, as per the desktop file specification.
 * 
 * As with g_app_info_launch() there is no way to detect failures that
 * occur while using this function.
 *
 * @param actionName the name of the action as from
 *   g_desktop_app_info_list_actions()
 * @param launchContext a #GAppLaunchContext
 */
- (void)launchActionWithActionName:(OFString*)actionName launchContext:(OGAppLaunchContext*)launchContext;

/**
 * This function performs the equivalent of g_app_info_launch_uris(),
 * but is intended primarily for operating system components that
 * launch applications.  Ordinary applications should use
 * g_app_info_launch_uris().
 * 
 * If the application is launched via GSpawn, then @spawn_flags, @user_setup
 * and @user_setup_data are used for the call to g_spawn_async().
 * Additionally, @pid_callback (with @pid_callback_data) will be called to
 * inform about the PID of the created process. See g_spawn_async_with_pipes()
 * for information on certain parameter conditions that can enable an
 * optimized posix_spawn() codepath to be used.
 * 
 * If application launching occurs via some other mechanism (eg: D-Bus
 * activation) then @spawn_flags, @user_setup, @user_setup_data,
 * @pid_callback and @pid_callback_data are ignored.
 *
 * @param uris List of URIs
 * @param launchContext a #GAppLaunchContext
 * @param spawnFlags #GSpawnFlags, used for each process
 * @param userSetup a #GSpawnChildSetupFunc, used once
 *     for each process.
 * @param userSetupData User data for @user_setup
 * @param pidCallback Callback for child processes
 * @param pidCallbackData User data for @callback
 * @return %TRUE on successful launch, %FALSE otherwise.
 */
- (bool)launchUrisAsManagerWithUris:(GList*)uris launchContext:(OGAppLaunchContext*)launchContext spawnFlags:(GSpawnFlags)spawnFlags userSetup:(GSpawnChildSetupFunc)userSetup userSetupData:(gpointer)userSetupData pidCallback:(GDesktopAppLaunchCallback)pidCallback pidCallbackData:(gpointer)pidCallbackData;

/**
 * Equivalent to g_desktop_app_info_launch_uris_as_manager() but allows
 * you to pass in file descriptors for the stdin, stdout and stderr streams
 * of the launched process.
 * 
 * If application launching occurs via some non-spawn mechanism (e.g. D-Bus
 * activation) then @stdin_fd, @stdout_fd and @stderr_fd are ignored.
 *
 * @param uris List of URIs
 * @param launchContext a #GAppLaunchContext
 * @param spawnFlags #GSpawnFlags, used for each process
 * @param userSetup a #GSpawnChildSetupFunc, used once
 *     for each process.
 * @param userSetupData User data for @user_setup
 * @param pidCallback Callback for child processes
 * @param pidCallbackData User data for @callback
 * @param stdinFd file descriptor to use for child's stdin, or -1
 * @param stdoutFd file descriptor to use for child's stdout, or -1
 * @param stderrFd file descriptor to use for child's stderr, or -1
 * @return %TRUE on successful launch, %FALSE otherwise.
 */
- (bool)launchUrisAsManagerWithFdsWithUris:(GList*)uris launchContext:(OGAppLaunchContext*)launchContext spawnFlags:(GSpawnFlags)spawnFlags userSetup:(GSpawnChildSetupFunc)userSetup userSetupData:(gpointer)userSetupData pidCallback:(GDesktopAppLaunchCallback)pidCallback pidCallbackData:(gpointer)pidCallbackData stdinFd:(gint)stdinFd stdoutFd:(gint)stdoutFd stderrFd:(gint)stderrFd;

/**
 * Returns the list of "additional application actions" supported on the
 * desktop file, as per the desktop file specification.
 * 
 * As per the specification, this is the list of actions that are
 * explicitly listed in the "Actions" key of the [Desktop Entry] group.
 *
 * @return a list of strings, always non-%NULL
 */
- (const gchar* const*)listActions;

@end