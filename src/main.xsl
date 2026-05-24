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
        <xsl:variable name="post-list-by-date">
            <xsl:perform-sort select="/posts/*">
                <xsl:sort select="parse-ietf-date(normalize-space(date-posted))" order="descending"/>
            </xsl:perform-sort>
        </xsl:variable>

        <xsl:variable name="post-list-by-category">
            <xsl:perform-sort select="/posts/*">
                <xsl:sort select="./category" order="descending" />
                <xsl:sort select="parse-ietf-date(normalize-space(date-posted))" order="descending"/>
            </xsl:perform-sort>
        </xsl:variable>

        <xsl:call-template name="page">
            <xsl:with-param name="filename">blog/index</xsl:with-param>
            <xsl:with-param name="title">ShaiyaJ::Blog</xsl:with-param>

            <xsl:with-param name="content">
                <h1>Blog</h1>
                <p>If you like my blog you can <a href="/blog/feed.rss">subscribe via RSS</a>!</p>
                <p>If you like reading the full post in your reader you can <a href="/blog/fullfeed.rss">subscribe to the "full feed"</a>!</p>

                <table>
                    <tr>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Date Posted</th>
                        <th>Last Edited</th>
                    </tr>

                    <xsl:for-each select="$post-list-by-date/post">
                        <tr>
                            <td><a href="/blog/posts/{./short-title}"><xsl:value-of select="./title" /></a></td>
                            <td><xsl:value-of select="./category" /></td>
                            <td><xsl:value-of select="./date-posted" /></td>
                            <td><xsl:value-of select="./date-edited" /></td>
                            <!-- TODO: description? -->
                        </tr>
                    </xsl:for-each>
                </table>

                <p>If you want more blogs, here are my <a href="/recommended">recommendations</a>.</p>
            </xsl:with-param>
        </xsl:call-template>

        <!-- Generate each post on a separate page -->
        <xsl:for-each select="/posts/*">
            <xsl:call-template name="page">
                <xsl:with-param name="filename">blog/posts/<xsl:value-of select="./short-title" />/index</xsl:with-param>
                <xsl:with-param name="title">ShaiyaJ::Blog::<xsl:value-of select="./title" /></xsl:with-param>

                <xsl:with-param name="content">
                    <h1><xsl:value-of select="./title" /></h1>
                    <p><xsl:value-of select="./description" /></p>
                    <p>Posted: <xsl:value-of select="./date-posted" /> | Edited: <xsl:value-of select="./date-edited" /></p>
                    <p>in <xsl:value-of select="./category" /></p>
                    <!-- TODO: description? -->

                    <aside id="blog-search"> <!-- TODO: Could use CSS to hide information based on dropdown? Offering by-category by-post-date and by-last-edit date? -->
                        <xsl:for-each select="$post-list-by-category">
                            <p>(<xsl:value-of select="./category" />) <a href="/blog/posts/{./short-title}"><xsl:value-of select="./title" /></a></p>
                        </xsl:for-each>
                    </aside>

                    <article>
                        <xsl:copy-of select="./content/node()" />
                    </article>

                    <p>Liked the post? <a href="/blog/feed.rss">Subscribe via RSS</a> or (if you like reading the posts inside your reader) <a href="/blog/fullfeed.rss">subscribe to the full feed</a>!</p>
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
                        <xsl:variable name="currentPost" select="$post-list-by-date/post[position() = current()]"></xsl:variable>

                        <xsl:if test="$currentPost != ''">

                            <item>
                                <title><xsl:value-of select="$currentPost/title" /></title>
                                <link>https://ShaiyaJ.github.io/blog/posts/<xsl:value-of select="$currentPost/short-title" /></link>
                                <guid>https://ShaiyaJ.github.io/blog/posts/<xsl:value-of select="$currentPost/short-title" /></guid>
                                <description><xsl:value-of select="$currentPost/description" /></description>
                                <pubDate><xsl:value-of select="$currentPost/date-posted" /></pubDate>
                            </item>

                        </xsl:if>
                    </xsl:for-each>
                </channel>

            </rss> 
        </xsl:result-document>

        <xsl:result-document method="xml" omit-xml-declaration="no" href="docs/blog/fullfeed.rss">
            <rss version="2.0">

                <channel>
                    <title>ShaiyaJ's Blog</title>
                    <link>https://ShaiyaJ.github.io/</link>
                    <description>A blog for a small hobbyist developer.</description>

                    <xsl:for-each select="$post-list-by-date/post">
                        <item>
                            <title><xsl:value-of select="./title" /></title>
                            <link>https://ShaiyaJ.github.io/blog/posts/<xsl:value-of select="./short-title" /></link>
                            <guid>https://ShaiyaJ.github.io/blog/posts/<xsl:value-of select="./short-title" /></guid>
                            <description><xsl:value-of select="./description" /></description>
                            <pubDate><xsl:value-of select="./date-posted" /></pubDate>
                            <content type="html">
                                <xsl:copy-of select="./content/node()" />
                            </content>
                        </item>
                    </xsl:for-each>
                </channel>

            </rss> 
        </xsl:result-document>

        <!-- Generate recommended reading page -->
        <xsl:call-template name="page">
            <xsl:with-param name="filename">recommended/index</xsl:with-param>
            <xsl:with-param name="title">ShaiyaJ::Recommendations</xsl:with-param>

            <xsl:with-param name="content">
                <h1>Blog recommendations</h1>
                <p>A lot of the blogs that I read have a post/page dedicated to linking to other blogs. These are usually their friends or just blogs that they themselves read.</p>
                <p>I've always approved of this sort of thing, I've managed to find some great blogs because other blogs recommend them. It's a product of a bygone era of the internet.</p>
                <p>Here are the blogs that I read:</p>

                <ul>
                    <li><a href="https://mcyoung.xyz/">Sunny</a> - Great posts that go in-depth on compiler development and low level programming</li>
                    <li><a href="https://wolfgirl.dev/">PolyWolf</a> - Nice collection of cybersecurity reads and range of programming posts (high and low level)</li>
                </ul>

                <p>I don't know any of these people personally, these are just the good reads that I've come across.</p>
                <p>I also don't guarantee that these links are necessarily safe. I read a lot of these posts through a feed reader so if the sites have been compromised then I probably wouldn't realise. Browse safely!</p>
            </xsl:with-param>
        </xsl:call-template>

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
