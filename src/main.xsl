<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="components/page.xsl"/>

    <xsl:function name="conv:convertRFC" as="xs:dateTime">
        <xsl:param name="date-time" as="xs:string"/> <!-- Tue, 9 Apr 2019 00:07:24 +1200 (NZST) -->
        <xsl:variable name="months" select="'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'" as="xs:string*"/>
        <!-- https://stackoverflow.com/questions/9352003/rfc-2822-date-regex -->
        <xsl:analyze-string select="$date-time"
            regex="^(?:(Sun|Mon|Tue|Wed|Thu|Fri|Sat),\s+)?(0[1-9]|[1-2]?[0-9]|3[01])\s+(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+(19[0-9]{{2}}|[2-9][0-9]{{3}})\s+(2[0-3]|[0-1][0-9]):([0-5][0-9])(?::(60|[0-5][0-9]))?\s+([-\+][0-9]{{2}}[0-5][0-9]|(?:UT|GMT|(?:E|C|M|P)(?:ST|DT)|[A-IK-Z]))(\s+|\(([^\(\)]+|\\\(|\\\))*\))*$">
            <xsl:matching-substring>
                <xsl:sequence select="xs:dateTime(concat(format-number(xs:integer(regex-group(4)), '0001'), '-', format-number(index-of($months, regex-group(3)), '01'), '-', format-number(xs:integer(regex-group(2)), '01'), 'T', format-number(xs:integer(regex-group(5)), '01'), ':', format-number(xs:integer(regex-group(6)), '01'), ':', format-number(xs:integer(regex-group(7)), '01'), substring(regex-group(8), 1, 3), ':', substring(regex-group(8), 4, 2)))"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:message>Invalid RFC 2822 datetime: <xsl:value-of select="$date-time"/></xsl:message>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:function>

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
                <!-- <xsl:sort select="parse-ietf-date(normalize-space(date-posted))" order="descending"/> FIXME: this function isn't avaliable -->
                <xsl:sort select="conv:convertRFC(./date-posted)" order="descending"/>  <!-- https://gist.github.com/bzerangue/862469 -->
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

                    <xsl:for-each select="$post-list/post">
                        <tr>
                            <td><a href="/blog/posts/{./short-title}"><xsl:value-of select="./title" /></a></td>
                            <td><xsl:value-of select="./category" /></td>
                            <td><xsl:value-of select="./date-posted" /></td>
                            <td><xsl:value-of select="./date-edited" /></td>
                            <!-- TODO: description? -->
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
                    <p><xsl:value-of select="./description" /></p>
                    <p>Posted: <xsl:value-of select="./date-posted" /> | Edited: <xsl:value-of select="./date-edited" /></p>
                    <p>in <xsl:value-of select="./category" /></p>
                    <!-- TODO: description? -->

                    <aside id="blog-search"> <!-- TODO: Could use CSS to hide information based on dropdown? Offering by-category by-post-date and by-last-edit date? -->
                        <xsl:for-each select="/posts/*">
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
                        <xsl:variable name="currentPost" select="$post-list/post[position() = current()]"></xsl:variable>

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

                    <xsl:for-each select="$post-list/post">
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
