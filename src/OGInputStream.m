/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInputStream.h"

#import "OGCancellable.h"

@implementation OGInputStream

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_INPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (GInputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GInputStream, GInputStream);
}

- (void)clearPending
{
	g_input_stream_clear_pending([self castedGObject]);
}

- (bool)close:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_input_stream_close([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_input_stream_close_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)closeFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_input_stream_close_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)hasPending
{
	bool returnValue = (bool)g_input_stream_has_pending([self castedGObject]);

	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = (bool)g_input_stream_is_closed([self castedGObject]);

	return returnValue;
}

- (gssize)readWithBuffer:(void*)buffer count:(gsize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_input_stream_read([self castedGObject], buffer, count, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)readAllWithBuffer:(void*)buffer count:(gsize)count bytesRead:(gsize*)bytesRead cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_input_stream_read_all([self castedGObject], buffer, count, bytesRead, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)readAllAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_input_stream_read_all_async([self castedGObject], buffer, count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)readAllFinishWithResult:(GAsyncResult*)result bytesRead:(gsize*)bytesRead
{
	GError* err = NULL;

	bool returnValue = (bool)g_input_stream_read_all_finish([self castedGObject], result, bytesRead, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)readAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_input_stream_read_async([self castedGObject], buffer, count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (GBytes*)readBytesWithCount:(gsize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GBytes* returnValue = (GBytes*)g_input_stream_read_bytes([self castedGObject], count, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)readBytesAsyncWithCount:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_input_stream_read_bytes_async([self castedGObject], count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (GBytes*)readBytesFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GBytes* returnValue = (GBytes*)g_input_stream_read_bytes_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)readFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_input_stream_read_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)setPending
{
	GError* err = NULL;

	bool returnValue = (bool)g_input_stream_set_pending([self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)skipWithCount:(gsize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_input_stream_skip([self castedGObject], count, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)skipAsyncWithCount:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_input_stream_skip_async([self castedGObject], count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)skipFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_input_stream_skip_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end