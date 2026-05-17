<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="page">
        <xsl:param name="filename" />
        <xsl:param name="title" />
        <xsl:param name="content" />

        <xsl:result-document method="html" encoding="utf-8" href="docs/{$filename}.html">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html>
                <head>
                    <title><xsl:value-of select="$title" /></title>
                    <link rel="icon" href="avatars.githubusercontent.com/u/93013772" type="image/png" />
                    <link rel="stylesheet" href="/global.css" />
                </head>
                
                <body>
                    <xsl:include href="navbar.html" />

                    <main>
                        <xsl:copy-of select="$content" />
                    </main>

                    <xsl:include href="footer.html" />
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
