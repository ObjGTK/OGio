/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleAsyncResult.h"

#import "OGCancellable.h"

@implementation OGSimpleAsyncResult

+ (bool)isValidWithResult:(GAsyncResult*)result source:(GObject*)source sourceTag:(gpointer)sourceTag
{
	bool returnValue = g_simple_async_result_is_valid(result, source, sourceTag);

	return returnValue;
}

- (instancetype)initWithSourceObject:(GObject*)sourceObject callback:(GAsyncReadyCallback)callback userData:(gpointer)userData sourceTag:(gpointer)sourceTag
{
	GSimpleAsyncResult* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_async_result_new(sourceObject, callback, userData, sourceTag), GSimpleAsyncResult, GSimpleAsyncResult);

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (instancetype)initFromErrorWithSourceObject:(GObject*)sourceObject callback:(GAsyncReadyCallback)callback userData:(gpointer)userData error:(const GError*)error
{
	GSimpleAsyncResult* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_async_result_new_from_error(sourceObject, callback, userData, error), GSimpleAsyncResult, GSimpleAsyncResult);

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (instancetype)initTakeErrorWithSourceObject:(GObject*)sourceObject callback:(GAsyncReadyCallback)callback userData:(gpointer)userData error:(GError*)error
{
	GSimpleAsyncResult* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_async_result_new_take_error(sourceObject, callback, userData, error), GSimpleAsyncResult, GSimpleAsyncResult);

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (GSimpleAsyncResult*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSimpleAsyncResult, GSimpleAsyncResult);
}

- (void)complete
{
	g_simple_async_result_complete([self castedGObject]);
}

- (void)completeInIdle
{
	g_simple_async_result_complete_in_idle([self castedGObject]);
}

- (bool)opResGboolean
{
	bool returnValue = g_simple_async_result_get_op_res_gboolean([self castedGObject]);

	return returnValue;
}

- (gpointer)opResGpointer
{
	gpointer returnValue = g_simple_async_result_get_op_res_gpointer([self castedGObject]);

	return returnValue;
}

- (gssize)opResGssize
{
	gssize returnValue = g_simple_async_result_get_op_res_gssize([self castedGObject]);

	return returnValue;
}

- (gpointer)sourceTag
{
	gpointer returnValue = g_simple_async_result_get_source_tag([self castedGObject]);

	return returnValue;
}

- (bool)propagateError
{
	GError* err = NULL;

	bool returnValue = g_simple_async_result_propagate_error([self castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)runInThreadWithFunc:(GSimpleAsyncThreadFunc)func ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable
{
	g_simple_async_result_run_in_thread([self castedGObject], func, ioPriority, [cancellable castedGObject]);
}

- (void)setCheckCancellable:(OGCancellable*)checkCancellable
{
	g_simple_async_result_set_check_cancellable([self castedGObject], [checkCancellable castedGObject]);
}

- (void)setErrorVaWithDomain:(GQuark)domain code:(gint)code format:(OFString*)format args:(va_list)args
{
	g_simple_async_result_set_error_va([self castedGObject], domain, code, [format UTF8String], args);
}

- (void)setFromError:(const GError*)error
{
	g_simple_async_result_set_from_error([self castedGObject], error);
}

- (void)setHandleCancellation:(bool)handleCancellation
{
	g_simple_async_result_set_handle_cancellation([self castedGObject], handleCancellation);
}

- (void)setOpResGboolean:(bool)opRes
{
	g_simple_async_result_set_op_res_gboolean([self castedGObject], opRes);
}

- (void)setOpResGpointerWithOpRes:(gpointer)opRes destroyOpRes:(GDestroyNotify)destroyOpRes
{
	g_simple_async_result_set_op_res_gpointer([self castedGObject], opRes, destroyOpRes);
}

- (void)setOpResGssize:(gssize)opRes
{
	g_simple_async_result_set_op_res_gssize([self castedGObject], opRes);
}

- (void)takeError:(GError*)error
{
	g_simple_async_result_take_error([self castedGObject], error);
}


@end