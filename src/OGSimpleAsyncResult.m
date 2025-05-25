/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleAsyncResult.h"

#import "OGCancellable.h"

@implementation OGSimpleAsyncResult

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SIMPLE_ASYNC_RESULT;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SIMPLE_ASYNC_RESULT);
	return gObjectClass;
}

+ (bool)isValidWithResult:(GAsyncResult*)result source:(OGObject*)source sourceTag:(gpointer)sourceTag
{
	bool returnValue = (bool)g_simple_async_result_is_valid(result, [source gObject], sourceTag);

	return returnValue;
}

+ (instancetype)simpleAsyncResultWithSourceObject:(OGObject*)sourceObject callback:(GAsyncReadyCallback)callback userData:(gpointer)userData sourceTag:(gpointer)sourceTag
{
	GSimpleAsyncResult* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_async_result_new([sourceObject gObject], callback, userData, sourceTag), G_TYPE_SIMPLE_ASYNC_RESULT, GSimpleAsyncResult);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSimpleAsyncResult* wrapperObject;
	@try {
		wrapperObject = [[OGSimpleAsyncResult alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)simpleAsyncResultFromErrorWithSourceObject:(OGObject*)sourceObject callback:(GAsyncReadyCallback)callback userData:(gpointer)userData error:(const GError*)error
{
	GSimpleAsyncResult* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_async_result_new_from_error([sourceObject gObject], callback, userData, error), G_TYPE_SIMPLE_ASYNC_RESULT, GSimpleAsyncResult);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSimpleAsyncResult* wrapperObject;
	@try {
		wrapperObject = [[OGSimpleAsyncResult alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)simpleAsyncResultTakeErrorWithSourceObject:(OGObject*)sourceObject callback:(GAsyncReadyCallback)callback userData:(gpointer)userData error:(GError*)error
{
	GSimpleAsyncResult* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_async_result_new_take_error([sourceObject gObject], callback, userData, error), G_TYPE_SIMPLE_ASYNC_RESULT, GSimpleAsyncResult);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSimpleAsyncResult* wrapperObject;
	@try {
		wrapperObject = [[OGSimpleAsyncResult alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSimpleAsyncResult*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SIMPLE_ASYNC_RESULT, GSimpleAsyncResult);
}

- (void)complete
{
	g_simple_async_result_complete((GSimpleAsyncResult*)[self castedGObject]);
}

- (void)completeInIdle
{
	g_simple_async_result_complete_in_idle((GSimpleAsyncResult*)[self castedGObject]);
}

- (bool)opResGboolean
{
	bool returnValue = (bool)g_simple_async_result_get_op_res_gboolean((GSimpleAsyncResult*)[self castedGObject]);

	return returnValue;
}

- (gpointer)opResGpointer
{
	gpointer returnValue = (gpointer)g_simple_async_result_get_op_res_gpointer((GSimpleAsyncResult*)[self castedGObject]);

	return returnValue;
}

- (gssize)opResGssize
{
	gssize returnValue = (gssize)g_simple_async_result_get_op_res_gssize((GSimpleAsyncResult*)[self castedGObject]);

	return returnValue;
}

- (gpointer)sourceTag
{
	gpointer returnValue = (gpointer)g_simple_async_result_get_source_tag((GSimpleAsyncResult*)[self castedGObject]);

	return returnValue;
}

- (bool)propagateError
{
	GError* err = NULL;

	bool returnValue = (bool)g_simple_async_result_propagate_error((GSimpleAsyncResult*)[self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)runInThreadWithFunc:(GSimpleAsyncThreadFunc)func ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable
{
	g_simple_async_result_run_in_thread((GSimpleAsyncResult*)[self castedGObject], func, ioPriority, [cancellable castedGObject]);
}

- (void)setCheckCancellable:(OGCancellable*)checkCancellable
{
	g_simple_async_result_set_check_cancellable((GSimpleAsyncResult*)[self castedGObject], [checkCancellable castedGObject]);
}

- (void)setErrorVaWithDomain:(GQuark)domain code:(gint)code format:(OFString*)format args:(va_list)args
{
	g_simple_async_result_set_error_va((GSimpleAsyncResult*)[self castedGObject], domain, code, [format UTF8String], args);
}

- (void)setFromError:(const GError*)error
{
	g_simple_async_result_set_from_error((GSimpleAsyncResult*)[self castedGObject], error);
}

- (void)setHandleCancellation:(bool)handleCancellation
{
	g_simple_async_result_set_handle_cancellation((GSimpleAsyncResult*)[self castedGObject], handleCancellation);
}

- (void)setOpResGboolean:(bool)opRes
{
	g_simple_async_result_set_op_res_gboolean((GSimpleAsyncResult*)[self castedGObject], opRes);
}

- (void)setOpResGpointer:(gpointer)opRes destroyOpRes:(GDestroyNotify)destroyOpRes
{
	g_simple_async_result_set_op_res_gpointer((GSimpleAsyncResult*)[self castedGObject], opRes, destroyOpRes);
}

- (void)setOpResGssize:(gssize)opRes
{
	g_simple_async_result_set_op_res_gssize((GSimpleAsyncResult*)[self castedGObject], opRes);
}

- (void)takeError:(GError*)error
{
	g_simple_async_result_take_error((GSimpleAsyncResult*)[self castedGObject], error);
}


@end