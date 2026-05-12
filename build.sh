rm -rf docs/*
saxonb-xslt -xsl:src/main.xsl -s:src/data/posts.xml -ext:on
cp src/global.css docs/global.css
