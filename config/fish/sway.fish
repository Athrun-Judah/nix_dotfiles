# If running from tty1 and no display is running, start sway.
if status is-login
    if test -z "$DISPLAY" -a "$(tty)" = /dev/tty1
        exec sway
    end
end
