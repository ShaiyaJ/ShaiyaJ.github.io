<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="page">
        <xsl:param name="filename" />
        <xsl:param name="title" />
        <xsl:param name="content" />

        <xsl:result-document href="docs/{$filename}.html">
            <html>
                <head>
                    <title><xsl:value-of select="$title" /></title>
                </head>
                
                <body>
                    <xsl:call-template name="navbar" />

                    <main>
                        <xsl:copy-of select="$content" />
                    </main>

                    <xsl:call-template name="footer" />
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
