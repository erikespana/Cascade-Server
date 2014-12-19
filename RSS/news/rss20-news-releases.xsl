<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="date-converter" version="1.0" xmlns:date-converter="http://www.hannonhill.com/dateConverter/1.0/" xmlns:xalan="http://xml.apache.org/xalan">
    <xsl:include href="/_Site Support/Formats/xPaths"/>
    <xsl:include href="site://API/_Site Support/Formats/Library/RSSNews"/>
     
    <xsl:output indent="yes" method="xml"/>
    
    <!-- Match on the root index block -->
    <xsl:template match="system-index-block">
        <rss version="2.0">
                <channel>
                    <!-- write RSS header information -->
                    <xsl:apply-templates mode="current" select="//system-page[@current='true']"/>
                    <!-- write top 20 items, make sure pages have last-published-on element -->
                    <xsl:apply-templates select="$news-releases">
                         <xsl:sort order="descending" select="start-date"/>
                    </xsl:apply-templates>
               </channel>
            </rss>
    </xsl:template>
</xsl:stylesheet>