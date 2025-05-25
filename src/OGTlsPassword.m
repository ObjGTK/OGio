/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTlsPassword.h"

@implementation OGTlsPassword

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TLS_PASSWORD;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_TLS_PASSWORD);
	return gObjectClass;
}

+ (instancetype)tlsPasswordWithFlags:(GTlsPasswordFlags)flags description:(OFString*)description
{
	GTlsPassword* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_password_new(flags, [description UTF8String]), G_TYPE_TLS_PASSWORD, GTlsPassword);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGTlsPassword* wrapperObject;
	@try {
		wrapperObject = [[OGTlsPassword alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GTlsPassword*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_TLS_PASSWORD, GTlsPassword);
}

- (OFString*)description
{
	const gchar* gobjectValue = g_tls_password_get_description([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GTlsPasswordFlags)flags
{
	GTlsPasswordFlags returnValue = (GTlsPasswordFlags)g_tls_password_get_flags([self castedGObject]);

	return returnValue;
}

- (const guchar*)valueWithLength:(gsize*)length
{
	const guchar* returnValue = (const guchar*)g_tls_password_get_value([self castedGObject], length);

	return returnValue;
}

- (OFString*)warning
{
	const gchar* gobjectValue = g_tls_password_get_warning([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (void)setDescription:(OFString*)description
{
	g_tls_password_set_description([self castedGObject], [description UTF8String]);
}

- (void)setFlags:(GTlsPasswordFlags)flags
{
	g_tls_password_set_flags([self castedGObject], flags);
}

- (void)setValue:(const guchar*)value length:(gssize)length
{
	g_tls_password_set_value([self castedGObject], value, length);
}

- (void)setValueFull:(guchar*)value length:(gssize)length destroy:(GDestroyNotify)destroy
{
	g_tls_password_set_value_full([self castedGObject], value, length, destroy);
}

- (void)setWarning:(OFString*)warning
{
	g_tls_password_set_warning([self castedGObject], [warning UTF8String]);
}


@end