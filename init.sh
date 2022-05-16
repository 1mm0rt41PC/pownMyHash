#!/bin/bash
mkdir -p /opt/hashcat/
mkdir -p /opt/hashcat/rules/
mkdir -p /opt/dico/
mkdir -p /opt/pmh/stats/

touch /opt/pmh/.pownMyHash.dico
touch /opt/pmh/.training_ntlm.txt
touch /opt/hashcat/hashcat.potfile

# Install pownMyHash
wget https://raw.githubusercontent.com/1mm0rt41PC/pownMyHash/main/pownMyHash.sh -O /opt/pmh/pownMyHash.sh
chmod +x /opt/pmh/pownMyHash.sh

# Install hashcat
curl https://hashcat.net/hashcat/ 2>/dev/null | grep -E '<a href="([^"]+.7z)' |head -n1 | sed -E 's/[^"]+"([^"]+)"[^\r\n]+/\1/g' | xargs -I '{}'  -t curl 'https://hashcat.net{}' --output /opt/hashcat.7z 2>/dev/null
7z x /opt/hashcat.7z
mv /opt/hashcat* /opt/hashcat/
rm /opt/hashcat.7z

# Install rules
wget https://github.com/NotSoSecure/password_cracking_rules/raw/master/OneRuleToRuleThemAll.rule -O /opt/hashcat/rules/OneRuleToRuleThemAll.rule
wget https://github.com/praetorian-inc/Hob0Rules/raw/master/hob064.rule -O /opt/hashcat/rules/hob064.rule
wget https://github.com/praetorian-inc/Hob0Rules/raw/master/d3adhob0.rule -O /opt/hashcat/rules/d3adhob0.rule

# Test hashcat
/opt/hashcat/hashcat.bin -b -m 1000
/opt/hashcat/hashcat.bin -b -m 2100

# Download weakpass
wget https://download.weakpass.com/wordlists/1947/weakpass_3.7z -O /opt/dico/weakpass_3.7z
7x x /opt/dico/weakpass_3.7z
rm /opt/dico/weakpass_3.7z
mv /opt/dico/weakpass* /opt/dico/weakpass.dico
