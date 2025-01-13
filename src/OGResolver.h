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

@class OGCancellable;
@class OGInetAddress;

/**
 * The object that handles DNS resolution. Use [func@Gio.Resolver.get_default]
 * to get the default resolver.
 * 
 * `GResolver` provides cancellable synchronous and asynchronous DNS
 * resolution, for hostnames ([method@Gio.Resolver.lookup_by_address],
 * [method@Gio.Resolver.lookup_by_name] and their async variants) and SRV
 * (service) records ([method@Gio.Resolver.lookup_service]).
 * 
 * [class@Gio.NetworkAddress] and [class@Gio.NetworkService] provide wrappers
 * around `GResolver` functionality that also implement
 * [iface@Gio.SocketConnectable], making it easy to connect to a remote
 * host/service.
 * 
 * The default resolver (see [func@Gio.Resolver.get_default]) has a timeout of
 * 30s set on it since GLib 2.78. Earlier versions of GLib did not support
 * resolver timeouts.
 * 
 * This is an abstract type; subclasses of it implement different resolvers for
 * different platforms and situations.
 *
 */
@interface OGResolver : OGObject
{

}

/**
 * Functions
 */
+ (void)load;


/**
 * Frees @addresses (which should be the return value from
 * g_resolver_lookup_by_name() or g_resolver_lookup_by_name_finish()).
 * (This is a convenience method; you can also simply free the results
 * by hand.)
 *
 * @param addresses a #GList of #GInetAddress
 */
+ (void)freeAddresses:(GList*)addresses;

/**
 * Frees @targets (which should be the return value from
 * g_resolver_lookup_service() or g_resolver_lookup_service_finish()).
 * (This is a convenience method; you can also simply free the
 * results by hand.)
 *
 * @param targets a #GList of #GSrvTarget
 */
+ (void)freeTargets:(GList*)targets;

/**
 * Gets the default #GResolver. You should unref it when you are done
 * with it. #GResolver may use its reference count as a hint about how
 * many threads it should allocate for concurrent DNS resolutions.
 *
 * @return the default #GResolver.
 */
+ (OGResolver*)default;

/**
 * Methods
 */

- (GResolver*)castedGObject;

/**
 * Get the timeout applied to all resolver lookups. See #GResolver:timeout.
 *
 * @return the resolver timeout, in milliseconds, or `0` for no timeout
 */
- (unsigned)timeout;

/**
 * Synchronously reverse-resolves @address to determine its
 * associated hostname.
 * 
 * If the DNS resolution fails, @error (if non-%NULL) will be set to
 * a value from #GResolverError.
 * 
 * If @cancellable is non-%NULL, it can be used to cancel the
 * operation, in which case @error (if non-%NULL) will be set to
 * %G_IO_ERROR_CANCELLED.
 *
 * @param address the address to reverse-resolve
 * @param cancellable a #GCancellable, or %NULL
 * @return a hostname (either ASCII-only, or in ASCII-encoded
 *     form), or %NULL on error.
 */
- (OFString*)lookupByAddress:(OGInetAddress*)address cancellable:(OGCancellable*)cancellable;

/**
 * Begins asynchronously reverse-resolving @address to determine its
 * associated hostname, and eventually calls @callback, which must
 * call g_resolver_lookup_by_address_finish() to get the final result.
 *
 * @param address the address to reverse-resolve
 * @param cancellable a #GCancellable, or %NULL
 * @param callback callback to call after resolution completes
 * @param userData data for @callback
 */
- (void)lookupByAddressAsync:(OGInetAddress*)address cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Retrieves the result of a previous call to
 * g_resolver_lookup_by_address_async().
 * 
 * If the DNS resolution failed, @error (if non-%NULL) will be set to
 * a value from #GResolverError. If the operation was cancelled,
 * @error will be set to %G_IO_ERROR_CANCELLED.
 *
 * @param result the result passed to your #GAsyncReadyCallback
 * @return a hostname (either ASCII-only, or in ASCII-encoded
 * form), or %NULL on error.
 */
- (OFString*)lookupByAddressFinishWithResult:(GAsyncResult*)result;

/**
 * Synchronously resolves @hostname to determine its associated IP
 * address(es). @hostname may be an ASCII-only or UTF-8 hostname, or
 * the textual form of an IP address (in which case this just becomes
 * a wrapper around g_inet_address_new_from_string()).
 * 
 * On success, g_resolver_lookup_by_name() will return a non-empty #GList of
 * #GInetAddress, sorted in order of preference and guaranteed to not
 * contain duplicates. That is, if using the result to connect to
 * @hostname, you should attempt to connect to the first address
 * first, then the second if the first fails, etc. If you are using
 * the result to listen on a socket, it is appropriate to add each
 * result using e.g. g_socket_listener_add_address().
 * 
 * If the DNS resolution fails, @error (if non-%NULL) will be set to a
 * value from #GResolverError and %NULL will be returned.
 * 
 * If @cancellable is non-%NULL, it can be used to cancel the
 * operation, in which case @error (if non-%NULL) will be set to
 * %G_IO_ERROR_CANCELLED.
 * 
 * If you are planning to connect to a socket on the resolved IP
 * address, it may be easier to create a #GNetworkAddress and use its
 * #GSocketConnectable interface.
 *
 * @param hostname the hostname to look up
 * @param cancellable a #GCancellable, or %NULL
 * @return a non-empty #GList
 * of #GInetAddress, or %NULL on error. You
 * must unref each of the addresses and free the list when you are
 * done with it. (You can use g_resolver_free_addresses() to do this.)
 */
