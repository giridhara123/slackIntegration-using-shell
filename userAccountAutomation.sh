#!/bin/bash
#,read -p "please enter username" username
set -x
#SLACK_WEB='https://hooks.slack.com/services/ENTER_YOUR_WEBHOOK_URL'
if [ $# -gt 0 ]; then
    USERNAME=$1

    EXISTING_USER=$(cat /etc/passwd | grep -i -w ${USERNAME} | cut -d ':' -f1)

    if [ "${USERNAME}" = "${EXISTING_USER}" ]; then
        echo "${EXISTING_USER} already exist try a differnet username"
    else
        echo "lets create the user${USERNAME}"
        useradd -m ${USERNAME} -s /bin/bash
        SPEC=$(echo '!@#$%^&*()_' | fold -1 | shuf | head -1);
        PASSWORD="India@${RANDOM}${SPEC}"
        echo "${USERNAME}:${PASSWORD}" | sudo chpasswd
        passwd -e ${USERNAME}
       # echo " the username is ${USERNAME} and password is ${PASSWORD}."
       #curl -X POST ${SLACK_WEB} -sL -H 'content-type: application/json' --data "{"text" : \"Username is: ${USERNAME}\"}" >>/dev/null
       #curl -X POST ${SLACK_WEB} -sL -H 'content-type: application/json' --data "{"text" : \"Temporary Password is: ${PASSWORD} Reset this password immediately.\"}" >>/dev/null
     curl -v -X POST '${SLACK_WEB}' \
     -H 'Content-Type: application/json' \
     --data "$(jq -n --arg user "$USERNAME" --arg pass "$PASSWORD" \
       '{text: "New user has been created!\nUsername: \($user)\nTemporary Password: \($pass)\nPlease reset this password immediately."}')"
    fi
else
    echo you have given $# arugument. okka argument evuu roo
fi
