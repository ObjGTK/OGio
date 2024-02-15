/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilterInputStream.h"

@implementation OGFilterInputStream

- (GFilterInputStream*)castedGObject
{
	return G_FILTER_INPUT_STREAM([self gObject]);
}

- (OGInputStream*)baseStream
{
	GInputStream* gobjectValue = G_INPUT_STREAM(g_filter_input_stream_get_base_stream([self castedGObject]));

	OGInputStream* returnValue = [OGInputStream withGObject:gobjectValue];
	return returnValue;
}

- (bool)closeBaseStream
{
	bool returnValue = g_filter_input_stream_get_close_base_stream([self castedGObject]);

	return returnValue;
}

- (void)setCloseBaseStream:(bool)closeBase
{
	g_filter_input_stream_set_close_base_stream([self castedGObject], closeBase);
}


@end