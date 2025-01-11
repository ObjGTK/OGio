/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

@class OGCancellable;
@class OGFileInfo;

/**
 * `GFileEnumerator` allows you to operate on a set of [iface@Gio.File] objects,
 * returning a [class@Gio.FileInfo] structure for each file enumerated (e.g.
 * [method@Gio.File.enumerate_children] will return a `GFileEnumerator` for each
 * of the children within a directory).
 * 
 * To get the next file's information from a `GFileEnumerator`, use
 * [method@Gio.FileEnumerator.next_file] or its asynchronous version,
 * [method@Gio.FileEnumerator.next_files_async]. Note that the asynchronous
 * version will return a list of [class@Gio.FileInfo] objects, whereas the
 * synchronous will only return the next file in the enumerator.
 * 
 * The ordering of returned files is unspecified for non-Unix
 * platforms; for more information, see [method@GLib.Dir.read_name].  On Unix,
 * when operating on local files, returned files will be sorted by
 * inode number.  Effectively you can assume that the ordering of
 * returned files will be stable between successive calls (and
 * applications) assuming the directory is unchanged.
 * 
 * If your application needs a specific ordering, such as by name or
 * modification time, you will have to implement that in your
 * application code.
 * 
 * To close a `GFileEnumerator`, use [method@Gio.FileEnumerator.close], or
 * its asynchronous version, [method@Gio.FileEnumerator.close_async]. Once
 * a `GFileEnumerator` is closed, no further actions may be performed
 * on it, and it should be freed with [method@GObject.Object.unref].
 *
 */
@interface OGFileEnumerator : OGObject
{

}


/**
 * Methods
 */

- (GFileEnumerator*)castedGObject;

/**
 * Releases all resources used by this enumerator, making the
 * enumerator return %G_IO_ERROR_CLOSED on all calls.
 * 
 * This will be automatically called when the last reference
 * is dropped, but you might want to call this function to make
 * sure resources are released as early as possible.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return #TRUE on success or #FALSE on error.
 */
- (bool)close:(OGCancellable*)cancellable;

/**
 * Asynchronously closes the file enumerator.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned in
 * g_file_enumerator_close_finish().
 *
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)closeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes closing a file enumerator, started from g_file_enumerator_close_async().
 * 
 * If the file enumerator was already closed when g_file_enumerator_close_async()
 * was called, then this function will report %G_IO_ERROR_CLOSED in @error, and
 * return %FALSE. If the file enumerator had pending operation when the close
 * operation was started, then this function will report %G_IO_ERROR_PENDING, and
 * return %FALSE.  If @cancellable was not %NULL, then the operation may have been
 * cancelled by triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be set, and %FALSE will be
 * returned.
 *
 * @param result a #GAsyncResult.
 * @return %TRUE if the close operation has finished successfully.
 */
- (bool)closeFinish:(GAsyncResult*)result;

/**
 * Return a new #GFile which refers to the file named by @info in the source
 * directory of @enumerator.  This function is primarily intended to be used
 * inside loops with g_file_enumerator_next_file().
 * 
 * To use this, %G_FILE_ATTRIBUTE_STANDARD_NAME must have been listed in the
 * attributes list used when creating the #GFileEnumerator.
 * 
 * This is a convenience method that's equivalent to:
 * |[<!-- language="C" -->
 *   gchar *name = g_file_info_get_name (info);
 *   GFile *child = g_file_get_child (g_file_enumerator_get_container (enumr),
 *                                    name);
 * ]|
 *
 * @param info a #GFileInfo gotten from g_file_enumerator_next_file()
 *   or the async equivalents.
 * @return a #GFile for the #GFileInfo passed it.
 */
- (GFile*)child:(OGFileInfo*)info;

/**
 * Get the #GFile container which is being enumerated.
 *
 * @return the #GFile which is being enumerated.
 */
- (GFile*)container;

/**
 * Checks if the file enumerator has pending operations.
 *
 * @return %TRUE if the @enumerator has pending operations.
 */
- (bool)hasPending;

/**
 * Checks if the file enumerator has been closed.
 *
 * @return %TRUE if the @enumerator is closed.
 */
- (bool)isClosed;

