<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="date-converter" version="1.0" xmlns:date-converter="http://www.hannonhill.com/dateConverter/1.0/" xmlns:xalan="http://xml.apache.org/xalan">
    <xsl:output indent="yes" method="xml"/>
    
    <!-- URL prefix for news item links -->
    <xsl:variable name="website_prefix">http://www.union.edu</xsl:variable>
    <!-- File extension used -->
    <xsl:variable name="file_extension">.php</xsl:variable>
    <!-- RSS extension to use -->
    <xsl:variable name="rss_extension">.xml</xsl:variable>
    <!-- Name of RSS generator -->
    <xsl:variable name="rss_generator">Cascade Server</xsl:variable>
    <!-- Web master's email address -->
    <xsl:variable name="web_master">webstaff@union.edu</xsl:variable>
    <!-- Path in the CMS -->
    <xsl:variable name="site_path">/news/stories</xsl:variable>
    
 <!-- Matches on the current system page, the news type page -->
    <xsl:template match="system-page" mode="current">
          <title><xsl:value-of select="title"/></title>
          <link>
            <xsl:text>http://www.union.edu/feeds</xsl:text><xsl:value-of select="path"/><xsl:value-of select="$rss_extension"/>
          </link>
          <description><xsl:value-of select="teaser"/></description>
          <pubDate><xsl:choose>
                    <xsl:when test="last-published-on">
                        <xsl:value-of select="date-converter:convertDate(number(last-published-on))"/>
                    </xsl:when>
                    <xsl:when test="created-on">
                        <xsl:value-of select="date-converter:convertDate(number(created-on))"/>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </pubDate>
          <generator><xsl:value-of select="$rss_generator"/></generator>
          <webMaster><xsl:value-of select="$web_master"/></webMaster>
    </xsl:template>
    
     <!-- Match on first 20 invidiual news item pages -->
    <xsl:template match="system-page">
        <xsl:if test="position() &lt; 21">
            <item>
                <title><xsl:value-of select="title"/></title>
                <link><xsl:value-of select="$website_prefix"/><xsl:value-of select="path"/><xsl:value-of select="$file_extension"/></link>
                <description><xsl:value-of select="teaser"/></description>
                <content>
                    [cascade:cdata]<xsl:copy-of select="system-data-structure/story/copy/node()"/>[/cascade:cdata]
                </content>
                <pubDate>
                    <xsl:choose>
                        <xsl:when test="start-date">
                            <xsl:value-of select="date-converter:convertDate(number(start-date))"/>
                        </xsl:when>
                        <xsl:when test="created-on">
                            <xsl:value-of select="date-converter:convertDate(number(created-on))"/>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                </pubDate>
                <category>
                    <xsl:value-of select="dynamic-metadata[name='category']/value"/>
                </category>
                <guid>
                    <xsl:value-of select="$website_prefix"/><xsl:value-of select="path"/>
                </guid>
            </item>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="copy">
        <xsl:apply-templates select="p"/>
    </xsl:template>
    
    <xsl:template match="p">
        &lt;p&gt;<xsl:value-of select="."/>&lt;/p&gt;
    </xsl:template>
    
    <!-- Xalan component for date conversion from CMS date format to RSS 2.0 pubDate format -->
    <xalan:component functions="convertDate" prefix="date-converter">
          <xalan:script lang="javascript">
               function convertDate(date)
               {
                    var d = new Date(date);
                    // Splits date into components
                    var temp = d.toString().split(' ');
                    // timezone difference to GMT
                    var timezone = temp[5].substring(3);
                    // RSS 2.0 valid pubDate format
                    var retString = temp[0] + ', ' + temp[2] + ' ' + temp[1] + ' ' + temp[3] + ' ' + temp[4] + ' ' + timezone;
                    return retString;
              }
         </xalan:script>
     </xalan:component>
    
</xsl:stylesheet>