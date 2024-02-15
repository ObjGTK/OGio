/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilterOutputStream.h"

@implementation OGFilterOutputStream

- (GFilterOutputStream*)castedGObject
{
	return G_FILTER_OUTPUT_STREAM([self gObject]);
}

- (OGOutputStream*)baseStream
{
	GOutputStream* gobjectValue = G_OUTPUT_STREAM(g_filter_output_stream_get_base_stream([self castedGObject]));

	OGOutputStream* returnValue = [OGOutputStream withGObject:gobjectValue];
	return returnValue;
}

- (bool)closeBaseStream
{
	bool returnValue = g_filter_output_stream_get_close_base_stream([self castedGObject]);

	return returnValue;
}

- (void)setCloseBaseStream:(bool)closeBase
{
	g_filter_output_stream_set_close_base_stream([self castedGObject], closeBase);
}


@end