mv ~/.Xresources ~/.Xresources.bak || true &&

cat > ~/.Xresources << 'EOF'
Xft.dpi: 101
Xft.antialias: true
Xft.hinting: true
Xft.rgba: rgb
Xft.autohint: false
Xft.hintstyle: hintfull
Xft.lcdfilter: lcddefault
EOF

xrdb -merge ~/.Xresources

sudo bash -c 'cat > /etc/fonts/local.conf' << 'EOF'
<match target="font">
  <edit name="autohint" mode="assign">
    <bool>false</bool>
  </edit>
  <edit name="hinting" mode="assign">
    <bool>true</bool>
  </edit>
  <edit mode="assign" name="hintstyle">
    <const>hintfull</const>
  </edit>
  <edit mode="assign" name="lcdfilter">
   <const>lcddefault</const>
 </edit>
</match>
EOF

