#!/bin/bash

while true; do
    action=$(osascript <<EOF
button returned of (display dialog "Choose an action." \
with title "Base64" \
buttons {"Encode","Decode","Quit"} \
default button "Encode")
EOF
)

    if [ "$action" = "Quit" ]; then
        exit 0
    fi

    input=$(osascript <<EOF
text returned of (display dialog "Enter text:" \
with title "Base64 - $action" \
default answer "" \
buttons {"Cancel","OK"} \
default button "OK")
EOF
)

    if [ "$action" = "Encode" ]; then
        result=$(printf "%s" "$input" | base64)
    else
        result=$(printf "%s" "$input" | base64 -d 2>/dev/null)

        if [ $? -ne 0 ]; then
            result="Invalid Base64 input."
        fi
    fi

    next=$(osascript <<EOF
button returned of (display dialog "$result" \
with title "Result" \
buttons {"Home","Quit"} \
default button "Home")
EOF
)

    if [ "$next" = "Quit" ]; then
        exit 0
    fi
done