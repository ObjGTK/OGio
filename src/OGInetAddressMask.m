/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInetAddressMask.h"

#import "OGInetAddress.h"

@implementation OGInetAddressMask

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_INET_ADDRESS_MASK;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithAddr:(OGInetAddress*)addr length:(guint)length
{
	GError* err = NULL;

	GInetAddressMask* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_mask_new([addr castedGObject], length, &err), GInetAddressMask, GInetAddressMask);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (instancetype)initWithMaskStringFromString:(OFString*)maskString
{
	GError* err = NULL;

	GInetAddressMask* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_mask_new_from_string([maskString UTF8String], &err), GInetAddressMask, GInetAddressMask);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (GInetAddressMask*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GInetAddressMask, GInetAddressMask);
}

- (bool)equal:(OGInetAddressMask*)mask2
{
	bool returnValue = (bool)g_inet_address_mask_equal([self castedGObject], [mask2 castedGObject]);

	return returnValue;
}

- (OGInetAddress*)address
{
	GInetAddress* gobjectValue = g_inet_address_mask_get_address([self castedGObject]);

	OGInetAddress* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (GSocketFamily)family
{
	GSocketFamily returnValue = (GSocketFamily)g_inet_address_mask_get_family([self castedGObject]);

	return returnValue;
}

- (guint)length
{
	guint returnValue = (guint)g_inet_address_mask_get_length([self castedGObject]);

	return returnValue;
}

- (bool)matches:(OGInetAddress*)address
{
	bool returnValue = (bool)g_inet_address_mask_matches([self castedGObject], [address castedGObject]);

	return returnValue;
}

- (OFString*)toString
{
	gchar* gobjectValue = g_inet_address_mask_to_string([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}


@end