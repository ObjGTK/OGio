/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGCancellable.h"

@implementation OGCancellable

+ (OGCancellable*)current
{
	GCancellable* gobjectValue = G_CANCELLABLE(g_cancellable_get_current());

	OGCancellable* returnValue = [OGCancellable wrapperFor:gobjectValue];
	return returnValue;
}

- (instancetype)init
{
	GCancellable* gobjectValue = G_CANCELLABLE(g_cancellable_new());

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

- (GCancellable*)castedGObject
{
	return G_CANCELLABLE([self gObject]);
}

- (void)cancel
{
	g_cancellable_cancel([self castedGObject]);
}

- (gulong)connectWithCallback:(GCallback)callback data:(gpointer)data dataDestroyFunc:(GDestroyNotify)dataDestroyFunc
{
	gulong returnValue = g_cancellable_connect([self castedGObject], callback, data, dataDestroyFunc);

	return returnValue;
}

- (void)disconnect:(gulong)handlerId
{
	g_cancellable_disconnect([self castedGObject], handlerId);
}

- (int)fd
{
	int returnValue = g_cancellable_get_fd([self castedGObject]);

	return returnValue;
}

- (bool)isCancelled
{
	bool returnValue = g_cancellable_is_cancelled([self castedGObject]);

	return returnValue;
}

- (bool)makePollfd:(GPollFD*)pollfd
{
	bool returnValue = g_cancellable_make_pollfd([self castedGObject], pollfd);

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

	bool returnValue = g_cancellable_set_error_if_cancelled([self castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GSource*)sourceNew
{
	GSource* returnValue = g_cancellable_source_new([self castedGObject]);

	return returnValue;
}


@end