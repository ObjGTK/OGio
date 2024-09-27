/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenuLinkIter.h"

#import "OGMenuModel.h"

@implementation OGMenuLinkIter

- (GMenuLinkIter*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GMenuLinkIter, GMenuLinkIter);
}

- (OFString*)name
{
	const gchar* gobjectValue = g_menu_link_iter_get_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)nextWithOutLink:(const gchar**)outLink value:(GMenuModel**)value
{
	bool returnValue = g_menu_link_iter_get_next([self castedGObject], outLink, value);

	return returnValue;
}

- (OGMenuModel*)value
{
	GMenuModel* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_menu_link_iter_get_value([self castedGObject]), GMenuModel, GMenuModel);

	OGMenuModel* returnValue = [OGMenuModel withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (bool)next
{
	bool returnValue = g_menu_link_iter_next([self castedGObject]);

	return returnValue;
}


@end