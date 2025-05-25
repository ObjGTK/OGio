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

@class OGSubprocess;

/**
 * This class contains a set of options for launching child processes,
 * such as where its standard input and output will be directed, the
 * argument list, the environment, and more.
 * 
 * While the [class@Gio.Subprocess] class has high level functions covering
 * popular cases, use of this class allows access to more advanced
 * options.  It can also be used to launch multiple subprocesses with
 * a similar configuration.
 *
 */
@interface OGSubprocessLauncher : OGObject
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
+ (instancetype)subprocessLauncherWithFlags:(GSubprocessFlags)flags;

/**
 * Methods
 */

- (GSubprocessLauncher*)castedGObject;

/**
 * Closes all the file descriptors previously passed to the object with
 * g_subprocess_launcher_take_fd(), g_subprocess_launcher_take_stderr_fd(), etc.
 * 
 * After calling this method, any subsequent calls to g_subprocess_launcher_spawn() or g_subprocess_launcher_spawnv() will
 * return %G_IO_ERROR_CLOSED. This method is idempotent if
 * called more than once.
 * 
 * This function is called automatically when the #GSubprocessLauncher
 * is disposed, but is provided separately so that garbage collected
 * language bindings can call it earlier to guarantee when FDs are closed.
 *
 */
- (void)close;

/**
 * Returns the value of the environment variable @variable in the
 * environment of processes launched from this launcher.
 * 
 * On UNIX, the returned string can be an arbitrary byte string.
 * On Windows, it will be UTF-8.
 *
 * @param variable the environment variable to get
 * @return the value of the environment variable,
 *     %NULL if unset
 */
- (OFString*)envWithVariable:(OFString*)variable;

/**
 * Sets up a child setup function.
 * 
 * The child setup function will be called after fork() but before
 * exec() on the child's side.
 * 
 * @destroy_notify will not be automatically called on the child's side
 * of the fork().  It will only be called when the last reference on the
 * #GSubprocessLauncher is dropped or when a new child setup function is
 * given.
 * 
 * %NULL can be given as @child_setup to disable the functionality.
 * 
 * Child setup functions are only available on UNIX.
 *
 * @param childSetup a #GSpawnChildSetupFunc to use as the child setup function
 * @param userData user data for @child_setup
 * @param destroyNotify a #GDestroyNotify for @user_data
 */
- (void)setChildSetup:(GSpawnChildSetupFunc)childSetup userData:(gpointer)userData destroyNotify:(GDestroyNotify)destroyNotify;

/**
 * Sets the current working directory that processes will be launched
 * with.
 * 
 * By default processes are launched with the current working directory
 * of the launching process at the time of launch.
 *
 * @param cwd the cwd for launched processes
 */
- (void)setCwd:(OFString*)cwd;

/**
 * Replace the entire environment of processes launched from this
 * launcher with the given 'environ' variable.
 * 
 * Typically you will build this variable by using g_listenv() to copy
 * the process 'environ' and using the functions g_environ_setenv(),
 * g_environ_unsetenv(), etc.
 * 
 * As an alternative, you can use g_subprocess_launcher_setenv(),
 * g_subprocess_launcher_unsetenv(), etc.
 * 
 * Pass an empty array to set an empty environment. Pass %NULL to inherit the
 * parent process’ environment. As of GLib 2.54, the parent process’ environment
 * will be copied when g_subprocess_launcher_set_environ() is called.
 * Previously, it was copied when the subprocess was executed. This means the
 * copied environment may now be modified (using g_subprocess_launcher_setenv(),
 * etc.) before launching the subprocess.
 * 
 * On UNIX, all strings in this array can be arbitrary byte strings.
 * On Windows, they should be in UTF-8.
 *
 * @param env the replacement environment
 */
- (void)setEnviron:(gchar**)env;

/**
 * Sets the flags on the launcher.
 * 
 * The default flags are %G_SUBPROCESS_FLAGS_NONE.
 * 
 * You may not set flags that specify conflicting options for how to
 * handle a particular stdio stream (eg: specifying both
 * %G_SUBPROCESS_FLAGS_STDIN_PIPE and
 * %G_SUBPROCESS_FLAGS_STDIN_INHERIT).
 * 
 * You may also not set a flag that conflicts with a previous call to a
 * function like g_subprocess_launcher_set_stdin_file_path() or
 * g_subprocess_launcher_take_stdout_fd().
 *
 * @param flags #GSubprocessFlags
 */
- (void)setFlags:(GSubprocessFlags)flags;

/**
 * Sets the file path to use as the stderr for spawned processes.
 * 
 * If @path is %NULL then any previously given path is unset.
 * 
 * The file will be created or truncated when the process is spawned, as
 * would be the case if using '2>' at the shell.
 * 
 * If you want to send both stdout and stderr to the same file then use
 * %G_SUBPROCESS_FLAGS_STDERR_MERGE.
 * 
 * You may not set a stderr file path if a stderr fd is already set or
 * if the launcher flags contain any flags directing stderr elsewhere.
 * 
 * This feature is only available on UNIX.
 *
 * @param path a filename or %NULL
 */
- (void)setStderrFilePath:(OFString*)path;

