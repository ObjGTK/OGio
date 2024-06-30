/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixoutputstream.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

@class OGCancellable;

/**
 * A #GPermission represents the status of the caller's permission to
 * perform a certain action.
 * 
 * You can query if the action is currently allowed and if it is
 * possible to acquire the permission so that the action will be allowed
 * in the future.
 * 
 * There is also an API to actually acquire the permission and one to
 * release it.
 * 
 * As an example, a #GPermission might represent the ability for the
 * user to write to a #GSettings object.  This #GPermission object could
 * then be used to decide if it is appropriate to show a "Click here to
 * unlock" button in a dialog and to provide the mechanism to invoke
 * when that button is clicked.
 *
 */
@interface OGPermission : OGObject
{

}


/**
 * Methods
 */

- (GPermission*)castedGObject;

/**
 * Attempts to acquire the permission represented by @permission.
 * 
 * The precise method by which this happens depends on the permission
 * and the underlying authentication mechanism.  A simple example is
 * that a dialog may appear asking the user to enter their password.
 * 
 * You should check with g_permission_get_can_acquire() before calling
 * this function.
 * 
 * If the permission is acquired then %TRUE is returned.  Otherwise,
 * %FALSE is returned and @error is set appropriately.
 * 
 * This call is blocking, likely for a very long time (in the case that
 * user interaction is required).  See g_permission_acquire_async() for
 * the non-blocking version.
 *
 * @param cancellable a #GCancellable, or %NULL
 * @return %TRUE if the permission was successfully acquired
 */
- (bool)acquire:(OGCancellable*)cancellable;

/**
 * Attempts to acquire the permission represented by @permission.
 * 
 * This is the first half of the asynchronous version of
 * g_permission_acquire().
 *
 * @param cancellable a #GCancellable, or %NULL
 * @param callback the #GAsyncReadyCallback to call when done
 * @param userData the user data to pass to @callback
 */
- (void)acquireAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Collects the result of attempting to acquire the permission
 * represented by @permission.
 * 
 * This is the second half of the asynchronous version of
 * g_permission_acquire().
 *
 * @param result the #GAsyncResult given to the #GAsyncReadyCallback
 * @return %TRUE if the permission was successfully acquired
 */
- (bool)acquireFinish:(GAsyncResult*)result;

/**
 * Gets the value of the 'allowed' property.  This property is %TRUE if
 * the caller currently has permission to perform the action that
 * @permission represents the permission to perform.
 *
 * @return the value of the 'allowed' property
 */
- (bool)allowed;

/**
 * Gets the value of the 'can-acquire' property.  This property is %TRUE
 * if it is generally possible to acquire the permission by calling
 * g_permission_acquire().
 *
 * @return the value of the 'can-acquire' property
 */
- (bool)canAcquire;

/**
 * Gets the value of the 'can-release' property.  This property is %TRUE
 * if it is generally possible to release the permission by calling
 * g_permission_release().
 *
 * @return the value of the 'can-release' property
 */
- (bool)canRelease;

/**
 * This function is called by the #GPermission implementation to update
 * the properties of the permission.  You should never call this
 * function except from a #GPermission implementation.
 * 
 * GObject notify signals are generated, as appropriate.
 *
 * @param allowed the new value for the 'allowed' property
 * @param canAcquire the new value for the 'can-acquire' property
 * @param canRelease the new value for the 'can-release' property
 */
- (void)implUpdateWithAllowed:(bool)allowed canAcquire:(bool)canAcquire canRelease:(bool)canRelease;

/**
 * Attempts to release the permission represented by @permission.
 * 
 * The precise method by which this happens depends on the permission
 * and the underlying authentication mechanism.  In most cases the
 * permission will be dropped immediately without further action.
 * 
 * You should check with g_permission_get_can_release() before calling
 * this function.
 * 
 * If the permission is released then %TRUE is returned.  Otherwise,
 * %FALSE is returned and @error is set appropriately.
 * 
 * This call is blocking, likely for a very long time (in the case that
 * user interaction is required).  See g_permission_release_async() for
 * the non-blocking version.
 *
 * @param cancellable a #GCancellable, or %NULL
 * @return %TRUE if the permission was successfully released
 */
- (bool)release:(OGCancellable*)cancellable;

/**
 * Attempts to release the permission represented by @permission.
 * 
 * This is the first half of the asynchronous version of
 * g_permission_release().
 *
 * @param cancellable a #GCancellable, or %NULL
 * @param callback the #GAsyncReadyCallback to call when done
 * @param userData the user data to pass to @callback
 */
- (void)releaseAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Collects the result of attempting to release the permission
 * represented by @permission.
 * 
 * This is the second half of the asynchronous version of
 * g_permission_release().
 *
 * @param result the #GAsyncResult given to the #GAsyncReadyCallback
 * @return %TRUE if the permission was successfully released
 */
- (bool)releaseFinish:(GAsyncResult*)result;

@end