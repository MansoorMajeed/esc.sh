#!/bin/bash
# version: 2024021813
# A quick and dirty script to fix Slack loading problem with KDE Plasma

while [[ -z ${slack_magic} ]]
do
        echo -n 'Searching for Slack magic .. '
        slack_magic=`ps aux | grep '[s]lack' | grep magic`
        sleep 1
        [[ -z ${slack_magic} ]] && echo -ne 'cannot find Slack magic\033[0K\r' || echo -ne 'got Slack magic\033[0K\n'
done
echo 'Slack magic found is ('${slack_magic}')'
[[ ${slack_magic} =~ slack://([^/]*)(/.*) ]] && echo 'Corrected workspace id as slack://'${BASH_REMATCH[1]^^}${BASH_REMATCH[2]}' relaunch with slack --enable-crashpad' || echo 'Slack magic does not contain expected pattern slack://<slack_magic>/magic-login/<some_string>'
