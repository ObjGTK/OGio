/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

@class OGCancellable;
@class OGInputStream;
@class OGOutputStream;

/**
 * `GSubprocess` allows the creation of and interaction with child
 * processes.
 * 
 * Processes can be communicated with using standard GIO-style APIs (ie:
 * [class@Gio.InputStream], [class@Gio.OutputStream]). There are GIO-style APIs
 * to wait for process termination (ie: cancellable and with an asynchronous
 * variant).
 * 
 * There is an API to force a process to terminate, as well as a
 * race-free API for sending UNIX signals to a subprocess.
 * 
 * One major advantage that GIO brings over the core GLib library is
 * comprehensive API for asynchronous I/O, such
 * [method@Gio.OutputStream.splice_async].  This makes `GSubprocess`
 * significantly more powerful and flexible than equivalent APIs in
 * some other languages such as the `subprocess.py`
 * included with Python.  For example, using `GSubprocess` one could
 * create two child processes, reading standard output from the first,
 * processing it, and writing to the input stream of the second, all
 * without blocking the main loop.
 * 
 * A powerful [method@Gio.Subprocess.communicate] API is provided similar to the
 * `communicate()` method of `subprocess.py`. This enables very easy
 * interaction with a subprocess that has been opened with pipes.
 * 
 * `GSubprocess` defaults to tight control over the file descriptors open
 * in the child process, avoiding dangling-FD issues that are caused by
 * a simple `fork()`/`exec()`.  The only open file descriptors in the
 * spawned process are ones that were explicitly specified by the
 * `GSubprocess` API (unless `G_SUBPROCESS_FLAGS_INHERIT_FDS` was
 * specified).
 * 
 * `GSubprocess` will quickly reap all child processes as they exit,
 * avoiding ‘zombie processes’ remaining around for long periods of
 * time.  [method@Gio.Subprocess.wait] can be used to wait for this to happen,
 * but it will happen even without the call being explicitly made.
 * 
 * As a matter of principle, `GSubprocess` has no API that accepts
 * shell-style space-separated strings.  It will, however, match the
 * typical shell behaviour of searching the `PATH` for executables that do
 * not contain a directory separator in their name. By default, the `PATH`
 * of the current process is used.  You can specify
 * `G_SUBPROCESS_FLAGS_SEARCH_PATH_FROM_ENVP` to use the `PATH` of the
 * launcher environment instead.
 * 
 * `GSubprocess` attempts to have a very simple API for most uses (ie:
 * spawning a subprocess with arguments and support for most typical
 * kinds of input and output redirection).  See [ctor@Gio.Subprocess.new]. The
 * [class@Gio.SubprocessLauncher] API is provided for more complicated cases
 * (advanced types of redirection, environment variable manipulation,
 * change of working directory, child setup functions, etc).
 * 
 * A typical use of `GSubprocess` will involve calling
 * [ctor@Gio.Subprocess.new], followed by [method@Gio.Subprocess.wait_async] or
 * [method@Gio.Subprocess.wait].  After the process exits, the status can be
 * checked using functions such as [method@Gio.Subprocess.get_if_exited] (which
 * are similar to the familiar `WIFEXITED`-style POSIX macros).
 *
 */
@interface OGSubprocess : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)subprocessvWithArgv:(const gchar* const*)argv flags:(GSubprocessFlags)flags;

/**
 * Methods
 */

- (GSubprocess*)castedGObject;

/**
 * Communicate with the subprocess until it terminates, and all input
 * and output has been completed.
 * 
 * If @stdin_buf is given, the subprocess must have been created with
 * %G_SUBPROCESS_FLAGS_STDIN_PIPE.  The given data is fed to the
 * stdin of the subprocess and the pipe is closed (ie: EOF).
 * 
 * At the same time (as not to cause blocking when dealing with large
 * amounts of data), if %G_SUBPROCESS_FLAGS_STDOUT_PIPE or
 * %G_SUBPROCESS_FLAGS_STDERR_PIPE were used, reads from those
 * streams.  The data that was read is returned in @stdout and/or
 * the @stderr.
 * 
 * If the subprocess was created with %G_SUBPROCESS_FLAGS_STDOUT_PIPE,
 * @stdout_buf will contain the data read from stdout.  Otherwise, for
 * subprocesses not created with %G_SUBPROCESS_FLAGS_STDOUT_PIPE,
 * @stdout_buf will be set to %NULL.  Similar provisions apply to
 * @stderr_buf and %G_SUBPROCESS_FLAGS_STDERR_PIPE.
 * 
 * As usual, any output variable may be given as %NULL to ignore it.
 * 
 * If you desire the stdout and stderr data to be interleaved, create
 * the subprocess with %G_SUBPROCESS_FLAGS_STDOUT_PIPE and
 * %G_SUBPROCESS_FLAGS_STDERR_MERGE.  The merged result will be returned
 * in @stdout_buf and @stderr_buf will be set to %NULL.
 * 
 * In case of any error (including cancellation), %FALSE will be
 * returned with @error set.  Some or all of the stdin data may have
 * been written.  Any stdout or stderr data that has been read will be
 * discarded. None of the out variables (aside from @error) will have
 * been set to anything in particular and should not be inspected.
 * 
 * In the case that %TRUE is returned, the subprocess has exited and the
 * exit status inspection APIs (eg: g_subprocess_get_if_exited(),
 * g_subprocess_get_exit_status()) may be used.
 * 
 * You should not attempt to use any of the subprocess pipes after
 * starting this function, since they may be left in strange states,
 * even if the operation was cancelled.  You should especially not
 * attempt to interact with the pipes while the operation is in progress
 * (either from another thread or if using the asynchronous version).
 *
 * @param stdinBuf data to send to the stdin of the subprocess, or %NULL
 * @param cancellable a #GCancellable
 * @param stdoutBuf data read from the subprocess stdout
 * @param stderrBuf data read from the subprocess stderr
 * @return %TRUE if successful
 */
