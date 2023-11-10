# PownMyHash
A simple script that automates password cracking with hashcat


# Install
```bash
apt update
apt install p7zip-full -y
rm -rf /usr/local/cuda-11.1/ /usr/local/cuda-11.2/ /usr/local/cuda-11.3/ /usr/local/cuda-11.4/ /usr/local/cuda-11.5/
mkdir -p /opt/hashcat/
mkdir -p /opt/dico/
mkdir -p /opt/pmh/stats/
touch /opt/pmh/.pownMyHash.dico
touch /opt/pmh/.training_ntlm.txt
wget https://raw.githubusercontent.com/1mm0rt41PC/pownMyHash/main/pownMyHash.sh -O /opt/pmh/pownMyHash.sh
chmod +x /opt/pmh/pownMyHash.sh
wget https://download.weakpass.com/wordlists/1947/weakpass_3.7z -O /opt/dico/weakpass_3.7z
7x x /opt/dico/weakpass_3.7z
rm /opt/dico/weakpass_3.7z
mv /opt/dico/weakpass* /opt/dico/weakpass.dico
curl https://hashcat.net/hashcat/ 2>/dev/null | grep -E '<a href="([^"]+.7z)' |head -n1 | sed -E 's/[^"]+"([^"]+)"[^\r\n]+/\1/g' | xargs -I '{}'  -t curl 'https://hashcat.net{}' --output /opt/hashcat.7z 2>/dev/null
7z x /opt/hashcat.7z
mv /opt/hashcat* /opt/hashcat/
rm /opt/hashcat.7z
touch /opt/hashcat/hashcat.potfile
wget https://github.com/NotSoSecure/password_cracking_rules/raw/master/OneRuleToRuleThemAll.rule -O /opt/hashcat/rules/OneRuleToRuleThemAll.rule
wget https://github.com/praetorian-inc/Hob0Rules/raw/master/hob064.rule -O /opt/hashcat/rules/hob064.rule
wget https://github.com/praetorian-inc/Hob0Rules/raw/master/d3adhob0.rule -O /opt/hashcat/rules/d3adhob0.rule
wget https://github.com/clem9669/hashcat-rule/raw/master/clem9669_large.rule -O /opt/hashcat/rules/clem9669_large.rule
wget https://github.com/piotrcki/wordlist/releases/download/v0.0.0/piotrcki-wordlist.txt.xz.part00 -O /opt/hashcat/dico/piotrcki-wordlist.txt.xz.part00
wget https://github.com/piotrcki/wordlist/releases/download/v0.0.0/piotrcki-wordlist.txt.xz.part01 -O /opt/hashcat/dico/piotrcki-wordlist.txt.xz.part01
cat /opt/hashcat/dico/piotrcki-wordlist.txt.xz.part00 /opt/hashcat/dico/piotrcki-wordlist.txt.xz.part01 > piotrcki-wordlist.txt.xz
rm /opt/hashcat/dico/piotrcki-wordlist.txt.xz.part00 /opt/hashcat/dico/piotrcki-wordlist.txt.xz.part01
xz -d /opt/hashcat/dico/piotrcki-wordlist.txt.xz
wget https://github.com/Unic0rn28/hashcat-rules/raw/main/unicorn%20rules/SuperUnicorn.rule -O /opt/hashcat/dico/SuperUnicorn.rule
wget https://github.com/rarecoil/pantagrule/raw/master/rules/hashesorg.v6/pantagrule.hashorg.v6.random.rule.gz -O /opt/hashcat/dico/pantagrule.hashorg.v6.random.rule.gz
7z x /opt/hashcat/dico/pantagrule.hashorg.v6.random.rule.gz


/opt/hashcat/hashcat.bin -b -m 1000
/opt/hashcat/hashcat.bin -b -m 2100
```

# Usage
```
Usage:
  /opt/pmh/pownMyHash.sh <hash-type> <hash-file>
  /opt/pmh/pownMyHash.sh test <dico-to-test> (will be tested against /opt/pmh/.training_ntlm.txt in NTLM)
  TEST_DICO=<dico-to-test> /opt/pmh/pownMyHash.sh <hash-type> <hash-file>

With:
  <hash-type>: The type of the hash (ex:1000 for NTLM, 5500 for NetNTLMv1, 5600 for NetNTLMv2). See hashcat --help
  <hash-file>: The file that contains the hashed passwords

Example:
  /opt/pmh/pownMyHash.sh ntlm myNtlmFile.txt
  /opt/pmh/pownMyHash.sh 1000 myNtlmFile.txt
```
