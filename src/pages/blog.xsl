<xsl:call-template name="page">
    <xsl:with-param name="filename">blog/index</xsl:with-param>
    <xsl:with-param name="title">ShaiyaJ::Blog</xsl:with-param>

    <xsl:with-param name="content">
        <h1>Blog</h1>
        <xsl:for-each select="$post-list/post">
            <a href="/blog/posts/{./short-title}"><xsl:value-of select="./title" /></a>
        </xsl:for-each>
    </xsl:with-param>
</xsl:call-template>
