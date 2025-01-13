/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGCredentials.h"

@implementation OGCredentials

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_CREDENTIALS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (instancetype)credentials
{
	GCredentials* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_credentials_new(), GCredentials, GCredentials);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGCredentials* wrapperObject;
	@try {
		wrapperObject = [[OGCredentials alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GCredentials*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GCredentials, GCredentials);
}

- (gpointer)nativeWithNativeType:(GCredentialsType)nativeType
{
	gpointer returnValue = (gpointer)g_credentials_get_native([self castedGObject], nativeType);

	return returnValue;
}

- (pid_t)unixPid
{
	GError* err = NULL;

	pid_t returnValue = (pid_t)g_credentials_get_unix_pid([self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (uid_t)unixUser
{
	GError* err = NULL;

	uid_t returnValue = (uid_t)g_credentials_get_unix_user([self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)isSameUserWithOtherCredentials:(OGCredentials*)otherCredentials
{
	GError* err = NULL;

	bool returnValue = (bool)g_credentials_is_same_user([self castedGObject], [otherCredentials castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)setNativeWithNativeType:(GCredentialsType)nativeType native:(gpointer)native
{
	g_credentials_set_native([self castedGObject], nativeType, native);
}

- (bool)setUnixUserWithUid:(uid_t)uid
{
	GError* err = NULL;

	bool returnValue = (bool)g_credentials_set_unix_user([self castedGObject], uid, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OFString*)toString
{
	gchar* gobjectValue = g_credentials_to_string([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}


@end