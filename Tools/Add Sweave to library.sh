



##### Mac OS Ventura #####

#//ref https://www.jason-french.com/blog/2013/08/16/easy-sweaving-for-latex-and-r/

# Go to TeX Live local directory
cd /usr/local/texlive/texmf-local/tex/latex/local

# Create a symbolic link between Sweave.sty and TeX Live
sudo ln -s /Library/Frameworks/R.framework/Resources/share/texmf/tex/latex Sweave

# Update TeX Live database
sudo mktexlsr





##### Linux Mint #####

# Go to TeX Live local directory
cd /usr/local/texlive/texmf-local/tex/latex/local

# Create a symbolic link between Sweave.sty and TeX Live
sudo ln -s /usr/share/R/share/texmf/tex/latex/Sweave.sty

# Update TeX Live database
sudo /usr/local/texlive/2023/bin/x86_64-linux/mktexlsr
