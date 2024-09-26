/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGIOStream.h"

#import "OGCancellable.h"
#import "OGInputStream.h"
#import "OGOutputStream.h"

@implementation OGIOStream

+ (bool)spliceFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = g_io_stream_splice_finish(result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GIOStream*)castedGObject
{
	return G_IO_STREAM([self gObject]);
}

- (void)clearPending
{
	g_io_stream_clear_pending([self castedGObject]);
}

- (bool)close:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_io_stream_close([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_io_stream_close_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)closeFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = g_io_stream_close_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (OGInputStream*)inputStream
{
	GInputStream* gobjectValue = G_INPUT_STREAM(g_io_stream_get_input_stream([self castedGObject]));

	OGInputStream* returnValue = [OGInputStream withGObject:gobjectValue];
	return returnValue;
}

- (OGOutputStream*)outputStream
{
	GOutputStream* gobjectValue = G_OUTPUT_STREAM(g_io_stream_get_output_stream([self castedGObject]));

	OGOutputStream* returnValue = [OGOutputStream withGObject:gobjectValue];
	return returnValue;
}

- (bool)hasPending
{
	bool returnValue = g_io_stream_has_pending([self castedGObject]);

	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = g_io_stream_is_closed([self castedGObject]);

	return returnValue;
}

- (bool)setPending
{
	GError* err = NULL;

	bool returnValue = g_io_stream_set_pending([self castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)spliceAsyncWithStream2:(OGIOStream*)stream2 flags:(GIOStreamSpliceFlags)flags ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_io_stream_splice_async([self castedGObject], [stream2 castedGObject], flags, ioPriority, [cancellable castedGObject], callback, userData);
}


@end