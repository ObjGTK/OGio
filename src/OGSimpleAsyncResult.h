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

@class OGCancellable;

/**
 * As of GLib 2.46, `GSimpleAsyncResult` is deprecated in favor of
 * [class@Gio.Task], which provides a simpler API.
 * 
 * `GSimpleAsyncResult` implements [iface@Gio.AsyncResult].
 * 
 * `GSimpleAsyncResult` handles [type@Gio.AsyncReadyCallback]s, error
 * reporting, operation cancellation and the final state of an operation,
 * completely transparent to the application. Results can be returned
 * as a pointer e.g. for functions that return data that is collected
 * asynchronously, a boolean value for checking the success or failure
 * of an operation, or a `gssize` for operations which return the number
 * of bytes modified by the operation; all of the simple return cases
 * are covered.
 * 
 * Most of the time, an application will not need to know of the details
 * of this API; it is handled transparently, and any necessary operations
 * are handled by [iface@Gio.AsyncResult]’s interface. However, if implementing
 * a new GIO module, for writing language bindings, or for complex
 * applications that need better control of how asynchronous operations
 * are completed, it is important to understand this functionality.
 * 
 * `GSimpleAsyncResult`s are tagged with the calling function to ensure
 * that asynchronous functions and their finishing functions are used
 * together correctly.
 * 
 * To create a new `GSimpleAsyncResult`, call [ctor@Gio.SimpleAsyncResult.new].
 * If the result needs to be created for a `GError`, use
 * [ctor@Gio.SimpleAsyncResult.new_from_error] or
 * [ctor@Gio.SimpleAsyncResult.new_take_error]. If a `GError` is not available
 * (e.g. the asynchronous operation doesn’t take a `GError` argument),
 * but the result still needs to be created for an error condition, use
 * [ctor@Gio.SimpleAsyncResult.new_error] (or
 * [method@Gio.SimpleAsyncResult.set_error_va] if your application or binding
 * requires passing a variable argument list directly), and the error can then
 * be propagated through the use of
 * [method@Gio.SimpleAsyncResult.propagate_error].
 * 
 * An asynchronous operation can be made to ignore a cancellation event by
 * calling [method@Gio.SimpleAsyncResult.set_handle_cancellation] with a
 * `GSimpleAsyncResult` for the operation and `FALSE`. This is useful for
 * operations that are dangerous to cancel, such as close (which would
 * cause a leak if cancelled before being run).
 * 
 * `GSimpleAsyncResult` can integrate into GLib’s event loop,
 * [type@GLib.MainLoop], or it can use [type@GLib.Thread]s.
 * [method@Gio.SimpleAsyncResult.complete] will finish an I/O task directly
 * from the point where it is called.
 * [method@Gio.SimpleAsyncResult.complete_in_idle] will finish it from an idle
 * handler in the  thread-default main context (see
 * [method@GLib.MainContext.push_thread_default]) where the `GSimpleAsyncResult`
 * was created. [method@Gio.SimpleAsyncResult.run_in_thread] will run the job in
 * a separate thread and then use
 * [method@Gio.SimpleAsyncResult.complete_in_idle] to deliver the result.
 * 
 * To set the results of an asynchronous function,
 * [method@Gio.SimpleAsyncResult.set_op_res_gpointer],
 * [method@Gio.SimpleAsyncResult.set_op_res_gboolean], and
 * [method@Gio.SimpleAsyncResult.set_op_res_gssize]
 * are provided, setting the operation's result to a `gpointer`, `gboolean`, or
 * `gssize`, respectively.
 * 
 * Likewise, to get the result of an asynchronous function,
 * [method@Gio.SimpleAsyncResult.get_op_res_gpointer],
 * [method@Gio.SimpleAsyncResult.get_op_res_gboolean], and
 * [method@Gio.SimpleAsyncResult.get_op_res_gssize] are
 * provided, getting the operation’s result as a `gpointer`, `gboolean`, and
 * `gssize`, respectively.
 * 
 * For the details of the requirements implementations must respect, see
 * [iface@Gio.AsyncResult].  A typical implementation of an asynchronous
 * operation using `GSimpleAsyncResult` looks something like this:
 * 
 * ```c
 * static void
 * baked_cb (Cake    *cake,
 *           gpointer user_data)
 * {
 *   // In this example, this callback is not given a reference to the cake,
 *   // so the GSimpleAsyncResult has to take a reference to it.
 *   GSimpleAsyncResult *result = user_data;
 * 
 *   if (cake == NULL)
 *     g_simple_async_result_set_error (result,
 *                                      BAKER_ERRORS,
 *                                      BAKER_ERROR_NO_FLOUR,
 *                                      "Go to the supermarket");
 *   else
 *     g_simple_async_result_set_op_res_gpointer (result,
 *                                                g_object_ref (cake),
 *                                                g_object_unref);
 * 
 * 
 *   // In this example, we assume that baked_cb is called as a callback from
 *   // the mainloop, so it's safe to complete the operation synchronously here.
 *   // If, however, _baker_prepare_cake () might call its callback without
 *   // first returning to the mainloop — inadvisable, but some APIs do so —
 *   // we would need to use g_simple_async_result_complete_in_idle().
 *   g_simple_async_result_complete (result);
 *   g_object_unref (result);
 * }
 * 
 * void
 * baker_bake_cake_async (Baker              *self,
 *                        guint               radius,
 *                        GAsyncReadyCallback callback,
 *                        gpointer            user_data)
 * {
 *   GSimpleAsyncResult *simple;
 *   Cake               *cake;
 * 
 *   if (radius < 3)
 *     {
 *       g_simple_async_report_error_in_idle (G_OBJECT (self),
 *                                            callback,
 *                                            user_data,
 *                                            BAKER_ERRORS,
 *                                            BAKER_ERROR_TOO_SMALL,
 *                                            "%ucm radius cakes are silly",
 *                                            radius);
 *       return;
 *     }
 * 
 *   simple = g_simple_async_result_new (G_OBJECT (self),
 *                                       callback,
 *                                       user_data,
 *                                       baker_bake_cake_async);
 *   cake = _baker_get_cached_cake (self, radius);
 * 
 *   if (cake != NULL)
 *     {
 *       g_simple_async_result_set_op_res_gpointer (simple,
 *                                                  g_object_ref (cake),
 *                                                  g_object_unref);
 *       g_simple_async_result_complete_in_idle (simple);
 *       g_object_unref (simple);
 *       // Drop the reference returned by _baker_get_cached_cake();
 *       // the GSimpleAsyncResult has taken its own reference.
 *       g_object_unref (cake);
 *       return;
 *     }
 * 
 *   _baker_prepare_cake (self, radius, baked_cb, simple);
 * }
 * 
 * Cake *
 * baker_bake_cake_finish (Baker        *self,
 *                         GAsyncResult *result,
 *                         GError      **error)
 * {
 *   GSimpleAsyncResult *simple;
 *   Cake               *cake;
 * 
 *   g_return_val_if_fail (g_simple_async_result_is_valid (result,
 *                                                         G_OBJECT (self),
 *                                                         baker_bake_cake_async),
 *                         NULL);
 * 
 *   simple = (GSimpleAsyncResult *) result;
 * 
 *   if (g_simple_async_result_propagate_error (simple, error))
 *     return NULL;
 * 
 *   cake = CAKE (g_simple_async_result_get_op_res_gpointer (simple));
 *   return g_object_ref (cake);
 * }
 * ```
 *
 */
