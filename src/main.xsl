<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="components/page.xsl"/>

    <xsl:template match="/">
        <!-- Generate main page -->
        <xsl:copy-of href="doc('./pages/index.xsl')/*" />

        <!-- Generate blog pages -->
        <xsl:variable name="post-list">
            <xsl:perform-sort select="/posts/*">
                <xsl:sort select="date-posted" order="descending" />
            </xsl:perform-sort>
        </xsl:variable>

        <xsl:copy-of href="doc('./pages/blog.xsl')/*" />

        <!-- Generate each post on a separate page -->
        <xsl:for-each select="/posts/*">
            <xsl:call-template name="page">
                <xsl:with-param name="filename">blog/posts/<xsl:value-of select="./short-title" />/index</xsl:with-param>
                <xsl:with-param name="title">ShaiyaJ::Blog::<xsl:value-of select="./title" /></xsl:with-param>

                <xsl:with-param name="content">
                    <h1><xsl:value-of select="./title" /></h1>
                    <p><a href="/blog/feed.rss">Subscribe via RSS</a>!</p>

                    <aside id="blog-search"> <!-- TODO: Could use CSS to hide information based on dropdown? Offering by-category by-post-date and by-last-edit date? -->
                        <xsl:for-each select="/posts/*">
                            <a href="/blog/posts/{./short-title}"><xsl:value-of select="./title" /></a>
                        </xsl:for-each>
                    </aside>

                    <article>
                        <xsl:value-of select="./content" />
                    </article>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>

        <!-- Generate blog rss -->
        <xsl:result-document method="xml" omit-xml-declaration="no" href="docs/blog/feed.rss">
            <rss version="2.0">

                <channel>
                    <title>ShaiyaJ's Blog</title>
                    <link>https://ShaiyaJ.github.io/</link>
                    <description>A blog for a small hobbyist developer.</description>

                    <xsl:for-each select="0 to 5">
                        <xsl:variable name="currentPost" select="$post-list/post[.]"></xsl:variable>

                        <xsl:if test="$currentPost != ''">

                            <item>
                                <title><xsl:value-of select="$currentPost/title" /></title>
                                <link>https://ShaiyaJ.github.io/blog/posts/<xsl:value-of select="$currentPost/small-title" /></link>
                                <description><xsl:value-of select="$currentPost/description" /></description>
                                <pubdate><xsl:value-of select="$currentPost/date-posted" /></pubdate>
                            </item>

                        </xsl:if>
                    </xsl:for-each>
                </channel>

            </rss> 
        </xsl:result-document>

        <!-- Generate contact page -->
        <xsl:copy-of href="doc('./pages/contact.xsl')/*" />

    </xsl:template>
</xsl:stylesheet>