- (bool)communicateWithStdinBuf:(GBytes*)stdinBuf cancellable:(OGCancellable*)cancellable stdoutBuf:(GBytes**)stdoutBuf stderrBuf:(GBytes**)stderrBuf;

/**
 * Asynchronous version of g_subprocess_communicate().  Complete
 * invocation with g_subprocess_communicate_finish().
 *
 * @param stdinBuf Input data, or %NULL
 * @param cancellable Cancellable
 * @param callback Callback
 * @param userData User data
 */
- (void)communicateAsyncWithStdinBuf:(GBytes*)stdinBuf cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Complete an invocation of g_subprocess_communicate_async().
 *
 * @param result Result
 * @param stdoutBuf Return location for stdout data
 * @param stderrBuf Return location for stderr data
 * @return
 */
- (bool)communicateFinishWithResult:(GAsyncResult*)result stdoutBuf:(GBytes**)stdoutBuf stderrBuf:(GBytes**)stderrBuf;

/**
 * Like g_subprocess_communicate(), but validates the output of the
 * process as UTF-8, and returns it as a regular NUL terminated string.
 * 
 * On error, @stdout_buf and @stderr_buf will be set to undefined values and
 * should not be used.
 *
 * @param stdinBuf data to send to the stdin of the subprocess, or %NULL
 * @param cancellable a #GCancellable
 * @param stdoutBuf data read from the subprocess stdout
 * @param stderrBuf data read from the subprocess stderr
 * @return
 */
- (bool)communicateUtf8WithStdinBuf:(OFString*)stdinBuf cancellable:(OGCancellable*)cancellable stdoutBuf:(char**)stdoutBuf stderrBuf:(char**)stderrBuf;

/**
 * Asynchronous version of g_subprocess_communicate_utf8().  Complete
 * invocation with g_subprocess_communicate_utf8_finish().
 *
 * @param stdinBuf Input data, or %NULL
 * @param cancellable Cancellable
 * @param callback Callback
 * @param userData User data
 */
- (void)communicateUtf8AsyncWithStdinBuf:(OFString*)stdinBuf cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Complete an invocation of g_subprocess_communicate_utf8_async().
 *
 * @param result Result
 * @param stdoutBuf Return location for stdout data
 * @param stderrBuf Return location for stderr data
 * @return
 */
- (bool)communicateUtf8FinishWithResult:(GAsyncResult*)result stdoutBuf:(char**)stdoutBuf stderrBuf:(char**)stderrBuf;

/**
 * Use an operating-system specific method to attempt an immediate,
 * forceful termination of the process.  There is no mechanism to
 * determine whether or not the request itself was successful;
 * however, you can use g_subprocess_wait() to monitor the status of
 * the process after calling this function.
 * 
 * On Unix, this function sends %SIGKILL.
 *
 */
- (void)forceExit;

/**
 * Check the exit status of the subprocess, given that it exited
 * normally.  This is the value passed to the exit() system call or the
 * return value from main.
 * 
 * This is equivalent to the system WEXITSTATUS macro.
 * 
 * It is an error to call this function before g_subprocess_wait() and
 * unless g_subprocess_get_if_exited() returned %TRUE.
 *
 * @return the exit status
 */
- (gint)exitStatus;

/**
 * On UNIX, returns the process ID as a decimal string.
 * On Windows, returns the result of GetProcessId() also as a string.
 * If the subprocess has terminated, this will return %NULL.
 *
 * @return the subprocess identifier, or %NULL if the subprocess
 *    has terminated
 */
- (OFString*)identifier;

/**
 * Check if the given subprocess exited normally (ie: by way of exit()
 * or return from main()).
 * 
 * This is equivalent to the system WIFEXITED macro.
 * 
 * It is an error to call this function before g_subprocess_wait() has
 * returned.
 *
 * @return %TRUE if the case of a normal exit
 */
- (bool)ifExited;

/**
 * Check if the given subprocess terminated in response to a signal.
 * 
 * This is equivalent to the system WIFSIGNALED macro.
 * 
 * It is an error to call this function before g_subprocess_wait() has
 * returned.
 *
 * @return %TRUE if the case of termination due to a signal
 */
