/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInetAddressMask.h"

#import "OGInetAddress.h"

@implementation OGInetAddressMask

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_INET_ADDRESS_MASK;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_INET_ADDRESS_MASK);
	return gObjectClass;
}

+ (instancetype)inetAddressMaskWithAddr:(OGInetAddress*)addr length:(guint)length
{
	GError* err = NULL;

	GInetAddressMask* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_mask_new([addr castedGObject], length, &err), G_TYPE_INET_ADDRESS_MASK, GInetAddressMask);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGInetAddressMask* wrapperObject;
	@try {
		wrapperObject = [[OGInetAddressMask alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)inetAddressMaskFromStringWithMaskString:(OFString*)maskString
{
	GError* err = NULL;

	GInetAddressMask* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_mask_new_from_string([maskString UTF8String], &err), G_TYPE_INET_ADDRESS_MASK, GInetAddressMask);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGInetAddressMask* wrapperObject;
	@try {
		wrapperObject = [[OGInetAddressMask alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GInetAddressMask*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_INET_ADDRESS_MASK, GInetAddressMask);
}

- (bool)equalWithMask2:(OGInetAddressMask*)mask2
{
	bool returnValue = (bool)g_inet_address_mask_equal((GInetAddressMask*)[self castedGObject], [mask2 castedGObject]);

	return returnValue;
}

- (OGInetAddress*)address
{
	GInetAddress* gobjectValue = g_inet_address_mask_get_address((GInetAddressMask*)[self castedGObject]);

	OGInetAddress* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (GSocketFamily)family
{
	GSocketFamily returnValue = (GSocketFamily)g_inet_address_mask_get_family((GInetAddressMask*)[self castedGObject]);

	return returnValue;
}

- (guint)length
{
	guint returnValue = (guint)g_inet_address_mask_get_length((GInetAddressMask*)[self castedGObject]);

	return returnValue;
}

- (bool)matchesWithAddress:(OGInetAddress*)address
{
	bool returnValue = (bool)g_inet_address_mask_matches((GInetAddressMask*)[self castedGObject], [address castedGObject]);

	return returnValue;
}

- (OFString*)toString
{
	gchar* gobjectValue = g_inet_address_mask_to_string((GInetAddressMask*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}


@end