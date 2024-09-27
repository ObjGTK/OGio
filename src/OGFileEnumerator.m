/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFileEnumerator.h"

#import "OGFileInfo.h"
#import "OGCancellable.h"

@implementation OGFileEnumerator

- (GFileEnumerator*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GFileEnumerator, GFileEnumerator);
}

- (bool)close:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_file_enumerator_close([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_file_enumerator_close_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)closeFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = g_file_enumerator_close_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GFile*)child:(OGFileInfo*)info
{
	GFile* returnValue = g_file_enumerator_get_child([self castedGObject], [info castedGObject]);

	return returnValue;
}

- (GFile*)container
{
	GFile* returnValue = g_file_enumerator_get_container([self castedGObject]);

	return returnValue;
}

- (bool)hasPending
{
	bool returnValue = g_file_enumerator_has_pending([self castedGObject]);

	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = g_file_enumerator_is_closed([self castedGObject]);

	return returnValue;
}

- (bool)iterateWithOutInfo:(GFileInfo**)outInfo outChild:(GFile**)outChild cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_file_enumerator_iterate([self castedGObject], outInfo, outChild, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (OGFileInfo*)nextFile:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GFileInfo* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_file_enumerator_next_file([self castedGObject], [cancellable castedGObject], &err), GFileInfo, GFileInfo);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGFileInfo* returnValue = [OGFileInfo withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)nextFilesAsyncWithNumFiles:(int)numFiles ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_file_enumerator_next_files_async([self castedGObject], numFiles, ioPriority, [cancellable castedGObject], callback, userData);
}

- (GList*)nextFilesFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GList* returnValue = g_file_enumerator_next_files_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)setPending:(bool)pending
{
	g_file_enumerator_set_pending([self castedGObject], pending);
}


@end