/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDataOutputStream.h"

#import "OGCancellable.h"
#import "OGOutputStream.h"

@implementation OGDataOutputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DATA_OUTPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DATA_OUTPUT_STREAM);
	return gObjectClass;
}

+ (instancetype)dataOutputStreamWithBaseStream:(OGOutputStream*)baseStream
{
	GDataOutputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_data_output_stream_new([baseStream castedGObject]), G_TYPE_DATA_OUTPUT_STREAM, GDataOutputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGDataOutputStream* wrapperObject;
	@try {
		wrapperObject = [[OGDataOutputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GDataOutputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DATA_OUTPUT_STREAM, GDataOutputStream);
}

- (GDataStreamByteOrder)byteOrder
{
	GDataStreamByteOrder returnValue = (GDataStreamByteOrder)g_data_output_stream_get_byte_order([self castedGObject]);

	return returnValue;
}

- (bool)putByteWithData:(guchar)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_data_output_stream_put_byte([self castedGObject], data, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)putInt16WithData:(gint16)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_data_output_stream_put_int16([self castedGObject], data, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)putInt32WithData:(gint32)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_data_output_stream_put_int32([self castedGObject], data, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)putInt64WithData:(gint64)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_data_output_stream_put_int64([self castedGObject], data, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)putString:(OFString*)str cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_data_output_stream_put_string([self castedGObject], [str UTF8String], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)putUint16WithData:(guint16)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_data_output_stream_put_uint16([self castedGObject], data, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)putUint32WithData:(guint32)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_data_output_stream_put_uint32([self castedGObject], data, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)putUint64WithData:(guint64)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_data_output_stream_put_uint64([self castedGObject], data, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)setByteOrder:(GDataStreamByteOrder)order
{
	g_data_output_stream_set_byte_order([self castedGObject], order);
}


@end