/**
 * This is a version of g_file_enumerator_next_file() that's easier to
 * use correctly from C programs.  With g_file_enumerator_next_file(),
 * the gboolean return value signifies "end of iteration or error", which
 * requires allocation of a temporary #GError.
 * 
 * In contrast, with this function, a %FALSE return from
 * g_file_enumerator_iterate() *always* means
 * "error".  End of iteration is signaled by @out_info or @out_child being %NULL.
 * 
 * Another crucial difference is that the references for @out_info and
 * @out_child are owned by @direnum (they are cached as hidden
 * properties).  You must not unref them in your own code.  This makes
 * memory management significantly easier for C code in combination
 * with loops.
 * 
 * Finally, this function optionally allows retrieving a #GFile as
 * well.
 * 
 * You must specify at least one of @out_info or @out_child.
 * 
 * The code pattern for correctly using g_file_enumerator_iterate() from C
 * is:
 * 
 * |[
 * direnum = g_file_enumerate_children (file, ...);
 * while (TRUE)
 *   {
 *     GFileInfo *info;
 *     if (!g_file_enumerator_iterate (direnum, &info, NULL, cancellable, error))
 *       goto out;
 *     if (!info)
 *       break;
 *     ... do stuff with "info"; do not unref it! ...
 *   }
 * 
 * out:
 *   g_object_unref (direnum); // Note: frees the last @info
 * ]|
 *
 * @param outInfo Output location for the next #GFileInfo, or %NULL
 * @param outChild Output location for the next #GFile, or %NULL
 * @param cancellable a #GCancellable
 * @return
 */
- (bool)iterateWithOutInfo:(GFileInfo**)outInfo outChild:(GFile**)outChild cancellable:(OGCancellable*)cancellable;

/**
 * Returns information for the next file in the enumerated object.
 * Will block until the information is available. The #GFileInfo
 * returned from this function will contain attributes that match the
 * attribute string that was passed when the #GFileEnumerator was created.
 * 
 * See the documentation of #GFileEnumerator for information about the
 * order of returned files.
 * 
 * On error, returns %NULL and sets @error to the error. If the
 * enumerator is at the end, %NULL will be returned and @error will
 * be unset.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return A #GFileInfo or %NULL on error
 *    or end of enumerator.  Free the returned object with
 *    g_object_unref() when no longer needed.
 */
- (OGFileInfo*)nextFile:(OGCancellable*)cancellable;

/**
 * Request information for a number of files from the enumerator asynchronously.
 * When all I/O for the operation is finished the @callback will be called with
 * the requested information.
 * 
 * See the documentation of #GFileEnumerator for information about the
 * order of returned files.
 * 
 * Once the end of the enumerator is reached, or if an error occurs, the
 * @callback will be called with an empty list. In this case, the previous call
 * to g_file_enumerator_next_files_async() will typically have returned fewer
 * than @num_files items.
 * 
 * If a request is cancelled the callback will be called with
 * %G_IO_ERROR_CANCELLED.
 * 
 * This leads to the following pseudo-code usage:
 * |[
 * g_autoptr(GFile) dir = get_directory ();
 * g_autoptr(GFileEnumerator) enumerator = NULL;
 * g_autolist(GFileInfo) files = NULL;
 * g_autoptr(GError) local_error = NULL;
 * 
 * enumerator = yield g_file_enumerate_children_async (dir,
 *                                                     G_FILE_ATTRIBUTE_STANDARD_NAME ","
 *                                                     G_FILE_ATTRIBUTE_STANDARD_TYPE,
 *                                                     G_FILE_QUERY_INFO_NONE,
 *                                                     G_PRIORITY_DEFAULT,
 *                                                     cancellable,
 *                                                     …,
 *                                                     &local_error);
 * if (enumerator == NULL)
 *   g_error ("Error enumerating: %s", local_error->message);
 * 
 * // Loop until no files are returned, either because the end of the enumerator
 * // has been reached, or an error was returned.
 * do
 *   {
 *     files = yield g_file_enumerator_next_files_async (enumerator,
 *                                                       5,  // number of files to request
 *                                                       G_PRIORITY_DEFAULT,
 *                                                       cancellable,
 *                                                       …,
 *                                                       &local_error);
 * 
 *     // Process the returned files, but don’t assume that exactly 5 were returned.
 *     for (GList *l = files; l != NULL; l = l->next)
 *       {
 *         GFileInfo *info = l->data;
 *         handle_file_info (info);
 *       }
 *   }
 * while (files != NULL);
 * 
 * if (local_error != NULL &&
 *     !g_error_matches (local_error, G_IO_ERROR, G_IO_ERROR_CANCELLED))
 *   g_error ("Error while enumerating: %s", local_error->message);
 * ]|
 * 
 * During an async request no other sync and async calls are allowed, and will
 * result in %G_IO_ERROR_PENDING errors.
 * 
 * Any outstanding I/O request with higher priority (lower numerical value) will
 * be executed before an outstanding request with lower priority. Default
 * priority is %G_PRIORITY_DEFAULT.
 *
 * @param numFiles the number of file info objects to request
 * @param ioPriority the [I/O priority][io-priority] of the request
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)nextFilesAsyncWithNumFiles:(int)numFiles ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes the asynchronous operation started with g_file_enumerator_next_files_async().
 *
 * @param result a #GAsyncResult.
 * @return a #GList of #GFileInfos. You must free the list with
 *     g_list_free() and unref the infos with g_object_unref() when you're
 *     done with them.
 */
- (GList*)nextFilesFinish:(GAsyncResult*)result;

/**
 * Sets the file enumerator as having pending operations.
 *
 * @param pending a boolean value.
 */
- (void)setPending:(bool)pending;

@end