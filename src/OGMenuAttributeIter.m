/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenuAttributeIter.h"

@implementation OGMenuAttributeIter

- (GMenuAttributeIter*)castedGObject
{
	return G_MENU_ATTRIBUTE_ITER([self gObject]);
}

- (OFString*)name
{
	const gchar* gobjectValue = g_menu_attribute_iter_get_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)nextWithOutName:(const gchar**)outName value:(GVariant**)value
{
	bool returnValue = g_menu_attribute_iter_get_next([self castedGObject], outName, value);

	return returnValue;
}

- (GVariant*)value
{
	GVariant* returnValue = g_menu_attribute_iter_get_value([self castedGObject]);

	return returnValue;
}

- (bool)next
{
	bool returnValue = g_menu_attribute_iter_next([self castedGObject]);

	return returnValue;
}


@end