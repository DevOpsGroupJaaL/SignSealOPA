package opablog

import data.policy_data as policies

default allow=false
allow=true{
    input.group == policies.GroupPermissions[input.resource][_]
}
