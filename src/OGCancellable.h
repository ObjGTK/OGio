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
 * `GCancellable` allows operations to be cancelled.
 * 
 * `GCancellable` is a thread-safe operation cancellation stack used
 * throughout GIO to allow for cancellation of synchronous and
 * asynchronous operations.
 *
 */
@interface OGCancellable : OGObject
{

}

/**
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Gets the top cancellable from the stack.
 *
 * @return a #GCancellable from the top
 * of the stack, or %NULL if the stack is empty.
 */
+ (OGCancellable*)current;

/**
 * Constructors
 */
+ (instancetype)cancellable;

/**
 * Methods
 */

- (GCancellable*)castedGObject;

/**
 * Will set @cancellable to cancelled, and will emit the
 * #GCancellable::cancelled signal. (However, see the warning about
 * race conditions in the documentation for that signal if you are
 * planning to connect to it.)
 * 
 * This function is thread-safe. In other words, you can safely call
 * it from a thread other than the one running the operation that was
 * passed the @cancellable.
 * 
 * If @cancellable is %NULL, this function returns immediately for convenience.
 * 
 * The convention within GIO is that cancelling an asynchronous
 * operation causes it to complete asynchronously. That is, if you
 * cancel the operation from the same thread in which it is running,
 * then the operation's #GAsyncReadyCallback will not be invoked until
 * the application returns to the main loop.
 *
 */
- (void)cancel;

/**
 * Convenience function to connect to the #GCancellable::cancelled
 * signal. Also handles the race condition that may happen
 * if the cancellable is cancelled right before connecting.
 * 
 * @callback is called at most once, either directly at the
 * time of the connect if @cancellable is already cancelled,
 * or when @cancellable is cancelled in some thread.
 * 
 * @data_destroy_func will be called when the handler is
 * disconnected, or immediately if the cancellable is already
 * cancelled.
 * 
 * See #GCancellable::cancelled for details on how to use this.
 * 
 * Since GLib 2.40, the lock protecting @cancellable is not held when
 * @callback is invoked.  This lifts a restriction in place for
 * earlier GLib versions which now makes it easier to write cleanup
 * code that unconditionally invokes e.g. g_cancellable_cancel().
 *
 * @param callback The #GCallback to connect.
 * @param data Data to pass to @callback.
 * @param dataDestroyFunc Free function for @data or %NULL.
 * @return The id of the signal handler or 0 if @cancellable has already
 *          been cancelled.
 */
- (gulong)connectWithCallback:(GCallback)callback data:(gpointer)data dataDestroyFunc:(GDestroyNotify)dataDestroyFunc;

/**
 * Disconnects a handler from a cancellable instance similar to
 * g_signal_handler_disconnect().  Additionally, in the event that a
 * signal handler is currently running, this call will block until the
 * handler has finished.  Calling this function from a
 * #GCancellable::cancelled signal handler will therefore result in a
 * deadlock.
 * 
 * This avoids a race condition where a thread cancels at the
 * same time as the cancellable operation is finished and the
 * signal handler is removed. See #GCancellable::cancelled for
 * details on how to use this.
 * 
 * If @cancellable is %NULL or @handler_id is `0` this function does
 * nothing.
 *
 * @param handlerId Handler id of the handler to be disconnected, or `0`.
 */
- (void)disconnectWithHandlerId:(gulong)handlerId;

/**
 * Gets the file descriptor for a cancellable job. This can be used to
 * implement cancellable operations on Unix systems. The returned fd will
 * turn readable when @cancellable is cancelled.
 * 
 * You are not supposed to read from the fd yourself, just check for
 * readable status. Reading to unset the readable status is done
 * with g_cancellable_reset().
 * 
 * After a successful return from this function, you should use
 * g_cancellable_release_fd() to free up resources allocated for
 * the returned file descriptor.
 * 
 * See also g_cancellable_make_pollfd().
 *
 * @return A valid file descriptor. `-1` if the file descriptor
 * is not supported, or on errors.
 */
- (int)fd;

/**
 * Checks if a cancellable job has been cancelled.
 *
 * @return %TRUE if @cancellable is cancelled,
 * FALSE if called with %NULL or if item is not cancelled.
 */
- (bool)isCancelled;

/**
 * Creates a #GPollFD corresponding to @cancellable; this can be passed
 * to g_poll() and used to poll for cancellation. This is useful both
 * for unix systems without a native poll and for portability to
 * windows.
 * 
 * When this function returns %TRUE, you should use
 * g_cancellable_release_fd() to free up resources allocated for the
 * @pollfd. After a %FALSE return, do not call g_cancellable_release_fd().
 * 
 * If this function returns %FALSE, either no @cancellable was given or
 * resource limits prevent this function from allocating the necessary
 * structures for polling. (On Linux, you will likely have reached
 * the maximum number of file descriptors.) The suggested way to handle
 * these cases is to ignore the @cancellable.
 * 
 * You are not supposed to read from the fd yourself, just check for
 * readable status. Reading to unset the readable status is done
 * with g_cancellable_reset().
 *
 * @param pollfd a pointer to a #GPollFD
 * @return %TRUE if @pollfd was successfully initialized, %FALSE on
 *          failure to prepare the cancellable.
 */
- (bool)makePollfd:(GPollFD*)pollfd;

/**
 * Pops @cancellable off the cancellable stack (verifying that @cancellable
 * is on the top of the stack).
 *
 */
- (void)popCurrent;

/**
 * Pushes @cancellable onto the cancellable stack. The current
 * cancellable can then be received using g_cancellable_get_current().
 * 
 * This is useful when implementing cancellable operations in
 * code that does not allow you to pass down the cancellable object.
 * 
 * This is typically called automatically by e.g. #GFile operations,
 * so you rarely have to call this yourself.
 *
 */
- (void)pushCurrent;

/**
 * Releases a resources previously allocated by g_cancellable_get_fd()
 * or g_cancellable_make_pollfd().
 * 
 * For compatibility reasons with older releases, calling this function
 * is not strictly required, the resources will be automatically freed
 * when the @cancellable is finalized. However, the @cancellable will
 * block scarce file descriptors until it is finalized if this function
 * is not called. This can cause the application to run out of file
 * descriptors when many #GCancellables are used at the same time.
 *
 */
- (void)releaseFd;

/**
 * Resets @cancellable to its uncancelled state.
 * 
 * If cancellable is currently in use by any cancellable operation
 * then the behavior of this function is undefined.
 * 
 * Note that it is generally not a good idea to reuse an existing
 * cancellable for more operations after it has been cancelled once,
 * as this function might tempt you to do. The recommended practice
 * is to drop the reference to a cancellable after cancelling it,
 * and let it die with the outstanding async operations. You should
 * create a fresh cancellable for further async operations.
 *
 */
- (void)reset;

/**
 * If the @cancellable is cancelled, sets the error to notify
 * that the operation was cancelled.
 *
 * @return %TRUE if @cancellable was cancelled, %FALSE if it was not
 */
- (bool)setErrorIfCancelled;

/**
 * Creates a source that triggers if @cancellable is cancelled and
 * calls its callback of type #GCancellableSourceFunc. This is
 * primarily useful for attaching to another (non-cancellable) source
 * with g_source_add_child_source() to add cancellability to it.
 * 
 * For convenience, you can call this with a %NULL #GCancellable,
 * in which case the source will never trigger.
 * 
 * The new #GSource will hold a reference to the #GCancellable.
 *
 * @return the new #GSource.
 */
- (GSource*)sourceNew;

@end