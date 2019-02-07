# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class roles_profiles::profiles::disable_services {

    case $::operatingsystem {
        'Darwin': {
            class { 'macos_apsd':
                running => false,
            }
        }
        'Windows': {
        $disbaled_services = ['wsearch', 'VSS', 'puppet']
            defined_classes::srv::disable_service { $disbaled_services :
            }
        }
        default: {
            fail("${::operatingsystem} not supported")
        }
    }


}