- (GList*)lookupByNameWithHostname:(OFString*)hostname cancellable:(OGCancellable*)cancellable;

/**
 * Begins asynchronously resolving @hostname to determine its
 * associated IP address(es), and eventually calls @callback, which
 * must call g_resolver_lookup_by_name_finish() to get the result.
 * See g_resolver_lookup_by_name() for more details.
 *
 * @param hostname the hostname to look up the address of
 * @param cancellable a #GCancellable, or %NULL
 * @param callback callback to call after resolution completes
 * @param userData data for @callback
 */
- (void)lookupByNameAsyncWithHostname:(OFString*)hostname cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Retrieves the result of a call to
 * g_resolver_lookup_by_name_async().
 * 
 * If the DNS resolution failed, @error (if non-%NULL) will be set to
 * a value from #GResolverError. If the operation was cancelled,
 * @error will be set to %G_IO_ERROR_CANCELLED.
 *
 * @param result the result passed to your #GAsyncReadyCallback
 * @return a #GList
 * of #GInetAddress, or %NULL on error. See g_resolver_lookup_by_name()
 * for more details.
 */
- (GList*)lookupByNameFinishWithResult:(GAsyncResult*)result;

/**
 * This differs from g_resolver_lookup_by_name() in that you can modify
 * the lookup behavior with @flags. For example this can be used to limit
 * results with %G_RESOLVER_NAME_LOOKUP_FLAGS_IPV4_ONLY.
 *
 * @param hostname the hostname to look up
 * @param flags extra #GResolverNameLookupFlags for the lookup
 * @param cancellable a #GCancellable, or %NULL
 * @return a non-empty #GList
 * of #GInetAddress, or %NULL on error. You
 * must unref each of the addresses and free the list when you are
 * done with it. (You can use g_resolver_free_addresses() to do this.)
 */
- (GList*)lookupByNameWithFlagsWithHostname:(OFString*)hostname flags:(GResolverNameLookupFlags)flags cancellable:(OGCancellable*)cancellable;

/**
 * Begins asynchronously resolving @hostname to determine its
 * associated IP address(es), and eventually calls @callback, which
 * must call g_resolver_lookup_by_name_with_flags_finish() to get the result.
 * See g_resolver_lookup_by_name() for more details.
 *
 * @param hostname the hostname to look up the address of
 * @param flags extra #GResolverNameLookupFlags for the lookup
 * @param cancellable a #GCancellable, or %NULL
 * @param callback callback to call after resolution completes
 * @param userData data for @callback
 */
