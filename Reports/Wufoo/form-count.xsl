<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/>
    
    <!-- start at the system index block level -->
    <xsl:template match="/Forms">
        <p>
            Total Forms:
            <strong><xsl:value-of select="count(//Form)"/></strong>
        </p>

    </xsl:template>
    
</xsl:stylesheet>