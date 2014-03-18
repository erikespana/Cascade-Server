<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="date-converter" version="1.0" xmlns:date-converter="http://www.hannonhill.com/dateConverter/1.0/" xmlns:xalan="http://xml.apache.org/xalan">
    <xsl:include href="site://news/_Site Support/Formats/xalan_convertMonthDate"/>
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:template match="/">
        <p>
            The Alumni Jobs Bulletin is a resource for Union College Alumni seeking employment.&#160;The positions in the Jobs Bulletin are sent to the Becker Career Center by employers&#160;looking to hire&#160;experienced professionals. Jobs are posted as received.
        </p>
        <p>
            Please contact <a href="mailto:carusor@union.edu">Rochelle Caruso </a>if you have any questions or if you have a position&#160;you would liked posted in the&#160;Jobs Bulletin.
        </p>
        
        <ul class="post-list post-list-alt">
            <xsl:apply-templates select="//system-page">
                <xsl:sort order="descending" select="last-modified"/>
            </xsl:apply-templates>
        </ul>
    </xsl:template>

    <xsl:template match="system-page">
        <xsl:choose>
            <xsl:when test="self::node()[dynamic-metadata[name='hidden'][value = 'Yes']]">
            </xsl:when>
            <xsl:otherwise>
                <li>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="link"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:value-of select="title"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="date-converter:convertMonthDate(number(last-published-on))"/>
                        </xsl:attribute>
                        <xsl:value-of select="title"/>
                    </a>
                </li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>