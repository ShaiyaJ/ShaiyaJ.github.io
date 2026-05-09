<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="components/page.xsl"/>
    <xsl:include href="components/navbar.xsl"/>
    <xsl:include href="components/footer.xsl"/>

    <xsl:template match="/">
        <!-- Generate main page -->
        <xsl:call-template name="page">
            <xsl:with-param name="filename">index</xsl:with-param>
            <xsl:with-param name="title">ShaiyaJ::Home</xsl:with-param>

            <xsl:with-param name="content">
                <h1>Welcome</h1>
                <p>This is the home page content.</p>
            </xsl:with-param>
        </xsl:call-template>

        <!-- Generate blog page -->
        <xsl:call-template name="page">
            <xsl:with-param name="filename">blog/index</xsl:with-param>
            <xsl:with-param name="title">ShaiyaJ::Blog</xsl:with-param>

            <xsl:with-param name="content">
                <h1>Welcome</h1>
                <p>This is the home page content.</p>
            </xsl:with-param>
        </xsl:call-template>

        <!-- Generate contact page -->
        <xsl:call-template name="page">
            <xsl:with-param name="filename">contact/index</xsl:with-param>
            <xsl:with-param name="title">ShaiyaJ::Contact</xsl:with-param>

            <xsl:with-param name="content">
                <h1>Welcome</h1>
                <p>This is the home page content.</p>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
