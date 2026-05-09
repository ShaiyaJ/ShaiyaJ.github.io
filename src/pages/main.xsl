<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="navbar.xsl" />
    <xsl:include href="footer.xsl" />

    <xsl:template match="/">
        <html>
            <body>
                <xsl:call-template name="navbar" />
                <main>...</main>
                <xsl:call-template name="footer" />
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
