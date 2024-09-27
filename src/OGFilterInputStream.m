/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilterInputStream.h"

@implementation OGFilterInputStream

- (GFilterInputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GFilterInputStream, GFilterInputStream);
}

- (OGInputStream*)baseStream
{
	GInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_filter_input_stream_get_base_stream([self castedGObject]), GInputStream, GInputStream);

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