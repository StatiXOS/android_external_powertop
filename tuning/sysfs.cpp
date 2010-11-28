/*
 * Copyright 2010, Intel Corporation
 *
 * This file is part of PowerTOP
 *
 * This program file is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program in a file named COPYING; if not, write to the
 * Free Software Foundation, Inc,
 * 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 * or just google for it.
 *
 * Authors:
 *	Arjan van de Ven <arjan@linux.intel.com>
 */

#include "tuning.h"
#include "tunable.h"
#include "unistd.h"
#include "sysfs.h"
#include <string.h>
#include <utility>
#include <iostream>
#include <fstream>


sysfs_tunable::sysfs_tunable(const char *str, const char *_sysfs_path, const char *_target_content) : tunable(str, 1.0, "Good", "Bad", "Unknown")
{
	strcpy(sysfs_path, _sysfs_path);
	strcpy(target_value, _target_content);
}

int sysfs_tunable::good_bad(void)
{
	char current_value[4096], *c;
	ifstream file;

	file.open(sysfs_path, ios::in);
	if (!file)
		return TUNE_NEUTRAL;
	file.getline(current_value, 4096);
	file.close();

	c = strchr(current_value, '\n');
	if (c)
		*c = 0;

	if (strcmp(current_value, target_value) == 0)
		return TUNE_GOOD;

	return TUNE_BAD;
}


void add_sysfs_tunable(const char *str, const char *_sysfs_path, const char *_target_content)
{
	class sysfs_tunable *tunable;

	if (access(_sysfs_path, R_OK) != 0)
		return;

	tunable = new class sysfs_tunable(str, _sysfs_path, _target_content);


	all_tunables.push_back(tunable);
}
