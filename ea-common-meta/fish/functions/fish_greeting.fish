function fish_greeting 
        neofetch --color_blocks off

        # Print README
        [ -f '~/README' ]; and cat ~/README

	for file in (ls ~/.config/systemd/user 2>/dev/null | grep service)
	        SYSTEMD_COLORS=1 systemctl --user status -n 0 --no-pager $file |\
	        sed '/CGroup:/Q'

	        echo
	end
end
