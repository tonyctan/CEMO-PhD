#//ref https://www.jason-french.com/blog/2013/08/16/easy-sweaving-for-latex-and-r/

# Go to TeX Live local directory
cd /usr/local/texlive/texmf-local/tex/latex/local

# Create a symbolic lini between Sweave.sty and TeX Live
sudo ln -s /Library/Frameworks/R.framework/Resources/share/texmf/tex/latex Sweave

# Update TeX Live database
sudo mktexlsr
