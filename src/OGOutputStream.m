/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGOutputStream.h"

#import "OGCancellable.h"
#import "OGInputStream.h"

@implementation OGOutputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_OUTPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_OUTPUT_STREAM);
	return gObjectClass;
}

- (GOutputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_OUTPUT_STREAM, GOutputStream);
}

- (void)clearPending
{
	g_output_stream_clear_pending([self castedGObject]);
}

- (bool)closeWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_close([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_close_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)closeFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_close_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)flushWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_flush([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)flushAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_flush_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)flushFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_flush_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)hasPending
{
	bool returnValue = (bool)g_output_stream_has_pending([self castedGObject]);

	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = (bool)g_output_stream_is_closed([self castedGObject]);

	return returnValue;
}

- (bool)isClosing
{
	bool returnValue = (bool)g_output_stream_is_closing([self castedGObject]);

	return returnValue;
}

- (bool)setPending
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_set_pending([self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)spliceWithSource:(OGInputStream*)source flags:(GOutputStreamSpliceFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_output_stream_splice([self castedGObject], [source castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)spliceAsyncWithSource:(OGInputStream*)source flags:(GOutputStreamSpliceFlags)flags ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_splice_async([self castedGObject], [source castedGObject], flags, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)spliceFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_output_stream_splice_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)vprintfWithBytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable error:(GError**)error format:(OFString*)format args:(va_list)args
{
	bool returnValue = (bool)g_output_stream_vprintf([self castedGObject], bytesWritten, [cancellable castedGObject], error, [format UTF8String], args);

	return returnValue;
}

- (gssize)writeWithBuffer:(void*)buffer count:(gsize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_output_stream_write([self castedGObject], buffer, count, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)writeAllWithBuffer:(void*)buffer count:(gsize)count bytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_write_all([self castedGObject], buffer, count, bytesWritten, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)writeAllAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_write_all_async([self castedGObject], buffer, count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)writeAllFinishWithResult:(GAsyncResult*)result bytesWritten:(gsize*)bytesWritten
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_write_all_finish([self castedGObject], result, bytesWritten, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)writeAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_write_async([self castedGObject], buffer, count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)writeBytes:(GBytes*)bytes cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_output_stream_write_bytes([self castedGObject], bytes, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)writeBytesAsync:(GBytes*)bytes ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_write_bytes_async([self castedGObject], bytes, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)writeBytesFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_output_stream_write_bytes_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gssize)writeFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_output_stream_write_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)writevWithVectors:(const GOutputVector*)vectors nvectors:(gsize)nvectors bytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_writev([self castedGObject], vectors, nvectors, bytesWritten, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)writevAllWithVectors:(GOutputVector*)vectors nvectors:(gsize)nvectors bytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_writev_all([self castedGObject], vectors, nvectors, bytesWritten, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)writevAllAsyncWithVectors:(GOutputVector*)vectors nvectors:(gsize)nvectors ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_writev_all_async([self castedGObject], vectors, nvectors, ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)writevAllFinishWithResult:(GAsyncResult*)result bytesWritten:(gsize*)bytesWritten
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_writev_all_finish([self castedGObject], result, bytesWritten, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)writevAsyncWithVectors:(const GOutputVector*)vectors nvectors:(gsize)nvectors ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_writev_async([self castedGObject], vectors, nvectors, ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)writevFinishWithResult:(GAsyncResult*)result bytesWritten:(gsize*)bytesWritten
{
	GError* err = NULL;

	bool returnValue = (bool)g_output_stream_writev_finish([self castedGObject], result, bytesWritten, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end