- (bool)ifSignaled;

/**
 * Gets the raw status code of the process, as from waitpid().
 * 
 * This value has no particular meaning, but it can be used with the
 * macros defined by the system headers such as WIFEXITED.  It can also
 * be used with g_spawn_check_wait_status().
 * 
 * It is more likely that you want to use g_subprocess_get_if_exited()
 * followed by g_subprocess_get_exit_status().
 * 
 * It is an error to call this function before g_subprocess_wait() has
 * returned.
 *
 * @return the (meaningless) waitpid() exit status from the kernel
 */
- (gint)status;

/**
 * Gets the #GInputStream from which to read the stderr output of
 * @subprocess.
 * 
 * The process must have been created with %G_SUBPROCESS_FLAGS_STDERR_PIPE,
 * otherwise %NULL will be returned.
 *
 * @return the stderr pipe
 */
- (OGInputStream*)stderrPipe;

/**
 * Gets the #GOutputStream that you can write to in order to give data
 * to the stdin of @subprocess.
 * 
 * The process must have been created with %G_SUBPROCESS_FLAGS_STDIN_PIPE and
 * not %G_SUBPROCESS_FLAGS_STDIN_INHERIT, otherwise %NULL will be returned.
 *
 * @return the stdout pipe
 */
- (OGOutputStream*)stdinPipe;

/**
 * Gets the #GInputStream from which to read the stdout output of
 * @subprocess.
 * 
 * The process must have been created with %G_SUBPROCESS_FLAGS_STDOUT_PIPE,
 * otherwise %NULL will be returned.
 *
 * @return the stdout pipe
 */
- (OGInputStream*)stdoutPipe;

/**
 * Checks if the process was "successful".  A process is considered
 * successful if it exited cleanly with an exit status of 0, either by
 * way of the exit() system call or return from main().
 * 
 * It is an error to call this function before g_subprocess_wait() has
 * returned.
 *
 * @return %TRUE if the process exited cleanly with a exit status of 0
 */
- (bool)successful;

/**
 * Get the signal number that caused the subprocess to terminate, given
 * that it terminated due to a signal.
 * 
 * This is equivalent to the system WTERMSIG macro.
 * 
 * It is an error to call this function before g_subprocess_wait() and
 * unless g_subprocess_get_if_signaled() returned %TRUE.
 *
 * @return the signal causing termination
 */
- (gint)termSig;

/**
 * Sends the UNIX signal @signal_num to the subprocess, if it is still
 * running.
 * 
 * This API is race-free.  If the subprocess has terminated, it will not
 * be signalled.
 * 
 * This API is not available on Windows.
 *
 * @param signalNum the signal number to send
 */
- (void)sendSignal:(gint)signalNum;

/**
 * Synchronously wait for the subprocess to terminate.
 * 
 * After the process terminates you can query its exit status with
 * functions such as g_subprocess_get_if_exited() and
 * g_subprocess_get_exit_status().
 * 
 * This function does not fail in the case of the subprocess having
 * abnormal termination.  See g_subprocess_wait_check() for that.
 * 
 * Cancelling @cancellable doesn't kill the subprocess.  Call
 * g_subprocess_force_exit() if it is desirable.
 *
 * @param cancellable a #GCancellable
 * @return %TRUE on success, %FALSE if @cancellable was cancelled
 */
- (bool)wait:(OGCancellable*)cancellable;

/**
 * Wait for the subprocess to terminate.
 * 
 * This is the asynchronous version of g_subprocess_wait().
 *
 * @param cancellable a #GCancellable, or %NULL
 * @param callback a #GAsyncReadyCallback to call when the operation is complete
 * @param userData user_data for @callback
 */
- (void)waitAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Combines g_subprocess_wait() with g_spawn_check_wait_status().
 *
 * @param cancellable a #GCancellable
 * @return %TRUE on success, %FALSE if process exited abnormally, or
 * @cancellable was cancelled
 */
- (bool)waitCheck:(OGCancellable*)cancellable;

/**
 * Combines g_subprocess_wait_async() with g_spawn_check_wait_status().
 * 
 * This is the asynchronous version of g_subprocess_wait_check().
 *
 * @param cancellable a #GCancellable, or %NULL
 * @param callback a #GAsyncReadyCallback to call when the operation is complete
 * @param userData user_data for @callback
 */
- (void)waitCheckAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Collects the result of a previous call to
 * g_subprocess_wait_check_async().
 *
 * @param result the #GAsyncResult passed to your #GAsyncReadyCallback
 * @return %TRUE if successful, or %FALSE with @error set
 */
- (bool)waitCheckFinish:(GAsyncResult*)result;

/**
 * Collects the result of a previous call to
 * g_subprocess_wait_async().
 *
 * @param result the #GAsyncResult passed to your #GAsyncReadyCallback
 * @return %TRUE if successful, or %FALSE with @error set
 */
- (bool)waitFinish:(GAsyncResult*)result;

@end