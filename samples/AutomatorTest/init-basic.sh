#!/bin/sh
# Basic init script without git publishing (production dir)

# Create dbs
echo "CREATE DATABASE acs_bicho_automatortest_1938 CHARACTER SET utf8 COLLATE utf8_unicode_ci" | mysql -u root
echo "CREATE DATABASE acs_cvsanaly_automatortest_1938 CHARACTER SET utf8 COLLATE utf8_unicode_ci" | mysql -u root
echo "CREATE DATABASE acs_gerrit_automatortest_1938 CHARACTER SET utf8 COLLATE utf8_unicode_ci" | mysql -u root
echo "CREATE DATABASE acs_irc_automatortest_1938 CHARACTER SET utf8 COLLATE utf8_unicode_ci" | mysql -u root

# Clone SCM repos
cd scm
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/OpenID
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SolrStore
cd ..

# Download IRC logs
cd irc
wget http://bots.wmflabs.org/~wm-bot/logs/%23wikimedia-analytics/%23wikimedia-analytics.tar.gz
wget http://bots.wmflabs.org/~wm-bot/logs/%23wikimedia-fundraising/%23wikimedia-fundraising.tar.gz
mkdir wikimedia-analytics
mkdir wikimedia-fundraising
cd wikimedia-analytics/
tar xfz ../#wikimedia-analytics.tar.gz
cd ..
cd wikimedia-fundraising
tar xfz ../#wikimedia-fundraising.tar.gz
cd ../..

# Download tools
cd tools
git clone https://github.com/VizGrimoire/VizGrimoireR.git
mkdir r-lib
cd VizGrimoireR
R CMD INSTALL -l ../r-lib vizgrimoire
cd ..

# DBs
mkdir -p ../production/browser/data/db/
cd ..

# Global dir with automator
cd ..
echo ./launch.py -d `pwd`/AutomatorTest 