# Alias

# nu shells shortcut
alias s = shells
alias o = enter

alias proxy = (let-env http_proxy = "http://localhost:7890";
              let-env https_proxy = "http://localhost:7890")

alias unproxy = (let-env http_proxy = "";
                let-env https_proxy = "")
