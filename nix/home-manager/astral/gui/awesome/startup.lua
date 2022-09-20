local awful = require 'awful'

local run_always = {
    "pkill picom; picom",
}

local run_once = {
    "/usr/lib/geoclue-2.0/demos/agent",
    "sh -c '(ps cax | grep redshift-gtk) || redshift-gtk'",
    "sh -c 'LC_ALL=C flameshot'",
    "nm-applet"
}


function spawn_startup_programs()
    for _, cmd in pairs(run_once) do 
        awful.spawn.single_instance(cmd)
    end

    for _, cmd in pairs(run_always) do 
        awful.spawn(cmd)
    end 
end 

return { spawn_startup_programs = spawn_startup_programs }

