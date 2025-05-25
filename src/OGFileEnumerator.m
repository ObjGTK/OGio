/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFileEnumerator.h"

#import "OGCancellable.h"
#import "OGFileInfo.h"

@implementation OGFileEnumerator

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_FILE_ENUMERATOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_FILE_ENUMERATOR);
	return gObjectClass;
}

- (GFileEnumerator*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_FILE_ENUMERATOR, GFileEnumerator);
}

- (bool)closeWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_file_enumerator_close((GFileEnumerator*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_file_enumerator_close_async((GFileEnumerator*)[self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)closeFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_file_enumerator_close_finish((GFileEnumerator*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GFile*)childWithInfo:(OGFileInfo*)info
{
	GFile* returnValue = (GFile*)g_file_enumerator_get_child((GFileEnumerator*)[self castedGObject], [info castedGObject]);

	return returnValue;
}

- (GFile*)container
{
	GFile* returnValue = (GFile*)g_file_enumerator_get_container((GFileEnumerator*)[self castedGObject]);

	return returnValue;
}

- (bool)hasPending
{
	bool returnValue = (bool)g_file_enumerator_has_pending((GFileEnumerator*)[self castedGObject]);

	return returnValue;
}

- (bool)isClosed
{
	bool returnValue = (bool)g_file_enumerator_is_closed((GFileEnumerator*)[self castedGObject]);

	return returnValue;
}

- (bool)iterateWithOutInfo:(GFileInfo**)outInfo outChild:(GFile**)outChild cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_file_enumerator_iterate((GFileEnumerator*)[self castedGObject], outInfo, outChild, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OGFileInfo*)nextFileWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GFileInfo* gobjectValue = g_file_enumerator_next_file((GFileEnumerator*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGFileInfo* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)nextFilesAsyncWithNumFiles:(int)numFiles ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_file_enumerator_next_files_async((GFileEnumerator*)[self castedGObject], numFiles, ioPriority, [cancellable castedGObject], callback, userData);
}

- (GList*)nextFilesFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GList* returnValue = (GList*)g_file_enumerator_next_files_finish((GFileEnumerator*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)setPending:(bool)pending
{
	g_file_enumerator_set_pending((GFileEnumerator*)[self castedGObject], pending);
}


@end