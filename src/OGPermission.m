/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGPermission.h"

#import "OGCancellable.h"

@implementation OGPermission

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_PERMISSION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (GPermission*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GPermission, GPermission);
}

- (bool)acquire:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_permission_acquire([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)acquireAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_permission_acquire_async([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)acquireFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_permission_acquire_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)allowed
{
	bool returnValue = (bool)g_permission_get_allowed([self castedGObject]);

	return returnValue;
}

- (bool)canAcquire
{
	bool returnValue = (bool)g_permission_get_can_acquire([self castedGObject]);

	return returnValue;
}

- (bool)canRelease
{
	bool returnValue = (bool)g_permission_get_can_release([self castedGObject]);

	return returnValue;
}

- (void)implUpdateWithAllowed:(bool)allowed canAcquire:(bool)canAcquire canRelease:(bool)canRelease
{
	g_permission_impl_update([self castedGObject], allowed, canAcquire, canRelease);
}

- (bool)decreaseCount:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_permission_release([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)releaseAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_permission_release_async([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)releaseFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_permission_release_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end