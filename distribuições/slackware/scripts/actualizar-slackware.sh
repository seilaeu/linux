sudo slackpkg update; sudo slackpkg install-new; sudo slackpkg upgrade-all; sudo slackpkg clean-system; sudo sbocheck; sudo sboupgrade --all && echo
sudo find / -not -path '/proc*' -not -path '/run*' -xtype l && echo

