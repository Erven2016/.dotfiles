# Nushell Config File

source ~/.dotfiles/nushell/custom.d/theme.nu # load themes
source ~/.dotfiles/nushell/custom.d/config.nu # load config
source ~/.dotfiles/nushell/custom.d/alias.nu # load alias

# load completions
source ~/.dotfiles/nushell/completion.d/git.nu
source ~/.dotfiles/nushell/completion.d/env.nu

# External completer example
# let carapace_completer = {|spans|
#     carapace $spans.0 nushell $spans | from json
# }

# import starship
if ((which starship) != []) {
  if ($env.STARSHIP_INIT_PATH | path exists) {
    source ~/.config/starship/init.nu
  }
}
