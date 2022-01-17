FROM kalilinux/kali-rolling

RUN apt-get update
RUN apt-get install -y nmap git nginx curl wget golang gcc g++ apt-transport-https python3 python3-pip pass \
    s3fs zsh zsh-syntax-highlighting zsh-autosuggestions\
    exploitdb radare2 torsocks proxychains socat tmux \
    python2 python3 python3-pip mono-devel ansible \
    tree powershell netcat-traditional

RUN go get github.com/sirupsen/logrus github.com/gorilla/mux github.com/gcla/termshark

RUN cp /etc/skel/.zshrc /root/
RUN chsh -s /bin/zsh

RUN apt-get install -y seclists wordlists nishang gobuster ffuf smbmap sqlmap crackmapexec gospider \
    metasploit-framework shellter veil unicorn-magic tcpdump impacket-scripts responder

WORKDIR /root
RUN mkdir .git
WORKDIR /root/.git

RUN git clone --recurse https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite  &&\
    git clone --recurse https://github.com/sherlock-project/sherlock.git &&\
    git clone --recurse https://github.com/PowerShellMafia/PowerSploit.git &&\
    git clone --recurse https://github.com/GhostPack/Seatbelt.git &&\
    git clone --recurse https://github.com/samratashok/ADModule.git &&\
    git clone --recurse https://github.com/carlospolop/PEASS-ng.git &&\
    git clone --recurse https://github.com/oonray/BlackHatProgramming.git &&\
    git clone --recurse https://github.com/byt3bl33d3r/OffensiveDLR.git

WORKDIR /root

CMD ["while" "true;" "do" "sleep" "5;" "done"]