/**
 * Sets the file path to use as the stdin for spawned processes.
 * 
 * If @path is %NULL then any previously given path is unset.
 * 
 * The file must exist or spawning the process will fail.
 * 
 * You may not set a stdin file path if a stdin fd is already set or if
 * the launcher flags contain any flags directing stdin elsewhere.
 * 
 * This feature is only available on UNIX.
 *
 * @param path a filename or %NULL
 */
- (void)setStdinFilePath:(OFString*)path;

/**
 * Sets the file path to use as the stdout for spawned processes.
 * 
 * If @path is %NULL then any previously given path is unset.
 * 
 * The file will be created or truncated when the process is spawned, as
 * would be the case if using '>' at the shell.
 * 
 * You may not set a stdout file path if a stdout fd is already set or
 * if the launcher flags contain any flags directing stdout elsewhere.
 * 
 * This feature is only available on UNIX.
 *
 * @param path a filename or %NULL
 */
- (void)setStdoutFilePath:(OFString*)path;

/**
 * Sets the environment variable @variable in the environment of
 * processes launched from this launcher.
 * 
 * On UNIX, both the variable's name and value can be arbitrary byte
 * strings, except that the variable's name cannot contain '='.
 * On Windows, they should be in UTF-8.
 *
 * @param variable the environment variable to set,
 *     must not contain '='
 * @param value the new value for the variable
 * @param overwrite whether to change the variable if it already exists
 */
- (void)setenvWithVariable:(OFString*)variable value:(OFString*)value overwrite:(bool)overwrite;

/**
 * Creates a #GSubprocess given a provided array of arguments.
 *
 * @param argv Command line arguments
 * @return A new #GSubprocess, or %NULL on error (and @error will be set)
 */
- (OGSubprocess*)spawnvWithArgv:(const gchar* const*)argv;

/**
 * Transfer an arbitrary file descriptor from parent process to the
 * child.  This function takes ownership of the @source_fd; it will be closed
 * in the parent when @self is freed.
 * 
 * By default, all file descriptors from the parent will be closed.
 * This function allows you to create (for example) a custom `pipe()` or
 * `socketpair()` before launching the process, and choose the target
 * descriptor in the child.
 * 
 * An example use case is GNUPG, which has a command line argument
 * `--passphrase-fd` providing a file descriptor number where it expects
 * the passphrase to be written.
 *
 * @param sourceFd File descriptor in parent process
 * @param targetFd Target descriptor for child process
 */
- (void)takeFdWithSourceFd:(gint)sourceFd targetFd:(gint)targetFd;

/**
 * Sets the file descriptor to use as the stderr for spawned processes.
 * 
 * If @fd is -1 then any previously given fd is unset.
 * 
 * Note that the default behaviour is to pass stderr through to the
 * stderr of the parent process.
 * 
 * The passed @fd belongs to the #GSubprocessLauncher.  It will be
 * automatically closed when the launcher is finalized.  The file
 * descriptor will also be closed on the child side when executing the
 * spawned process.
 * 
 * You may not set a stderr fd if a stderr file path is already set or
 * if the launcher flags contain any flags directing stderr elsewhere.
 * 
 * This feature is only available on UNIX.
 *
 * @param fd a file descriptor, or -1
 */
- (void)takeStderrFd:(gint)fd;

/**
 * Sets the file descriptor to use as the stdin for spawned processes.
 * 
 * If @fd is -1 then any previously given fd is unset.
 * 
 * Note that if your intention is to have the stdin of the calling
 * process inherited by the child then %G_SUBPROCESS_FLAGS_STDIN_INHERIT
 * is a better way to go about doing that.
 * 
 * The passed @fd is noted but will not be touched in the current
 * process.  It is therefore necessary that it be kept open by the
 * caller until the subprocess is spawned.  The file descriptor will
 * also not be explicitly closed on the child side, so it must be marked
 * O_CLOEXEC if that's what you want.
 * 
 * You may not set a stdin fd if a stdin file path is already set or if
 * the launcher flags contain any flags directing stdin elsewhere.
 * 
 * This feature is only available on UNIX.
 *
 * @param fd a file descriptor, or -1
 */
- (void)takeStdinFd:(gint)fd;

/**
 * Sets the file descriptor to use as the stdout for spawned processes.
 * 
 * If @fd is -1 then any previously given fd is unset.
 * 
 * Note that the default behaviour is to pass stdout through to the
 * stdout of the parent process.
 * 
 * The passed @fd is noted but will not be touched in the current
 * process.  It is therefore necessary that it be kept open by the
 * caller until the subprocess is spawned.  The file descriptor will
 * also not be explicitly closed on the child side, so it must be marked
 * O_CLOEXEC if that's what you want.
 * 
 * You may not set a stdout fd if a stdout file path is already set or
 * if the launcher flags contain any flags directing stdout elsewhere.
 * 
 * This feature is only available on UNIX.
 *
 * @param fd a file descriptor, or -1
 */
- (void)takeStdoutFd:(gint)fd;

/**
 * Removes the environment variable @variable from the environment of
 * processes launched from this launcher.
 * 
 * On UNIX, the variable's name can be an arbitrary byte string not
 * containing '='. On Windows, it should be in UTF-8.
 *
 * @param variable the environment variable to unset,
 *     must not contain '='
 */
- (void)unsetenvWithVariable:(OFString*)variable;

@end