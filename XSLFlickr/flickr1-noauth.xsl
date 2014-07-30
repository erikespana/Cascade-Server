<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="f xs" version="1.0" xmlns:f="http://www.flickr.com/services/api/" xmlns:xs="http://www.w3.org/2001/XMLSchema">
   <xsl:param name="f:api_key" select="''"/>
   <xsl:param name="f:shared_secret" select="''"/>
   <xsl:param name="f:auth_token" select="''"/>
   <!--<xsl:param name="f:debug" select="false()"/>-->
   <xsl:param name="f:debug" select="true()"/>

   <xsl:template name="f:flickr">
      <xsl:param name="method"/>
      <xsl:param name="uriparams"/>
      <xsl:if test="$f:api_key = ''">
         <xsl:message terminate="yes">
            <xsl:text>Error: you must specify an api_key for Flickr.</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:variable name="uri">
         <xsl:text>https://www.flickr.com/services/rest/?method=</xsl:text>
         <xsl:value-of select="$method"/>
         <xsl:value-of select="$uriparams"/>
      </xsl:variable>
      <xsl:if test="$f:debug">
         <!--<xsl:message>-->
            <xsl:text>FLICKR: </xsl:text>
            <xsl:value-of select="$uri"/>
         <!--</xsl:message>-->
      </xsl:if>
      <xsl:copy-of select="document($uri)/*"/>
   </xsl:template>

   <xsl:template name="f:photos.getInfo">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="secret" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$secret != ''">
            <xsl:text>&amp;secret=</xsl:text>
            <xsl:value-of select="$secret"/>
         </xsl:if>
         
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getInfo'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template name="f:photos.getSizes">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getSizes'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template name="f:photosets.getPhotos">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photoset_id" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="privacy_filter" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photoset_id != ''">
            <xsl:text>&amp;photoset_id=</xsl:text>
            <xsl:value-of select="$photoset_id"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$privacy_filter != ''">
            <xsl:text>&amp;privacy_filter=</xsl:text>
            <xsl:value-of select="$privacy_filter"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         
      </xsl:variable>

      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.getPhotos'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>