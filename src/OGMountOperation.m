/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMountOperation.h"

@implementation OGMountOperation

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_MOUNT_OPERATION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_MOUNT_OPERATION);
	return gObjectClass;
}

+ (instancetype)mountOperation
{
	GMountOperation* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_mount_operation_new(), G_TYPE_MOUNT_OPERATION, GMountOperation);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMountOperation* wrapperObject;
	@try {
		wrapperObject = [[OGMountOperation alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GMountOperation*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_MOUNT_OPERATION, GMountOperation);
}

- (bool)anonymous
{
	bool returnValue = (bool)g_mount_operation_get_anonymous((GMountOperation*)[self castedGObject]);

	return returnValue;
}

- (int)choice
{
	int returnValue = (int)g_mount_operation_get_choice((GMountOperation*)[self castedGObject]);

	return returnValue;
}

- (OFString*)domain
{
	const char* gobjectValue = g_mount_operation_get_domain((GMountOperation*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)isTcryptHiddenVolume
{
	bool returnValue = (bool)g_mount_operation_get_is_tcrypt_hidden_volume((GMountOperation*)[self castedGObject]);

	return returnValue;
}

- (bool)isTcryptSystemVolume
{
	bool returnValue = (bool)g_mount_operation_get_is_tcrypt_system_volume((GMountOperation*)[self castedGObject]);

	return returnValue;
}

- (OFString*)password
{
	const char* gobjectValue = g_mount_operation_get_password((GMountOperation*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GPasswordSave)passwordSave
{
	GPasswordSave returnValue = (GPasswordSave)g_mount_operation_get_password_save((GMountOperation*)[self castedGObject]);

	return returnValue;
}

- (guint)pim
{
	guint returnValue = (guint)g_mount_operation_get_pim((GMountOperation*)[self castedGObject]);

	return returnValue;
}

- (OFString*)username
{
	const char* gobjectValue = g_mount_operation_get_username((GMountOperation*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (void)replyWithResult:(GMountOperationResult)result
{
	g_mount_operation_reply((GMountOperation*)[self castedGObject], result);
}

- (void)setAnonymous:(bool)anonymous
{
	g_mount_operation_set_anonymous((GMountOperation*)[self castedGObject], anonymous);
}

- (void)setChoice:(int)choice
{
	g_mount_operation_set_choice((GMountOperation*)[self castedGObject], choice);
}

- (void)setDomain:(OFString*)domain
{
	g_mount_operation_set_domain((GMountOperation*)[self castedGObject], [domain UTF8String]);
}

- (void)setIsTcryptHiddenVolume:(bool)hiddenVolume
{
	g_mount_operation_set_is_tcrypt_hidden_volume((GMountOperation*)[self castedGObject], hiddenVolume);
}

- (void)setIsTcryptSystemVolume:(bool)systemVolume
{
	g_mount_operation_set_is_tcrypt_system_volume((GMountOperation*)[self castedGObject], systemVolume);
}

- (void)setPassword:(OFString*)password
{
	g_mount_operation_set_password((GMountOperation*)[self castedGObject], [password UTF8String]);
}

- (void)setPasswordSave:(GPasswordSave)save
{
	g_mount_operation_set_password_save((GMountOperation*)[self castedGObject], save);
}

- (void)setPim:(guint)pim
{
	g_mount_operation_set_pim((GMountOperation*)[self castedGObject], pim);
}

- (void)setUsername:(OFString*)username
{
	g_mount_operation_set_username((GMountOperation*)[self castedGObject], [username UTF8String]);
}


@end