#!/bin/bash
sudo echo "Installation vsdocker"

# Création du fichier des alias 
alias_file="$HOME/.dockcode-alias"
echo "- création fichier alias: $alias_file"
echo "# - ALIAS dockcode ----------
alias dockcode=\"docker run --rm -d \\
    --user \$(id -u):\$(id -g) \\
    -v \${HOME}:/home/\$(whoami):rw \\
    -v /srv:/srv:rw \\
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \\
    -v /srv/vsdocker/.vscode:/home/\$(whoami)/.vscode:rw \\
    -v /srv/vsdocker/.config/Code:/home/\$(whoami)/.config/Code:rw \\
    -v /var/run/docker.sock:/var/run/docker.sock:rw \\
    -v \$(which docker):/usr/bin/docker:ro \\
    -v \$(which docker-compose):/usr/bin/docker-compose:ro \\
    --network=host \\
    -e DISPLAY=unix\${DISPLAY} \\
    -e HOME=/home/\$(whoami) \\
    -w /home/\$(whoami) \\
    crashzeus/vsdocker:stable launch > /dev/null\"

# - ALIAS TTY-dockcode -------
alias tty-dockcode=\"docker run -it --rm \\
    --user \$(id -u):\$(id -g) \\
    -v \${HOME}:/home/\$(whoami):rw \\
    -v /srv:/srv:rw \\
    -v /srv/vsdocker/.vscode:/home/\$(whoami)/.vscode:rw \\
    -v /srv/vsdocker/.config/Code:/home/\$(whoami)/.config/Code:rw \\
    -v /var/run/docker.sock:/var/run/docker.sock:rw \\
    -v \$(which docker):/usr/bin/docker:ro \\
    -v \$(which docker-compose):/usr/bin/docker-compose:ro \\
    --network=host \\
    -e HOME=/home/\$(whoami) \\
    -w /home/\$(whoami) \\
    crashzeus/vsdocker:stable \"
" > $alias_file

# Création du raccourci launcher
desktop_file="/usr/share/applications/dockcode.desktop"
echo "- création fichier : $desktop_file"
echo "[Desktop Entry]
Name=Docker-VSCode
Comment=Code Editing. Redefined. Dockerise.
GenericName=Text Editor
Exec=dockcode
Icon=com.visualstudio.code
Type=Application
StartupNotify=false
StartupWMClass=Code
Categories=Utility;TextEditor;Development;IDE;
MimeType=text/plain;inode/directory;application/x-code-workspace;
Actions=new-empty-window;
Keywords=dockcode;
X-Desktop-File-Install-Version=0.24

[Desktop Action new-empty-window]
Name=New Empty Window
Exec=dockcode
Icon=com.visualstudio.code
" > /tmp/dockcode.desktop
sudo mv /tmp/dockcode.desktop $desktop_file

# Création du raccourci launcher
bashrcFile="$HOME/.bashrc"
aliasSrc="source $alias_file"
if grep -q "$aliasSrc" "$bashrcFile"; then
  echo "- chargement alias déja présent dans .bashrc"
else
  printf "\n$aliasSrc\n\n" >> $bashrcFile
  echo "- chargement alias ajouté dans .bashrc"
fi  