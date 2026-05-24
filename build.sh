wget -P /tmp/saxon https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-9/SaxonHE12-9J.zip
unzip -o /tmp/saxon /tmp/saxon

java -jar /tmp/saxon/saxon-he-12.9.jar -xsl:src/main.xsl -s:src/data/posts.xml -ext:on
cp src/global.css docs/global.css
