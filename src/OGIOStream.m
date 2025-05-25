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

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_IO_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_IO_STREAM);
	return gObjectClass;
}

+ (bool)spliceFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_io_stream_splice_finish(result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GIOStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_IO_STREAM, GIOStream);
}

- (void)clearPending
{
	g_io_stream_clear_pending((GIOStream*)[self castedGObject]);
}

- (bool)closeWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_io_stream_close((GIOStream*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_io_stream_close_async((GIOStream*)[self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)closeFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_io_stream_close_finish((GIOStream*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OGInputStream*)inputStream
{
	GInputStream* gobjectValue = g_io_stream_get_input_stream((GIOStream*)[self castedGObject]);

	OGInputStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OGOutputStream*)outputStream
{
	GOutputStream* gobjectValue = g_io_stream_get_output_stream((GIOStream*)[self castedGObject]);

	OGOutputStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (bool)hasPending
{
	bool returnValue = (bool)g_io_stream_has_pending((GIOStream*)[self castedGObject]);

	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = (bool)g_io_stream_is_closed((GIOStream*)[self castedGObject]);

	return returnValue;
}

- (bool)setPending
{
	GError* err = NULL;

	bool returnValue = (bool)g_io_stream_set_pending((GIOStream*)[self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)spliceAsyncWithStream2:(OGIOStream*)stream2 flags:(GIOStreamSpliceFlags)flags ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_io_stream_splice_async((GIOStream*)[self castedGObject], [stream2 castedGObject], flags, ioPriority, [cancellable castedGObject], callback, userData);
}


@end