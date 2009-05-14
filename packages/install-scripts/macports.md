#nstall MacPorts from source with: ./configure --prefix /opt/mp
#Add /opt/mp/bin to the end of /etc/paths

sudo port install curl +doc +ssl

sudo port install subversion +bash_completion +tools +unicode_path
sudo port install git-core +bash_completion +doc +svn

sudo port install coreutils findutils
sudo port install wireshark
sudo port install grc
sudo port install dos2unix
sudo port install gnupg

sudo port install docbook-xml docbook-xsl
sudo port install libxslt
sudo port install fop