@interface OGSimpleAsyncResult : OGObject
{

}

/**
 * Functions
 */
+ (void)load;


/**
 * Use #GTask and g_task_is_valid() instead.
 *
 * @param result the #GAsyncResult passed to the _finish function.
 * @param source the #GObject passed to the _finish function.
 * @param sourceTag the asynchronous function.
 * @return #TRUE if all checks passed or #FALSE if any failed.
 */
+ (bool)isValidWithResult:(GAsyncResult*)result source:(OGObject*)source sourceTag:(gpointer)sourceTag;

/**
 * Constructors
 */
+ (instancetype)simpleAsyncResultWithSourceObject:(OGObject*)sourceObject callback:(GAsyncReadyCallback)callback userData:(gpointer)userData sourceTag:(gpointer)sourceTag;
+ (instancetype)simpleAsyncResultFromErrorWithSourceObject:(OGObject*)sourceObject callback:(GAsyncReadyCallback)callback userData:(gpointer)userData error:(const GError*)error;
+ (instancetype)simpleAsyncResultTakeErrorWithSourceObject:(OGObject*)sourceObject callback:(GAsyncReadyCallback)callback userData:(gpointer)userData error:(GError*)error;

/**
 * Methods
 */

- (GSimpleAsyncResult*)castedGObject;

/**
 * Completes an asynchronous I/O job immediately. Must be called in
 * the thread where the asynchronous result was to be delivered, as it
 * invokes the callback directly. If you are in a different thread use
 * g_simple_async_result_complete_in_idle().
 * 
 * Calling this function takes a reference to @simple for as long as
 * is needed to complete the call.
 *
 */
- (void)complete;

