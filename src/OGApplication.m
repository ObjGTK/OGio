/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGApplication.h"

#import "OGCancellable.h"
#import "OGNotification.h"
#import "OGDBusConnection.h"

@implementation OGApplication

+ (OGApplication*)default
{
	GApplication* gobjectValue = G_APPLICATION(g_application_get_default());

	OGApplication* returnValue = [OGApplication withGObject:gobjectValue];
	return returnValue;
}

+ (bool)idIsValid:(OFString*)applicationId
{
	bool returnValue = g_application_id_is_valid([applicationId UTF8String]);

	return returnValue;
}

- (instancetype)initWithApplicationId:(OFString*)applicationId flags:(GApplicationFlags)flags
{
	GApplication* gobjectValue = G_APPLICATION(g_application_new([applicationId UTF8String], flags));

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

- (GApplication*)castedGObject
{
	return G_APPLICATION([self gObject]);
}

- (void)activate
{
	g_application_activate([self castedGObject]);
}

- (void)addMainOptionWithLongName:(OFString*)longName shortName:(char)shortName flags:(GOptionFlags)flags arg:(GOptionArg)arg description:(OFString*)description argDescription:(OFString*)argDescription
{
	g_application_add_main_option([self castedGObject], [longName UTF8String], shortName, flags, arg, [description UTF8String], [argDescription UTF8String]);
}

- (void)addMainOptionEntries:(const GOptionEntry*)entries
{
	g_application_add_main_option_entries([self castedGObject], entries);
}

- (void)addOptionGroup:(GOptionGroup*)group
{
	g_application_add_option_group([self castedGObject], group);
}

- (void)bindBusyPropertyWithObject:(gpointer)object property:(OFString*)property
{
	g_application_bind_busy_property([self castedGObject], object, [property UTF8String]);
}

- (OFString*)applicationId
{
	const gchar* gobjectValue = g_application_get_application_id([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OGDBusConnection*)dbusConnection
{
	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_application_get_dbus_connection([self castedGObject]));

	OGDBusConnection* returnValue = [OGDBusConnection withGObject:gobjectValue];
	return returnValue;
}

- (OFString*)dbusObjectPath
{
	const gchar* gobjectValue = g_application_get_dbus_object_path([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GApplicationFlags)flags
{
	GApplicationFlags returnValue = g_application_get_flags([self castedGObject]);

	return returnValue;
}

- (guint)inactivityTimeout
{
	guint returnValue = g_application_get_inactivity_timeout([self castedGObject]);

	return returnValue;
}

- (bool)isBusy
{
	bool returnValue = g_application_get_is_busy([self castedGObject]);

	return returnValue;
}

- (bool)isRegistered
{
	bool returnValue = g_application_get_is_registered([self castedGObject]);

	return returnValue;
}

- (bool)isRemote
{
	bool returnValue = g_application_get_is_remote([self castedGObject]);

	return returnValue;
}

- (OFString*)resourceBasePath
{
	const gchar* gobjectValue = g_application_get_resource_base_path([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (void)hold
{
	g_application_hold([self castedGObject]);
}

- (void)markBusy
{
	g_application_mark_busy([self castedGObject]);
}

- (void)openWithFiles:(GFile**)files nfiles:(gint)nfiles hint:(OFString*)hint
{
	g_application_open([self castedGObject], files, nfiles, [hint UTF8String]);
}

- (void)quit
{
	g_application_quit([self castedGObject]);
}

- (bool)register:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_application_register([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)decreaseCount
{
	g_application_release([self castedGObject]);
}

- (int)runWithArgc:(int)argc argv:(char**)argv
{
	int returnValue = g_application_run([self castedGObject], argc, argv);

	return returnValue;
}

- (void)sendNotificationWithId:(OFString*)id notification:(OGNotification*)notification
{
	g_application_send_notification([self castedGObject], [id UTF8String], [notification castedGObject]);
}

- (void)setActionGroup:(GActionGroup*)actionGroup
{
	g_application_set_action_group([self castedGObject], actionGroup);
}

- (void)setApplicationId:(OFString*)applicationId
{
	g_application_set_application_id([self castedGObject], [applicationId UTF8String]);
}

- (void)setDefault
{
	g_application_set_default([self castedGObject]);
}

- (void)setFlags:(GApplicationFlags)flags
{
	g_application_set_flags([self castedGObject], flags);
}

- (void)setInactivityTimeout:(guint)inactivityTimeout
{
	g_application_set_inactivity_timeout([self castedGObject], inactivityTimeout);
}

- (void)setOptionContextDescription:(OFString*)description
{
	g_application_set_option_context_description([self castedGObject], [description UTF8String]);
}

- (void)setOptionContextParameterString:(OFString*)parameterString
{
	g_application_set_option_context_parameter_string([self castedGObject], [parameterString UTF8String]);
}

- (void)setOptionContextSummary:(OFString*)summary
{
	g_application_set_option_context_summary([self castedGObject], [summary UTF8String]);
}

- (void)setResourceBasePath:(OFString*)resourcePath
{
	g_application_set_resource_base_path([self castedGObject], [resourcePath UTF8String]);
}

- (void)unbindBusyPropertyWithObject:(gpointer)object property:(OFString*)property
{
	g_application_unbind_busy_property([self castedGObject], object, [property UTF8String]);
}

- (void)unmarkBusy
{
	g_application_unmark_busy([self castedGObject]);
}

- (void)withdrawNotification:(OFString*)id
{
	g_application_withdraw_notification([self castedGObject], [id UTF8String]);
}


@end