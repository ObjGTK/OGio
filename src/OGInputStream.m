/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInputStream.h"

#import "OGCancellable.h"

@implementation OGInputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_INPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_INPUT_STREAM);
	return gObjectClass;
}

- (GInputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_INPUT_STREAM, GInputStream);
}

- (void)clearPending
{
	g_input_stream_clear_pending((GInputStream*)[self castedGObject]);
}

- (bool)closeWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_input_stream_close((GInputStream*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_input_stream_close_async((GInputStream*)[self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)closeFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_input_stream_close_finish((GInputStream*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)hasPending
{
	bool returnValue = (bool)g_input_stream_has_pending((GInputStream*)[self castedGObject]);

	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = (bool)g_input_stream_is_closed((GInputStream*)[self castedGObject]);

	return returnValue;
}

- (gssize)readWithBuffer:(void*)buffer count:(gsize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_input_stream_read((GInputStream*)[self castedGObject], buffer, count, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)readAllWithBuffer:(void*)buffer count:(gsize)count bytesRead:(gsize*)bytesRead cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_input_stream_read_all((GInputStream*)[self castedGObject], buffer, count, bytesRead, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)readAllAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_input_stream_read_all_async((GInputStream*)[self castedGObject], buffer, count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)readAllFinishWithResult:(GAsyncResult*)result bytesRead:(gsize*)bytesRead
{
	GError* err = NULL;

	bool returnValue = (bool)g_input_stream_read_all_finish((GInputStream*)[self castedGObject], result, bytesRead, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)readAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_input_stream_read_async((GInputStream*)[self castedGObject], buffer, count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (GBytes*)readBytesWithCount:(gsize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GBytes* returnValue = (GBytes*)g_input_stream_read_bytes((GInputStream*)[self castedGObject], count, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)readBytesAsyncWithCount:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_input_stream_read_bytes_async((GInputStream*)[self castedGObject], count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (GBytes*)readBytesFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GBytes* returnValue = (GBytes*)g_input_stream_read_bytes_finish((GInputStream*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)readFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_input_stream_read_finish((GInputStream*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)setPending
{
	GError* err = NULL;

	bool returnValue = (bool)g_input_stream_set_pending((GInputStream*)[self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)skipWithCount:(gsize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_input_stream_skip((GInputStream*)[self castedGObject], count, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)skipAsyncWithCount:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_input_stream_skip_async((GInputStream*)[self castedGObject], count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)skipFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_input_stream_skip_finish((GInputStream*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end