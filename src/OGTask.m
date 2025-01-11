/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTask.h"

#import "OGCancellable.h"

@implementation OGTask

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TASK;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (bool)isValidWithResult:(gpointer)result sourceObject:(gpointer)sourceObject
{
	bool returnValue = (bool)g_task_is_valid(result, sourceObject);

	return returnValue;
}

+ (void)reportErrorWithSourceObject:(gpointer)sourceObject callback:(GAsyncReadyCallback)callback callbackData:(gpointer)callbackData sourceTag:(gpointer)sourceTag error:(GError*)error
{
	g_task_report_error(sourceObject, callback, callbackData, sourceTag, error);
}

+ (instancetype)taskWithSourceObject:(gpointer)sourceObject cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback callbackData:(gpointer)callbackData
{
	GTask* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_task_new(sourceObject, [cancellable castedGObject], callback, callbackData), GTask, GTask);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGTask* wrapperObject;
	@try {
		wrapperObject = [[OGTask alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GTask*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GTask, GTask);
}

- (void)attachSourceWithSource:(GSource*)source callback:(GSourceFunc)callback
{
	g_task_attach_source([self castedGObject], source, callback);
}

- (OGCancellable*)cancellable
{
	GCancellable* gobjectValue = g_task_get_cancellable([self castedGObject]);

	OGCancellable* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (bool)checkCancellable
{
	bool returnValue = (bool)g_task_get_check_cancellable([self castedGObject]);

	return returnValue;
}

- (bool)completed
{
	bool returnValue = (bool)g_task_get_completed([self castedGObject]);

	return returnValue;
}

- (GMainContext*)context
{
	GMainContext* returnValue = (GMainContext*)g_task_get_context([self castedGObject]);

	return returnValue;
}

- (OFString*)name
{
	const gchar* gobjectValue = g_task_get_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (gint)priority
{
	gint returnValue = (gint)g_task_get_priority([self castedGObject]);

	return returnValue;
}

- (bool)returnOnCancel
{
	bool returnValue = (bool)g_task_get_return_on_cancel([self castedGObject]);

	return returnValue;
}

- (gpointer)sourceObject
{
	gpointer returnValue = (gpointer)g_task_get_source_object([self castedGObject]);

	return returnValue;
}

- (gpointer)sourceTag
{
	gpointer returnValue = (gpointer)g_task_get_source_tag([self castedGObject]);

	return returnValue;
}

- (gpointer)taskData
{
	gpointer returnValue = (gpointer)g_task_get_task_data([self castedGObject]);

	return returnValue;
}

- (bool)hadError
{
	bool returnValue = (bool)g_task_had_error([self castedGObject]);

	return returnValue;
}

- (bool)propagateBoolean
{
	GError* err = NULL;

	bool returnValue = (bool)g_task_propagate_boolean([self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)propagateInt
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_task_propagate_int([self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gpointer)propagatePointer
{
	GError* err = NULL;

	gpointer returnValue = (gpointer)g_task_propagate_pointer([self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)propagateValue:(GValue*)value
{
	GError* err = NULL;

	bool returnValue = (bool)g_task_propagate_value([self castedGObject], value, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)returnBoolean:(bool)result
{
	g_task_return_boolean([self castedGObject], result);
}

- (void)returnError:(GError*)error
{
	g_task_return_error([self castedGObject], error);
}

- (bool)returnErrorIfCancelled
{
	bool returnValue = (bool)g_task_return_error_if_cancelled([self castedGObject]);

	return returnValue;
}

- (void)returnInt:(gssize)result
{
	g_task_return_int([self castedGObject], result);
}

- (void)returnNewErrorLiteralWithDomain:(GQuark)domain code:(gint)code message:(OFString*)message
{
	g_task_return_new_error_literal([self castedGObject], domain, code, [message UTF8String]);
}

- (void)returnPointerWithResult:(gpointer)result resultDestroy:(GDestroyNotify)resultDestroy
{
	g_task_return_pointer([self castedGObject], result, resultDestroy);
}

- (void)returnValue:(GValue*)result
{
	g_task_return_value([self castedGObject], result);
}

- (void)runInThread:(GTaskThreadFunc)taskFunc
{
	g_task_run_in_thread([self castedGObject], taskFunc);
}

- (void)runInThreadSync:(GTaskThreadFunc)taskFunc
{
	g_task_run_in_thread_sync([self castedGObject], taskFunc);
}

- (void)setCheckCancellable:(bool)checkCancellable
{
	g_task_set_check_cancellable([self castedGObject], checkCancellable);
}

- (void)setName:(OFString*)name
{
	g_task_set_name([self castedGObject], [name UTF8String]);
}

- (void)setPriority:(gint)priority
{
	g_task_set_priority([self castedGObject], priority);
}

- (bool)setReturnOnCancel:(bool)returnOnCancel
{
	bool returnValue = (bool)g_task_set_return_on_cancel([self castedGObject], returnOnCancel);

	return returnValue;
}

- (void)setSourceTag:(gpointer)sourceTag
{
	g_task_set_source_tag([self castedGObject], sourceTag);
}

- (void)setStaticName:(OFString*)name
{
	g_task_set_static_name([self castedGObject], [name UTF8String]);
}

- (void)setTaskDataWithTaskData:(gpointer)taskData taskDataDestroy:(GDestroyNotify)taskDataDestroy
{
	g_task_set_task_data([self castedGObject], taskData, taskDataDestroy);
}


@end