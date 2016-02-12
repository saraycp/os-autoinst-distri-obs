# Copyright (C) 2014 SUSE Linux GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use base "basetest";
use strict;
use testapi;

sub run {
    # wait for bootloader to appear
    #assert_screen "bootloader", 30;
    assert_screen "bootloader_qcow", 30;
    # press enter to boot right away
    #send_key "down";

    send_key "ret";
    # wait for the destroy all data on disk to appear
    #assert_screen "prompt", 300;
    #send_key "ret";    
    
    assert_screen "login", 500;
    sleep(1);
    type_string "root";
    send_key "ret";
    sleep(1);
    type_string "opensuse";
    type_string "\n";
    sleep(2);
    if (check_screen "network_failed") {
        record_soft_failure;
    }

}
sub test_flags {
    # without anything - rollback to 'lastgood' snapshot if failed
    # 'fatal' - whole test suite is in danger if this fails
    # 'milestone' - after this test succeeds, update 'lastgood'
    # 'important' - if this fails, set the overall state to 'fail'
    return { fatal => 1 };
}

1;

# vim: set sw=4 et:
