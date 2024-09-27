/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>

#import <OGObject/OGObject.h>

/**
 * `GMountOperation` provides a mechanism for interacting with the user.
 * It can be used for authenticating mountable operations, such as loop
 * mounting files, hard drive partitions or server locations. It can
 * also be used to ask the user questions or show a list of applications
 * preventing unmount or eject operations from completing.
 * 
 * Note that `GMountOperation` is used for more than just [iface@Gio.Mount]
 * objects – for example it is also used in [method@Gio.Drive.start] and
 * [method@Gio.Drive.stop].
 * 
 * Users should instantiate a subclass of this that implements all the
 * various callbacks to show the required dialogs, such as
 * [`GtkMountOperation`](https://docs.gtk.org/gtk4/class.MountOperation.html).
 * If no user interaction is desired (for example when automounting
 * filesystems at login time), usually `NULL` can be passed, see each method
 * taking a `GMountOperation` for details.
 * 
 * Throughout the API, the term ‘TCRYPT’ is used to mean ‘compatible with TrueCrypt and VeraCrypt’.
 * [TrueCrypt](https://en.wikipedia.org/wiki/TrueCrypt) is a discontinued system for
 * encrypting file containers, partitions or whole disks, typically used with Windows.
 * [VeraCrypt](https://www.veracrypt.fr/) is a maintained fork of TrueCrypt with various
 * improvements and auditing fixes.
 *
 */
@interface OGMountOperation : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)init;

/**
 * Methods
 */

- (GMountOperation*)castedGObject;

/**
 * Check to see whether the mount operation is being used
 * for an anonymous user.
 *
 * @return %TRUE if mount operation is anonymous.
 */
- (bool)anonymous;

/**
 * Gets a choice from the mount operation.
 *
 * @return an integer containing an index of the user's choice from
 * the choice's list, or `0`.
 */
- (int)choice;

/**
 * Gets the domain of the mount operation.
 *
 * @return a string set to the domain.
 */
- (OFString*)domain;

/**
 * Check to see whether the mount operation is being used
 * for a TCRYPT hidden volume.
 *
 * @return %TRUE if mount operation is for hidden volume.
 */
- (bool)isTcryptHiddenVolume;

/**
 * Check to see whether the mount operation is being used
 * for a TCRYPT system volume.
 *
 * @return %TRUE if mount operation is for system volume.
 */
- (bool)isTcryptSystemVolume;

/**
 * Gets a password from the mount operation.
 *
 * @return a string containing the password within @op.
 */
- (OFString*)password;

/**
 * Gets the state of saving passwords for the mount operation.
 *
 * @return a #GPasswordSave flag.
 */
- (GPasswordSave)passwordSave;

/**
 * Gets a PIM from the mount operation.
 *
 * @return The VeraCrypt PIM within @op.
 */
- (guint)pim;

/**
 * Get the user name from the mount operation.
 *
 * @return a string containing the user name.
 */
- (OFString*)username;

/**
 * Emits the #GMountOperation::reply signal.
 *
 * @param result a #GMountOperationResult
 */
- (void)reply:(GMountOperationResult)result;

/**
 * Sets the mount operation to use an anonymous user if @anonymous is %TRUE.
 *
 * @param anonymous boolean value.
 */
- (void)setAnonymous:(bool)anonymous;

/**
 * Sets a default choice for the mount operation.
 *
 * @param choice an integer.
 */
- (void)setChoice:(int)choice;

/**
 * Sets the mount operation's domain.
 *
 * @param domain the domain to set.
 */
- (void)setDomain:(OFString*)domain;

/**
 * Sets the mount operation to use a hidden volume if @hidden_volume is %TRUE.
 *
 * @param hiddenVolume boolean value.
 */
- (void)setIsTcryptHiddenVolume:(bool)hiddenVolume;

/**
 * Sets the mount operation to use a system volume if @system_volume is %TRUE.
 *
 * @param systemVolume boolean value.
 */
- (void)setIsTcryptSystemVolume:(bool)systemVolume;

/**
 * Sets the mount operation's password to @password.
 *
 * @param password password to set.
 */
- (void)setPassword:(OFString*)password;

/**
 * Sets the state of saving passwords for the mount operation.
 *
 * @param save a set of #GPasswordSave flags.
 */
- (void)setPasswordSave:(GPasswordSave)save;

/**
 * Sets the mount operation's PIM to @pim.
 *
 * @param pim an unsigned integer.
 */
- (void)setPim:(guint)pim;

/**
 * Sets the user name within @op to @username.
 *
 * @param username input username.
 */
- (void)setUsername:(OFString*)username;

@end