#!/usr/bin/env fish

# http://yitang.uk/2021/06/18/managing-emacs-server-as-systemd-service

set system_config "$HOME/Developer/system-config"
set emacs_service "$system_config/emacs.d/emacs.service"
set systemd_service /etc/systemd/user/emacs.service

if not test -f $emacs_service
    echo "Error: $emacs_service not found."
    return 1
end

if test -e $systemd_service
    sudo rm $systemd_service
end

sudo ln -s $emacs_service $systemd_service

systemctl --user enable --now emacs.service