/**
 * Completes an asynchronous function in an idle handler in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread that @simple was initially created in
 * (and re-pushes that context around the invocation of the callback).
 * 
 * Calling this function takes a reference to @simple for as long as
 * is needed to complete the call.
 *
 */
- (void)completeInIdle;

/**
 * Gets the operation result boolean from within the asynchronous result.
 *
 * @return %TRUE if the operation's result was %TRUE, %FALSE
 *     if the operation's result was %FALSE.
 */
- (bool)opResGboolean;

/**
 * Gets a pointer result as returned by the asynchronous function.
 *
 * @return a pointer from the result.
 */
- (gpointer)opResGpointer;

/**
 * Gets a gssize from the asynchronous result.
 *
 * @return a gssize returned from the asynchronous function.
 */
- (gssize)opResGssize;

/**
 * Gets the source tag for the #GSimpleAsyncResult.
 *
 * @return a #gpointer to the source object for the #GSimpleAsyncResult.
 */
- (gpointer)sourceTag;

/**
 * Propagates an error from within the simple asynchronous result to
 * a given destination.
 * 
 * If the #GCancellable given to a prior call to
 * g_simple_async_result_set_check_cancellable() is cancelled then this
 * function will return %TRUE with @dest set appropriately.
 *
 * @return %TRUE if the error was propagated to @dest. %FALSE otherwise.
 */
- (bool)propagateError;

/**
 * Runs the asynchronous job in a separate thread and then calls
 * g_simple_async_result_complete_in_idle() on @simple to return
 * the result to the appropriate main loop.
 * 
 * Calling this function takes a reference to @simple for as long as
 * is needed to run the job and report its completion.
 *
 * @param func a #GSimpleAsyncThreadFunc.
 * @param ioPriority the io priority of the request.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 */
- (void)runInThreadWithFunc:(GSimpleAsyncThreadFunc)func ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable;

/**
 * Sets a #GCancellable to check before dispatching results.
 * 
 * This function has one very specific purpose: the provided cancellable
 * is checked at the time of g_simple_async_result_propagate_error() If
 * it is cancelled, these functions will return an "Operation was
 * cancelled" error (%G_IO_ERROR_CANCELLED).
 * 
 * Implementors of cancellable asynchronous functions should use this in
 * order to provide a guarantee to their callers that cancelling an
 * async operation will reliably result in an error being returned for
 * that operation (even if a positive result for the operation has
 * already been sent as an idle to the main context to be dispatched).
 * 
 * The checking described above is done regardless of any call to the
 * unrelated g_simple_async_result_set_handle_cancellation() function.
 *
 * @param checkCancellable a #GCancellable to check, or %NULL to unset
 */
- (void)setCheckCancellable:(OGCancellable*)checkCancellable;

/**
 * Sets an error within the asynchronous result without a #GError.
 * Unless writing a binding, see g_simple_async_result_set_error().
 *
 * @param domain a #GQuark (usually %G_IO_ERROR).
 * @param code an error code.
 * @param format a formatted error reporting string.
 * @param args va_list of arguments.
 */
- (void)setErrorVaWithDomain:(GQuark)domain code:(gint)code format:(OFString*)format args:(va_list)args;

/**
 * Sets the result from a #GError.
 *
 * @param error #GError.
 */
- (void)setFromError:(const GError*)error;

/**
 * Sets whether to handle cancellation within the asynchronous operation.
 * 
 * This function has nothing to do with
 * g_simple_async_result_set_check_cancellable().  It only refers to the
 * #GCancellable passed to g_simple_async_result_run_in_thread().
 *
 * @param handleCancellation a #gboolean.
 */
- (void)setHandleCancellation:(bool)handleCancellation;

/**
 * Sets the operation result to a boolean within the asynchronous result.
 *
 * @param opRes a #gboolean.
 */
- (void)setOpResGboolean:(bool)opRes;

/**
 * Sets the operation result within the asynchronous result to a pointer.
 *
 * @param opRes a pointer result from an asynchronous function.
 * @param destroyOpRes a #GDestroyNotify function.
 */
- (void)setOpResGpointerWithOpRes:(gpointer)opRes destroyOpRes:(GDestroyNotify)destroyOpRes;

/**
 * Sets the operation result within the asynchronous result to
 * the given @op_res.
 *
 * @param opRes a #gssize.
 */
- (void)setOpResGssize:(gssize)opRes;

/**
 * Sets the result from @error, and takes over the caller's ownership
 * of @error, so the caller does not need to free it any more.
 *
 * @param error a #GError
 */
- (void)takeError:(GError*)error;

@end