/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGResolver.h"

#import "OGInetAddress.h"
#import "OGCancellable.h"

@implementation OGResolver

+ (void)freeAddresses:(GList*)addresses
{
	g_resolver_free_addresses(addresses);
}

+ (void)freeTargets:(GList*)targets
{
	g_resolver_free_targets(targets);
}

+ (OGResolver*)default
{
	GResolver* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_resolver_get_default(), GResolver, GResolver);

	OGResolver* returnValue = [OGResolver withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GResolver*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GResolver, GResolver);
}

- (unsigned)timeout
{
	unsigned returnValue = g_resolver_get_timeout([self castedGObject]);

	return returnValue;
}

- (OFString*)lookupByAddressWithAddress:(OGInetAddress*)address cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gchar* gobjectValue = g_resolver_lookup_by_address([self castedGObject], [address castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (void)lookupByAddressAsyncWithAddress:(OGInetAddress*)address cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_resolver_lookup_by_address_async([self castedGObject], [address castedGObject], [cancellable castedGObject], callback, userData);
}

- (OFString*)lookupByAddressFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	gchar* gobjectValue = g_resolver_lookup_by_address_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (GList*)lookupByNameWithHostname:(OFString*)hostname cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GList* returnValue = g_resolver_lookup_by_name([self castedGObject], [hostname UTF8String], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)lookupByNameAsyncWithHostname:(OFString*)hostname cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_resolver_lookup_by_name_async([self castedGObject], [hostname UTF8String], [cancellable castedGObject], callback, userData);
}

- (GList*)lookupByNameFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GList* returnValue = g_resolver_lookup_by_name_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GList*)lookupByNameWithFlagsWithHostname:(OFString*)hostname flags:(GResolverNameLookupFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GList* returnValue = g_resolver_lookup_by_name_with_flags([self castedGObject], [hostname UTF8String], flags, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)lookupByNameWithFlagsAsyncWithHostname:(OFString*)hostname flags:(GResolverNameLookupFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_resolver_lookup_by_name_with_flags_async([self castedGObject], [hostname UTF8String], flags, [cancellable castedGObject], callback, userData);
}

- (GList*)lookupByNameWithFlagsFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GList* returnValue = g_resolver_lookup_by_name_with_flags_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GList*)lookupRecordsWithRrname:(OFString*)rrname recordType:(GResolverRecordType)recordType cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GList* returnValue = g_resolver_lookup_records([self castedGObject], [rrname UTF8String], recordType, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)lookupRecordsAsyncWithRrname:(OFString*)rrname recordType:(GResolverRecordType)recordType cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_resolver_lookup_records_async([self castedGObject], [rrname UTF8String], recordType, [cancellable castedGObject], callback, userData);
}

- (GList*)lookupRecordsFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GList* returnValue = g_resolver_lookup_records_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GList*)lookupServiceWithService:(OFString*)service protocol:(OFString*)protocol domain:(OFString*)domain cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GList* returnValue = g_resolver_lookup_service([self castedGObject], [service UTF8String], [protocol UTF8String], [domain UTF8String], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)lookupServiceAsyncWithService:(OFString*)service protocol:(OFString*)protocol domain:(OFString*)domain cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_resolver_lookup_service_async([self castedGObject], [service UTF8String], [protocol UTF8String], [domain UTF8String], [cancellable castedGObject], callback, userData);
}

- (GList*)lookupServiceFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GList* returnValue = g_resolver_lookup_service_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)setDefault
{
	g_resolver_set_default([self castedGObject]);
}

- (void)setTimeout:(unsigned)timeoutMs
{
	g_resolver_set_timeout([self castedGObject], timeoutMs);
}


@end