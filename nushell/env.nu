# Nushell Environment Config File

let STARSHIP_PATH = "~/.config/starship/"

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# nushell-config-dir
let-env NU_CONFIG_DIRS = ($nu.config-path | path dirname)

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')


# set default locle to en_US.UTF-8
if (env | where name == LANG) == [] and (env | where name == LC_ALL) == [] {
  let-env LANG = "en_US.UTF-8"
  let-env LC_ALL = "en_US.UTF-8"
}

# STARSHIP
if ($"(which starship)" != []) {
  let-env STARSHIP_CONFIG_PATH = $"($STARSHIP_PATH)config.toml"
  let-env STARSHIP_INIT_PATH = $"($STARSHIP_PATH)init.nu"

  # create starship configuration file
  if not ($env.STARSHIP_INIT_PATH | path exists) {
    mkdir ~/.config/starship
    starship init nu | save -f ~/.config/starship/init.nu # TODO: imporve this path
  }
} else {
# If starship is not executable then use default prompt of nushell
def create_left_prompt [] {
    let os_name = $"(sys | get host | get name)"

    let hostname = $"(ansi green_bold)(sys | get host | get hostname)"
    let username = if ($os_name == "Windows") {
      $"@($env.USERNAME)"
    } else {
      $"@(whoami)"
    }

    let path_segment = if (is-admin) {
        $"(ansi blue_bold)($env.PWD) (ansi red_bold)# "
    } else {
        $"(ansi blue_bold)($env.PWD) (ansi blue_bold)$ "
    }

    $hostname + $username + " " + $path_segment
}

def create_right_prompt [] {
    # let time_segment = ([
    #     (date now | date format '%m/%d/%Y %r')
    # ] | str join)
    #
    # $time_segment
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { ">" } # { "〉" }
let-env PROMPT_INDICATOR_VI_INSERT = { "" }
let-env PROMPT_INDICATOR_VI_NORMAL = { "" }
let-env PROMPT_MULTILINE_INDICATOR = { "" }
}

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}
