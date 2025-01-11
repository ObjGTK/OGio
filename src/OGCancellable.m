/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGCancellable.h"

@implementation OGCancellable

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_CANCELLABLE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (OGCancellable*)current
{
	GCancellable* gobjectValue = g_cancellable_get_current();

	OGCancellable* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

+ (instancetype)cancellable
{
	GCancellable* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_cancellable_new(), GCancellable, GCancellable);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGCancellable* wrapperObject;
	@try {
		wrapperObject = [[OGCancellable alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GCancellable*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GCancellable, GCancellable);
}

- (void)cancel
{
	g_cancellable_cancel([self castedGObject]);
}

- (gulong)connectWithCallback:(GCallback)callback data:(gpointer)data dataDestroyFunc:(GDestroyNotify)dataDestroyFunc
{
	gulong returnValue = (gulong)g_cancellable_connect([self castedGObject], callback, data, dataDestroyFunc);

	return returnValue;
}

- (void)disconnect:(gulong)handlerId
{
	g_cancellable_disconnect([self castedGObject], handlerId);
}

- (int)fd
{
	int returnValue = (int)g_cancellable_get_fd([self castedGObject]);

	return returnValue;
}

- (bool)isCancelled
{
	bool returnValue = (bool)g_cancellable_is_cancelled([self castedGObject]);

	return returnValue;
}

- (bool)makePollfd:(GPollFD*)pollfd
{
	bool returnValue = (bool)g_cancellable_make_pollfd([self castedGObject], pollfd);

	return returnValue;
}

- (void)popCurrent
{
	g_cancellable_pop_current([self castedGObject]);
}

- (void)pushCurrent
{
	g_cancellable_push_current([self castedGObject]);
}

- (void)releaseFd
{
	g_cancellable_release_fd([self castedGObject]);
}

- (void)reset
{
	g_cancellable_reset([self castedGObject]);
}

- (bool)setErrorIfCancelled
{
	GError* err = NULL;

	bool returnValue = (bool)g_cancellable_set_error_if_cancelled([self castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GSource*)sourceNew
{
	GSource* returnValue = (GSource*)g_cancellable_source_new([self castedGObject]);

	return returnValue;
}


@end