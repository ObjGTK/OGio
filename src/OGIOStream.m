/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGIOStream.h"

#import "OGCancellable.h"
#import "OGInputStream.h"
#import "OGOutputStream.h"

@implementation OGIOStream

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_IO_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (bool)spliceFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_io_stream_splice_finish(result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GIOStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GIOStream, GIOStream);
}

- (void)clearPending
{
	g_io_stream_clear_pending([self castedGObject]);
}

- (bool)close:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_io_stream_close([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_io_stream_close_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)closeFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_io_stream_close_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OGInputStream*)inputStream
{
	GInputStream* gobjectValue = g_io_stream_get_input_stream([self castedGObject]);

	OGInputStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OGOutputStream*)outputStream
{
	GOutputStream* gobjectValue = g_io_stream_get_output_stream([self castedGObject]);

	OGOutputStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (bool)hasPending
{
	bool returnValue = (bool)g_io_stream_has_pending([self castedGObject]);

	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = (bool)g_io_stream_is_closed([self castedGObject]);

	return returnValue;
}

- (bool)setPending
{
	GError* err = NULL;

	bool returnValue = (bool)g_io_stream_set_pending([self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)spliceAsyncWithStream2:(OGIOStream*)stream2 flags:(GIOStreamSpliceFlags)flags ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_io_stream_splice_async([self castedGObject], [stream2 castedGObject], flags, ioPriority, [cancellable castedGObject], callback, userData);
}


@end