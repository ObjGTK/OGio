/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>

#import <OGObject/OGObject.h>

@class OGSocketAddress;
@class OGCancellable;

/**
 * `GSocketAddressEnumerator` is an enumerator type for
 * [class@Gio.SocketAddress] instances. It is returned by enumeration functions
 * such as [method@Gio.SocketConnectable.enumerate], which returns a
 * `GSocketAddressEnumerator` to list each [class@Gio.SocketAddress] which could
 * be used to connect to that [iface@Gio.SocketConnectable].
 * 
 * Enumeration is typically a blocking operation, so the asynchronous methods
 * [method@Gio.SocketAddressEnumerator.next_async] and
 * [method@Gio.SocketAddressEnumerator.next_finish] should be used where
 * possible.
 * 
 * Each `GSocketAddressEnumerator` can only be enumerated once. Once
 * [method@Gio.SocketAddressEnumerator.next] has returned `NULL`, further
 * enumeration with that `GSocketAddressEnumerator` is not possible, and it can
 * be unreffed.
 *
 */
@interface OGSocketAddressEnumerator : OGObject
{

}


/**
 * Methods
 */

- (GSocketAddressEnumerator*)castedGObject;

/**
 * Retrieves the next #GSocketAddress from @enumerator. Note that this
 * may block for some amount of time. (Eg, a #GNetworkAddress may need
 * to do a DNS lookup before it can return an address.) Use
 * g_socket_address_enumerator_next_async() if you need to avoid
 * blocking.
 * 
 * If @enumerator is expected to yield addresses, but for some reason
 * is unable to (eg, because of a DNS error), then the first call to
 * g_socket_address_enumerator_next() will return an appropriate error
 * in *@error. However, if the first call to
 * g_socket_address_enumerator_next() succeeds, then any further
 * internal errors (other than @cancellable being triggered) will be
 * ignored.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a #GSocketAddress (owned by the caller), or %NULL on
 *     error (in which case *@error will be set) or if there are no
 *     more addresses.
 */
- (OGSocketAddress*)next:(OGCancellable*)cancellable;

/**
 * Asynchronously retrieves the next #GSocketAddress from @enumerator
 * and then calls @callback, which must call
 * g_socket_address_enumerator_next_finish() to get the result.
 * 
 * It is an error to call this multiple times before the previous callback has finished.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback to call
 *   when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)nextAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Retrieves the result of a completed call to
 * g_socket_address_enumerator_next_async(). See
 * g_socket_address_enumerator_next() for more information about
 * error handling.
 *
 * @param result a #GAsyncResult
 * @return a #GSocketAddress (owned by the caller), or %NULL on
 *     error (in which case *@error will be set) or if there are no
 *     more addresses.
 */
- (OGSocketAddress*)nextFinish:(GAsyncResult*)result;

@end