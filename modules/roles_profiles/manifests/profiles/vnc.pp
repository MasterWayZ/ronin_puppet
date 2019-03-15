# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class roles_profiles::profiles::vnc {

    case $::operatingsystem {
        'Windows': {

            $package  = 'UltraVnc'
            $msi      = 'UltraVnc_1223_X64.msi'
            $ini_file = "${facts['custom_win_programfiles']}\\unvc bvba\\UltraVNC\\ultravnc.ini"
            $port     = 5900
            $pw_hash  = lookup('win_vncpw_hash')

            $mdc1_jh1          = lookup('win_mdc1_jh1_ip')
            $mdc1_jh2          = lookup('win_mdc1_jh2_ip')
            $mdc2_jh1          = lookup('win_mdc2_jh1_ip')
            $mdc2_jh2          = lookup('win_mdc2_jh2_ip')
            $jumphosts         = $facts['custom_win_mozspace'] ? {
                mdc1    => "${mdc1_jh1},${mdc1_jh2}",
                mdc2    => "${mdc2_jh1},${mdc2_jh2}",
                default => '0.0.0.0',
            }

            if $jumphosts == '0.0.0.0' {
                warning('Unable to determine jumphosts for this location!')
            }
            class { 'win_ultravnc':
                package   => $package,
                msi       => $msi,
                ini_file  => $ini_file,
                pw_hash   => $pw_hash,
                port      => $port,
                jumphosts => $jumphosts,
            }
            # Bug List
            #
            # TODO Add 32 bit support
        }
        default: {
            fail("${::operatingsystem} not supported")
        }
    }
}
