/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGConverterOutputStream.h"

#import "OGOutputStream.h"

@implementation OGConverterOutputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_CONVERTER_OUTPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_CONVERTER_OUTPUT_STREAM);
	return gObjectClass;
}

+ (instancetype)converterOutputStreamWithBaseStream:(OGOutputStream*)baseStream converter:(GConverter*)converter
{
	GConverterOutputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_converter_output_stream_new([baseStream castedGObject], converter), G_TYPE_CONVERTER_OUTPUT_STREAM, GConverterOutputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGConverterOutputStream* wrapperObject;
	@try {
		wrapperObject = [[OGConverterOutputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GConverterOutputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_CONVERTER_OUTPUT_STREAM, GConverterOutputStream);
}

- (GConverter*)converter
{
	GConverter* returnValue = (GConverter*)g_converter_output_stream_get_converter([self castedGObject]);

	return returnValue;
}


@end