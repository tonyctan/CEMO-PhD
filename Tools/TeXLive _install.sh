# Remove old TeXLive installations
sudo apt-get purge texlive*;
sudo rm -rf /usr/local/texlive/*;
rm -rf ~/.texlive*;
sudo rm -rf /usr/local/share/texmf;
sudo rm -rf /var/lib/texmf;
sudo rm -rf /ect/texmf;
sudo apt-get remove tex-common --purge;
rm -rf ~/.texlive;
find -L /usr/local/bin -lname /usr/local/texlive/*/bin/* | xargs rm;
find -L /usr/local/bin/ -lname /usr/local/texlive/*/bin/* | sudo xargs rm;


# Remove any failed attempt at installing TeXLive
rm -rf /usr/local/texlive;
rm -rf ~/.texlive*;

# Download the latest TexLive installer
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xvf install-tl-unx.tar.gz;

# Manually create the receiving folder and make it writable
sudo mkdir /usr/local/texlive;
sudo chmod -R 777 /usr/local/texlive;

# Install TeXLive
cd install-tl-20*;
perl ./install-tl;

# Read the screen prompt
# Press "I"

# Remove installer and auxillary files
cd;
rm install-tl-unx.tar.gz;
rm -rf install-tl-20*;

# Add TeXLive to system path (if permission denied, do manually)
sudo echo "
    export PATH=/usr/local/texlive/2023/bin/x86_64-linux:$PATH
    export MANPATH=/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH
    export INFOPATH=/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH
" >> /etc/profile.d/texlive2023.sh;
