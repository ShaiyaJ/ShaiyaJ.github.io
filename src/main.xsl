<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="components/page.xsl"/>

    <xsl:template match="/">
        <!-- Generate main page -->
        <xsl:call-template name="page">
            <xsl:with-param name="filename">index</xsl:with-param>
            <xsl:with-param name="title">ShaiyaJ::Home</xsl:with-param>

            <xsl:with-param name="content">
                <h1>Shaiya J.</h1>

                <p>I'm a hobbyist programmer who dabbles in both high and low level programming. I intend for this website to complement my Github, allowing me to showcase projects and go into detail on things that I otherwise wouldn't be able to in a simple README.</p> 

                <h2>Programming</h2>
                <p>I have experience in various programming languages, working at all levels of development.</p>
                <p>This includes, but is not limited to:</p>
                <ul>
                    <li>C/C++, Rust</li>
                        Low level networking, performant terminal applications and games.
                    <li>Java</li>
                        Cross platform GUI applications (JavaFX).
                    <li>JavaScript/TypeScript</li>
                        Custom frontend frameworks, browser extensions, websites (in raw html/css/js and React) and web apps (in electron and PWAs).
                    <li>Python, (Ba)sh</li>
                        Command line utilities, simple scripts, cross platform GUI applications (Tkinter).
                </ul>

                <p>I'm most comfortable with low-level development, with the majority of my personal projects being written in C. But I am also capable of high-level environments, and I often find myself writing simple scripts or prototyping projects in Python nowadays.</p>

                <p>A lot of projects are avaliable on my <a href="https://github.com/ShaiyaJ">Github</a> and are open-source - usually under the MIT license. I make most of my projects out of enjoyment, usually to solve real world problems that I'm having or to just see a random idea I had realised.</p>
                
                <p>I also intend my <a href="/blog">blog</a> to become a way to add commentary to my projects.</p>

                <h2>Security/Networking</h2>
                <p>I also have a passive interest in networking. Specifically the idea of decentralized P2P networks (without signalling servers) or multi-medium mesh networks (e.g. Reticulum). Naturally, I also take a keen interest in security, but I don't find myself directly dabbling in it.</p>
            
                <h2>Fresh air and green grass</h2>
                <p>My hobbies aren't limited to just the computer. Outside of computer science I find myself enjoying literature, philosophy, linguistics, history and travelling.</p>
            </xsl:with-param>
        </xsl:call-template>

        <!-- Generate blog pages -->
        <xsl:variable name="post-list">
            <xsl:perform-sort select="/posts/*">
                <xsl:sort select="date-posted" order="descending" />
            </xsl:perform-sort>
        </xsl:variable>

        <xsl:call-template name="page">
            <xsl:with-param name="filename">blog/index</xsl:with-param>
            <xsl:with-param name="title">ShaiyaJ::Blog</xsl:with-param>

            <xsl:with-param name="content">
                <h1>Blog</h1>

                <table>
                    <tr>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Date Posted</th>
                        <th>Last Edited</th>
                    </tr>

                    <xsl:for-each select="$post-list/post">
                        <tr>
                            <td><a href="/blog/posts/{./short-title}"><xsl:value-of select="./title" /></a></td>
                            <td><xsl:value-of select="./category" /></td>
                            <td><xsl:value-of select="./date-posted" /></td>
                            <td><xsl:value-of select="./date-edited" /></td>
                        </tr>
                    </xsl:for-each>
                </table>


            </xsl:with-param>
        </xsl:call-template>

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
        <xsl:call-template name="page">
            <xsl:with-param name="filename">contact/index</xsl:with-param>
            <xsl:with-param name="title">ShaiyaJ::Contact</xsl:with-param>

            <xsl:with-param name="content">
                <h1>Contact</h1>
                <p>At the moment - I don't have any way to directly contact me. I'll privately hand out contact information. I do intend to have a public email on this page soon, <em>specifically</em> for this contact page.</p>
            </xsl:with-param>
        </xsl:call-template>

    </xsl:template>
</xsl:stylesheet>
