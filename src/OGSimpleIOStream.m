/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleIOStream.h"

#import "OGInputStream.h"
#import "OGOutputStream.h"

@implementation OGSimpleIOStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SIMPLE_IO_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SIMPLE_IO_STREAM);
	return gObjectClass;
}

+ (instancetype)simpleIOStreamWithInputStream:(OGInputStream*)inputStream outputStream:(OGOutputStream*)outputStream
{
	GSimpleIOStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_io_stream_new([inputStream castedGObject], [outputStream castedGObject]), G_TYPE_SIMPLE_IO_STREAM, GSimpleIOStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSimpleIOStream* wrapperObject;
	@try {
		wrapperObject = [[OGSimpleIOStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSimpleIOStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SIMPLE_IO_STREAM, GSimpleIOStream);
}


@end