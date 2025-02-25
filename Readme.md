#SLACK Integration with webHook using shell script
Automate user Account Creation Using Shell Scripting
steps:
1. take input of username
2. Check if the user already exits. if exists, propose a new username
3. Generate random passwords with numbers and special characters
4. expire the password and force the user to change the password after the first login

#Integrate user information as a message to SLACK using icoming webhooks

using curl command:
curl -v -X POST '${SLACK_WEBhook url}' \
     -H 'Content-Type: application/json' \
     --data "$(jq -n --arg user "$USERNAME" --arg pass "$PASSWORD" \
       '{text: "New user has been created!\nUsername: \($user)\nTemporary Password: \($pass)\nPlease reset this password immediately."}')"