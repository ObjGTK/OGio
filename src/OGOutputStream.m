/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGOutputStream.h"

#import "OGInputStream.h"
#import "OGCancellable.h"

@implementation OGOutputStream

- (GOutputStream*)castedGObject
{
	return G_OUTPUT_STREAM([self gObject]);
}

- (void)clearPending
{
	g_output_stream_clear_pending([self castedGObject]);
}

- (bool)close:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_output_stream_close([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_close_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)closeFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = g_output_stream_close_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)flush:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_output_stream_flush([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)flushAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_flush_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)flushFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = g_output_stream_flush_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)hasPending
{
	bool returnValue = g_output_stream_has_pending([self castedGObject]);

	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = g_output_stream_is_closed([self castedGObject]);

	return returnValue;
}

- (bool)isClosing
{
	bool returnValue = g_output_stream_is_closing([self castedGObject]);

	return returnValue;
}

- (bool)setPending
{
	GError* err = NULL;

	bool returnValue = g_output_stream_set_pending([self castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (gssize)spliceWithSource:(OGInputStream*)source flags:(GOutputStreamSpliceFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = g_output_stream_splice([self castedGObject], [source castedGObject], flags, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)spliceAsyncWithSource:(OGInputStream*)source flags:(GOutputStreamSpliceFlags)flags ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_splice_async([self castedGObject], [source castedGObject], flags, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)spliceFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = g_output_stream_splice_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)vprintfWithBytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable error:(GError**)error format:(OFString*)format args:(va_list)args
{
	bool returnValue = g_output_stream_vprintf([self castedGObject], bytesWritten, [cancellable castedGObject], error, [format UTF8String], args);

	return returnValue;
}

- (gssize)writeWithBuffer:(void*)buffer count:(gsize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = g_output_stream_write([self castedGObject], buffer, count, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)writeAllWithBuffer:(void*)buffer count:(gsize)count bytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_output_stream_write_all([self castedGObject], buffer, count, bytesWritten, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)writeAllAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_write_all_async([self castedGObject], buffer, count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)writeAllFinishWithResult:(GAsyncResult*)result bytesWritten:(gsize*)bytesWritten
{
	GError* err = NULL;

	bool returnValue = g_output_stream_write_all_finish([self castedGObject], result, bytesWritten, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)writeAsyncWithBuffer:(void*)buffer count:(gsize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_write_async([self castedGObject], buffer, count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)writeBytesWithBytes:(GBytes*)bytes cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = g_output_stream_write_bytes([self castedGObject], bytes, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)writeBytesAsyncWithBytes:(GBytes*)bytes ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_write_bytes_async([self castedGObject], bytes, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)writeBytesFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = g_output_stream_write_bytes_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (gssize)writeFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = g_output_stream_write_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)writevWithVectors:(const GOutputVector*)vectors nvectors:(gsize)nvectors bytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_output_stream_writev([self castedGObject], vectors, nvectors, bytesWritten, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)writevAllWithVectors:(GOutputVector*)vectors nvectors:(gsize)nvectors bytesWritten:(gsize*)bytesWritten cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_output_stream_writev_all([self castedGObject], vectors, nvectors, bytesWritten, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)writevAllAsyncWithVectors:(GOutputVector*)vectors nvectors:(gsize)nvectors ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_writev_all_async([self castedGObject], vectors, nvectors, ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)writevAllFinishWithResult:(GAsyncResult*)result bytesWritten:(gsize*)bytesWritten
{
	GError* err = NULL;

	bool returnValue = g_output_stream_writev_all_finish([self castedGObject], result, bytesWritten, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)writevAsyncWithVectors:(const GOutputVector*)vectors nvectors:(gsize)nvectors ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_output_stream_writev_async([self castedGObject], vectors, nvectors, ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)writevFinishWithResult:(GAsyncResult*)result bytesWritten:(gsize*)bytesWritten
{
	GError* err = NULL;

	bool returnValue = g_output_stream_writev_finish([self castedGObject], result, bytesWritten, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}


@end