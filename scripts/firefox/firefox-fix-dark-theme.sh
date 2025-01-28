#Resolver o problema do tema escuro

cd ~/.mozilla/firefox/*.default 
mkdir chrome 
cd chrome 
cat > userContent.css << "EOF"

input:not(.urlbar-input):not(.textbox-input):not(.form-control):not([type='checkbox']) {
    -moz-appearance: none !important;
    background-color: white;
    color: black;
}
 
#downloads-indicator-counter {
    color: white;
}
 
textarea {
    -moz-appearance: none !important;
    background-color: white;
    color: black;
}
 
select {
    -moz-appearance: none !important;
    background-color: white;
    color: black;
}
EOF
