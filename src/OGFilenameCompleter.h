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

/**
 * Completes partial file and directory names given a partial string by
 * looking in the file system for clues. Can return a list of possible
 * completion strings for widget implementations.
 *
 */
@interface OGFilenameCompleter : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)init;

/**
 * Methods
 */

- (GFilenameCompleter*)castedGObject;

/**
 * Obtains a completion for @initial_text from @completer.
 *
 * @param initialText text to be completed.
 * @return a completed string, or %NULL if no
 *     completion exists. This string is not owned by GIO, so remember to g_free()
 *     it when finished.
 */
- (char*)completionSuffix:(OFString*)initialText;

/**
 * Gets an array of completion strings for a given initial text.
 *
 * @param initialText text to be completed.
 * @return array of strings with possible completions for @initial_text.
 * This array must be freed by g_strfreev() when finished.
 */
- (char**)completions:(OFString*)initialText;

/**
 * If @dirs_only is %TRUE, @completer will only
 * complete directory names, and not file names.
 *
 * @param dirsOnly a #gboolean.
 */
- (void)setDirsOnly:(bool)dirsOnly;

@end