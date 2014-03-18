<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/>
    
    <!-- start at the system index block level -->
    <xsl:template match="system-index-block">
        <p>
            Total file assets in <strong><xsl:value-of select="./@name"/></strong>:
            <strong><xsl:value-of select="count(//system-file)"/></strong>*
        </p>
        <ul>
            <xsl:if test="count(//system-file[contains(name, '.jpg')]) &gt; 0">
                <li>
                    <strong>
                        <xsl:value-of select="count(//system-file[contains(name, '.jpg')])"/>
                    </strong>
                    .jpg
                </li>
            </xsl:if>
            <xsl:if test="count(//system-file[contains(name, '.jpeg')]) &gt; 0">
                <li>
                    <strong>
                        <xsl:value-of select="count(//system-file[contains(name, '.jpeg')])"/>
                    </strong>
                    .jpeg
                </li>
            </xsl:if>
            <li>
                <strong>
                    <xsl:value-of select="count(//system-file[contains(name, '.bmp')])"/>
                </strong>
                .bmp
            </li>
            <li>
                <strong>
                    <xsl:value-of select="count(//system-file[contains(name, '.png')])"/>
                </strong>
                .png
            </li>
            <li>
                <strong>
                    <xsl:value-of select="count(//system-file[contains(name, '.gif')])"/>
                </strong>
                .gif
            </li>
            <li>
                <strong>
                    <xsl:value-of select="count(//system-file[contains(name, '.pdf')])"/>
                </strong>
                .pdf
            </li>
            <li>
                <strong>
                    <xsl:value-of select="count(//system-file[contains(name, '.css')])"/>
                </strong>
                .css
            </li>
            <li>
                <strong>
                    <xsl:value-of select="count(//system-file[contains(name, '.js')])"/>
                </strong>
                .js
            </li>
            <li>
                <strong>
                    <xsl:value-of select="count(//system-file[contains(name, '.swf')])"/>
                </strong>
                .swf
            </li>
            <li>
                <strong>
                    <xsl:value-of select="count(//system-file[contains(name, '.html')])"/>
                </strong>
                .html
            </li>
            <li>
                <strong>
                    <xsl:value-of select="count(//system-file[contains(name, '.mp3')])"/>
                </strong>
                .mp3
            </li>
            <li>
                <strong>
                    <xsl:value-of select="count(//system-file[contains(name, '.db')])"/>
                </strong>
                .db
            </li>
            <!--
            <li>
                <strong>
                    <xsl:value-of select="count(/system-folder[name = 'news']//system-file[contains(name, '.jpg')])"/>
                </strong>
                news/*.jpg
            </li>-->
        </ul>
    </xsl:template>
    
</xsl:stylesheet>