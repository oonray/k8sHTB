FROM kalilinux/kali-rolling
RUN apt-get update
RUN apt-get install -y nmap git emacs nginx curl wget golang gcc g++ apt-transport-https python3 python3-pip pass
RUN apt-get install -y s3fs zsh zsh-syntax-highlighting zsh-autosuggestions
RUN apt-get install -y exploitdb radare2 torsocks proxychains socat tmux
RUN apt-get install -y impacket-scripts python2 wordlists mono-devel ansible
RUN cp /etc/skel/.zshrc /root/
RUN chsh -s /bin/zsh

RUN apt-get install -y seclists nishang gobuster ffuf smbmap sqlmap crackmapexec gospider &&\
    apt-get install -y powershell-empire metasploit-framework shellter veil unicorn-magic

WORKDIR /root
RUN mkdir .git
WORKDIR /root/.git

RUN git clone --recurse https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite  &&\
    git clone --recurse https://github.com/SecureAuthCorp/impacket.git &&\
    git clone --recurse https://github.com/bats3c/shad0w.git &&\
    git clone --recurse https://github.com/lgandx/Responder.git &&\
    git clone --recurse https://github.com/sherlock-project/sherlock.git &&\
    git clone --recurse https://github.com/PowerShellMafia/PowerSploit.git &&\
    git clone --recurse https://github.com/GhostPack/Seatbelt.git &&\
    git clone --recurse https://github.com/samratashok/ADModule.git &&\
    git clone --recurse https://github.com/Sq00ky/LeetLinked &&\
    git clone https://github.com/oonray/Notes.git &&\

RUN ~/.emacs.d/bin/doom install
CMD ["while" "true;" "do" "sleep" "5;" "done"]