- (void)lookupByNameWithFlagsAsyncWithHostname:(OFString*)hostname flags:(GResolverNameLookupFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Retrieves the result of a call to
 * g_resolver_lookup_by_name_with_flags_async().
 * 
 * If the DNS resolution failed, @error (if non-%NULL) will be set to
 * a value from #GResolverError. If the operation was cancelled,
 * @error will be set to %G_IO_ERROR_CANCELLED.
 *
 * @param result the result passed to your #GAsyncReadyCallback
 * @return a #GList
 * of #GInetAddress, or %NULL on error. See g_resolver_lookup_by_name()
 * for more details.
 */
- (GList*)lookupByNameWithFlagsFinishWithResult:(GAsyncResult*)result;

/**
 * Synchronously performs a DNS record lookup for the given @rrname and returns
 * a list of records as #GVariant tuples. See #GResolverRecordType for
 * information on what the records contain for each @record_type.
 * 
 * If the DNS resolution fails, @error (if non-%NULL) will be set to
 * a value from #GResolverError and %NULL will be returned.
 * 
 * If @cancellable is non-%NULL, it can be used to cancel the
 * operation, in which case @error (if non-%NULL) will be set to
 * %G_IO_ERROR_CANCELLED.
 *
 * @param rrname the DNS name to look up the record for
 * @param recordType the type of DNS record to look up
 * @param cancellable a #GCancellable, or %NULL
 * @return a non-empty #GList of
 * #GVariant, or %NULL on error. You must free each of the records and the list
 * when you are done with it. (You can use g_list_free_full() with
 * g_variant_unref() to do this.)
 */
- (GList*)lookupRecordsWithRrname:(OFString*)rrname recordType:(GResolverRecordType)recordType cancellable:(OGCancellable*)cancellable;

/**
 * Begins asynchronously performing a DNS lookup for the given
 * @rrname, and eventually calls @callback, which must call
 * g_resolver_lookup_records_finish() to get the final result. See
 * g_resolver_lookup_records() for more details.
 *
 * @param rrname the DNS name to look up the record for
 * @param recordType the type of DNS record to look up
 * @param cancellable a #GCancellable, or %NULL
 * @param callback callback to call after resolution completes
 * @param userData data for @callback
 */
- (void)lookupRecordsAsyncWithRrname:(OFString*)rrname recordType:(GResolverRecordType)recordType cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Retrieves the result of a previous call to
 * g_resolver_lookup_records_async(). Returns a non-empty list of records as
 * #GVariant tuples. See #GResolverRecordType for information on what the
 * records contain.
 * 
 * If the DNS resolution failed, @error (if non-%NULL) will be set to
 * a value from #GResolverError. If the operation was cancelled,
 * @error will be set to %G_IO_ERROR_CANCELLED.
 *
 * @param result the result passed to your #GAsyncReadyCallback
 * @return a non-empty #GList of
 * #GVariant, or %NULL on error. You must free each of the records and the list
 * when you are done with it. (You can use g_list_free_full() with
 * g_variant_unref() to do this.)
 */
- (GList*)lookupRecordsFinishWithResult:(GAsyncResult*)result;

/**
 * Synchronously performs a DNS SRV lookup for the given @service and
 * @protocol in the given @domain and returns an array of #GSrvTarget.
 * @domain may be an ASCII-only or UTF-8 hostname. Note also that the
 * @service and @protocol arguments do not include the leading underscore
 * that appears in the actual DNS entry.
 * 
 * On success, g_resolver_lookup_service() will return a non-empty #GList of
 * #GSrvTarget, sorted in order of preference. (That is, you should
 * attempt to connect to the first target first, then the second if
 * the first fails, etc.)
 * 
 * If the DNS resolution fails, @error (if non-%NULL) will be set to
 * a value from #GResolverError and %NULL will be returned.
 * 
 * If @cancellable is non-%NULL, it can be used to cancel the
 * operation, in which case @error (if non-%NULL) will be set to
 * %G_IO_ERROR_CANCELLED.
 * 
 * If you are planning to connect to the service, it is usually easier
 * to create a #GNetworkService and use its #GSocketConnectable
 * interface.
 *
 * @param service the service type to look up (eg, "ldap")
 * @param protocol the networking protocol to use for @service (eg, "tcp")
 * @param domain the DNS domain to look up the service in
 * @param cancellable a #GCancellable, or %NULL
 * @return a non-empty #GList of
 * #GSrvTarget, or %NULL on error. You must free each of the targets and the
 * list when you are done with it. (You can use g_resolver_free_targets() to do
 * this.)
 */
- (GList*)lookupService:(OFString*)service protocol:(OFString*)protocol domain:(OFString*)domain cancellable:(OGCancellable*)cancellable;

/**
 * Begins asynchronously performing a DNS SRV lookup for the given
 * @service and @protocol in the given @domain, and eventually calls
 * @callback, which must call g_resolver_lookup_service_finish() to
 * get the final result. See g_resolver_lookup_service() for more
 * details.
 *
 * @param service the service type to look up (eg, "ldap")
 * @param protocol the networking protocol to use for @service (eg, "tcp")
 * @param domain the DNS domain to look up the service in
 * @param cancellable a #GCancellable, or %NULL
 * @param callback callback to call after resolution completes
 * @param userData data for @callback
 */
- (void)lookupServiceAsync:(OFString*)service protocol:(OFString*)protocol domain:(OFString*)domain cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Retrieves the result of a previous call to
 * g_resolver_lookup_service_async().
 * 
 * If the DNS resolution failed, @error (if non-%NULL) will be set to
 * a value from #GResolverError. If the operation was cancelled,
 * @error will be set to %G_IO_ERROR_CANCELLED.
 *
 * @param result the result passed to your #GAsyncReadyCallback
 * @return a non-empty #GList of
 * #GSrvTarget, or %NULL on error. See g_resolver_lookup_service() for more
 * details.
 */
- (GList*)lookupServiceFinishWithResult:(GAsyncResult*)result;

/**
 * Sets @resolver to be the application's default resolver (reffing
 * @resolver, and unreffing the previous default resolver, if any).
 * Future calls to g_resolver_get_default() will return this resolver.
 * 
 * This can be used if an application wants to perform any sort of DNS
 * caching or "pinning"; it can implement its own #GResolver that
 * calls the original default resolver for DNS operations, and
 * implements its own cache policies on top of that, and then set
 * itself as the default resolver for all later code to use.
 *
 */
- (void)setDefault;

/**
 * Set the timeout applied to all resolver lookups. See #GResolver:timeout.
 *
 * @param timeoutMs timeout in milliseconds, or `0` for no timeouts
 */
- (void)setTimeoutWithTimeoutMs:(unsigned)timeoutMs;

@end