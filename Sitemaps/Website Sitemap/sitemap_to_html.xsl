<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>

	<xsl:include href="/_Site Support/Formats/Common/Output/format-date"/>

	  <!-- URL prefix for page links, no trailing slash -->
	  <xsl:variable name="website_prefix">http://www.union.edu</xsl:variable>
	  <!-- File extension used on published pages -->
	  <xsl:variable name="file_extension">.php</xsl:variable>
	  <!-- Path in the CMS, no trailing slash -->
	  <xsl:variable name="site_path">/union/</xsl:variable>

	<xsl:template match="/system-index-block">
	<ol>
	<xsl:apply-templates select="//system-page[not(starts-with(path, '/news'))][not(dynamic-metadata[name='exclude-sitemaps' and value='Exclude']) and last-published-on]"/>
	</ol>
	<p>* Showing title because there is no display-name.</p>
	<p>** Showing path because there is no title or display-name.</p>
	</xsl:template>

	<xsl:template match="system-page">
		<xsl:choose>
			<xsl:when test="path = '/index'">
				 <h3>Homepage</h3>
			</xsl:when>
			<xsl:when test="path = '/gateway/current-students'">
				 <h3>Gateways</h3>
			</xsl:when>
			<xsl:when test="path = '/admissions/index'">
				<h3>Admissions</h3>
			</xsl:when>
			<xsl:when test="path = '/alumni'">
				 <h3>Alumni</h3>
			</xsl:when>
			<xsl:when test="path = '/reunion'">
				 <h3>ReUnion</h3>
			</xsl:when>
			<xsl:when test="path = '/homecoming'">
				 <h3>Homecoming</h3>
			</xsl:when>
			<xsl:when test="path = '/about/index'">
				 <h3>About</h3>
			</xsl:when>
			<xsl:when test="path = '/academic/index'">
				 <h3>Academics</h3>
			</xsl:when>
			<xsl:when test="path = '/campus/index'">
				 <h3>Campus Life</h3>
			</xsl:when>
			<xsl:when test="path = '/news/index'">
				 <h3>News &amp; Events</h3>
			</xsl:when>
			<xsl:when test="path = '/giving/index'">
				 <h3>Giving</h3>
			</xsl:when>
			<xsl:when test="path = '/commencement/index'">
				 <h3>Commencement</h3>
			</xsl:when>
			<xsl:when test="path = '/offices/index'">
				 <h3>Offices</h3>
			</xsl:when>
			<xsl:when test="path = '/library/index'">
				 <h3>Library</h3>
			</xsl:when>
			<xsl:when test="path = '/college-relations/index'">
				 <h3>College Relations</h3>
			</xsl:when>
			<xsl:when test="path = '/social-media/index'">
				 <h3>Social Stream</h3>
			</xsl:when>
			<xsl:when test="path = '/presidents-council/index'">
				 <h3>President's Council</h3>
			</xsl:when>
			<xsl:when test="path = '/sart/index'">
				 <h3>SART</h3>
			</xsl:when>
			<xsl:when test="path = '/wold/index'">
				 <h3>Wold</h3>
			</xsl:when>
		</xsl:choose>
		<li>
			<xsl:choose>
				<xsl:when test="display-name != ''">
					<a href="{$website_prefix}{path}{$file_extension}">
						<xsl:value-of select="display-name"/>
					</a>
				</xsl:when>
				<xsl:when test="title != ''">
					<a href="{$website_prefix}{path}{$file_extension}">
						<xsl:value-of select="title"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<a href="{$website_prefix}{path}{$file_extension}">
						<xsl:value-of select="path"/>**
					</a>
				</xsl:otherwise>
			</xsl:choose>
			<!--
			<lastmod>
			<xsl:value-of select="last-published-on"/>

			<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="last-published-on"/>
			<xsl:with-param name="mask">isoUtcDateTime</xsl:with-param>
			</xsl:call-template>

			</lastmod>
			-->
			<xsl:if test="ancestor-or-self::*/dynamic-metadata[name='sitemap-changefreq' and value != '']">
			<changefreq>
			<xsl:value-of select="(ancestor-or-self::*/dynamic-metadata[name='sitemap-changefreq' and value != ''])[position() = last()]/value"/>
			</changefreq>
			</xsl:if>
		</li>
	</xsl:template>
</xsl:stylesheet>