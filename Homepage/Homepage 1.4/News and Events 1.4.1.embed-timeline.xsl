<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="date-converter" version="1.0" xmlns:date-converter="http://www.hannonhill.com/dateConverter/1.0/" xmlns:xalan="http://xml.apache.org/xalan">
    <xsl:include href="/_Site Support/Formats/Library/jQuery"/>
    <xsl:output indent="yes" method="xml"/> 

    <!-- News Ticker -->
    <xsl:template match="system-index-block">
            <!-- ==== home-news-ticker === --> 
            <div id="news-ticker">
                <div class="newsHeading">
                    <img alt="News and Events" src="/img/news-ticker/news-and-events-horiz-line.png"/>
                </div>
                <div class="tweet" style="width:180px;height:180px">
                    <a class="twitter-timeline" data-chrome="noheader nofooter noborders noscrollbar" data-dnt="true" data-tweet-limit="1" data-widget-id="395187343805513730" href="https://twitter.com/UnionCollegeNY" width="180px">Tweets by @UnionCollegeNY</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
                </div>
                <xsl:apply-templates select="//system-page/system-data-structure/newsandevents/item"/>
                <!-- close article-title div -->


                <div class="moreNews">
                    <a href="http://union.edu/news/index.php">
                        <img alt="More News and Events" src="/img/news-ticker/more-news-and-events.png"/>
                    </a>
                </div>
            </div>
    </xsl:template>
    
    <xsl:template match="item">
        <xsl:variable name="small-title" select="substring(headline,0,76)"/>

        <div class="news{position()}" style="width:177px;margin-left:5.4px;padding-right:5.4px;">
            <xsl:choose>
                <xsl:when test="link != ''">
                    <a href="{link}">
                        <img src="{image/link}" alt="{$small-title}"/>
                        <!-- Display first 76 characters of headline -->
                       <p><xsl:value-of select="$small-title"/></p>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <img src="{image}" alt="{$small-title}"/>
                    <p><xsl:value-of select="$small-title"/></p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
</xsl:stylesheet>