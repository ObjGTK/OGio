/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilterInputStream.h"

@implementation OGFilterInputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_FILTER_INPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_FILTER_INPUT_STREAM);
	return gObjectClass;
}

- (GFilterInputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_FILTER_INPUT_STREAM, GFilterInputStream);
}

- (OGInputStream*)baseStream
{
	GInputStream* gobjectValue = g_filter_input_stream_get_base_stream((GFilterInputStream*)[self castedGObject]);

	OGInputStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (bool)closeBaseStream
{
	bool returnValue = (bool)g_filter_input_stream_get_close_base_stream((GFilterInputStream*)[self castedGObject]);

	return returnValue;
}

- (void)setCloseBaseStream:(bool)closeBase
{
	g_filter_input_stream_set_close_base_stream((GFilterInputStream*)[self castedGObject], closeBase);
}


@end