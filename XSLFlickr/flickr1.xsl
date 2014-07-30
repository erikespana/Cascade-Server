<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:f="http://www.flickr.com/services/api/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:digest="http://nwalsh.com/xslt/ext/com.nwalsh.xslt.Digest"
                version="1.0"
                exclude-result-prefixes="digest f xs">
   <xsl:param name="f:api_key" select="''"/>
   <xsl:param name="f:shared_secret" select="''"/>
   <xsl:param name="f:auth_token" select="''"/>
   <xsl:param name="f:debug" select="false()"/>
   <xsl:template name="f:flickr">
      <xsl:param name="method"/>
      <xsl:param name="uriparams"/>
      <xsl:if test="$f:api_key = ''">
         <xsl:message terminate="yes">
            <xsl:text>Error: you must specify an api_key for Flickr.</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:variable name="uri">
         <xsl:text>http://www.flickr.com/services/rest/?method=</xsl:text>
         <xsl:value-of select="$method"/>
         <xsl:value-of select="$uriparams"/>
      </xsl:variable>
      <xsl:if test="$f:debug">
         <xsl:message>
            <xsl:text>FLICKR: </xsl:text>
            <xsl:value-of select="$uri"/>
         </xsl:message>
      </xsl:if>
      <xsl:copy-of select="document($uri)/*"/>
   </xsl:template>
   <xsl:template name="f:flickr.auth">
      <xsl:param name="sig"/>
      <xsl:if test="$f:auth_token = ''">
         <xsl:message terminate="yes">
            <xsl:text>Error: you must specify an api_key for Flickr.</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:value-of select="digest:md5(concat($f:shared_secret,$sig))"/>
   </xsl:template>
   <xsl:template name="f:activity.userComments">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.activity.userComments</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.activity.userComments'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:activity.userPhotos">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="timeframe" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$timeframe != ''">
            <xsl:text>&amp;timeframe=</xsl:text>
            <xsl:value-of select="$timeframe"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.activity.userPhotos</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$timeframe != ''">
                     <xsl:text>timeframe</xsl:text>
                     <xsl:value-of select="$timeframe"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.activity.userPhotos'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:auth.checkToken">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="auth_token" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$auth_token"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.auth.checkToken</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.auth.checkToken'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:auth.getFrob">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.auth.getFrob</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.auth.getFrob'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:auth.getFullToken">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="mini_token" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$mini_token != ''">
            <xsl:text>&amp;mini_token=</xsl:text>
            <xsl:value-of select="$mini_token"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.auth.getFullToken</xsl:text>
                  <xsl:if test="$mini_token != ''">
                     <xsl:text>mini_token</xsl:text>
                     <xsl:value-of select="$mini_token"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.auth.getFullToken'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:auth.getToken">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="frob" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$frob != ''">
            <xsl:text>&amp;frob=</xsl:text>
            <xsl:value-of select="$frob"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$frob != ''">
                     <xsl:text>frob</xsl:text>
                     <xsl:value-of select="$frob"/>
                  </xsl:if>
                  <xsl:text>methodflickr.auth.getToken</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.auth.getToken'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:blogs.getList">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.blogs.getList</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.blogs.getList'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:blogs.postPhoto">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="blog_id" select="''"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="title" select="''"/>
      <xsl:param name="description" select="''"/>
      <xsl:param name="blog_password" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$blog_id != ''">
            <xsl:text>&amp;blog_id=</xsl:text>
            <xsl:value-of select="$blog_id"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$title != ''">
            <xsl:text>&amp;title=</xsl:text>
            <xsl:value-of select="$title"/>
         </xsl:if>
         <xsl:if test="$description != ''">
            <xsl:text>&amp;description=</xsl:text>
            <xsl:value-of select="$description"/>
         </xsl:if>
         <xsl:if test="$blog_password != ''">
            <xsl:text>&amp;blog_password=</xsl:text>
            <xsl:value-of select="$blog_password"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$blog_id != ''">
                     <xsl:text>blog_id</xsl:text>
                     <xsl:value-of select="$blog_id"/>
                  </xsl:if>
                  <xsl:if test="$blog_password != ''">
                     <xsl:text>blog_password</xsl:text>
                     <xsl:value-of select="$blog_password"/>
                  </xsl:if>
                  <xsl:if test="$description != ''">
                     <xsl:text>description</xsl:text>
                     <xsl:value-of select="$description"/>
                  </xsl:if>
                  <xsl:text>methodflickr.blogs.postPhoto</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
                  <xsl:if test="$title != ''">
                     <xsl:text>title</xsl:text>
                     <xsl:value-of select="$title"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.blogs.postPhoto'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:contacts.getList">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="filter" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$filter != ''">
            <xsl:text>&amp;filter=</xsl:text>
            <xsl:value-of select="$filter"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$filter != ''">
                     <xsl:text>filter</xsl:text>
                     <xsl:value-of select="$filter"/>
                  </xsl:if>
                  <xsl:text>methodflickr.contacts.getList</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.contacts.getList'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:contacts.getPublicList">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.contacts.getPublicList</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.contacts.getPublicList'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:favorites.add">
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
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.favorites.add</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.favorites.add'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:favorites.getList">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:text>methodflickr.favorites.getList</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.favorites.getList'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:favorites.getPublicList">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:text>methodflickr.favorites.getPublicList</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.favorites.getPublicList'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:favorites.remove">
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
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.favorites.remove</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.favorites.remove'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:groups.browse">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="cat_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$cat_id != ''">
            <xsl:text>&amp;cat_id=</xsl:text>
            <xsl:value-of select="$cat_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$cat_id != ''">
                     <xsl:text>cat_id</xsl:text>
                     <xsl:value-of select="$cat_id"/>
                  </xsl:if>
                  <xsl:text>methodflickr.groups.browse</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.groups.browse'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:groups.getInfo">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="group_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$group_id != ''">
            <xsl:text>&amp;group_id=</xsl:text>
            <xsl:value-of select="$group_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$group_id != ''">
                     <xsl:text>group_id</xsl:text>
                     <xsl:value-of select="$group_id"/>
                  </xsl:if>
                  <xsl:text>methodflickr.groups.getInfo</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.groups.getInfo'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:groups.search">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="text" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$text != ''">
            <xsl:text>&amp;text=</xsl:text>
            <xsl:value-of select="$text"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.groups.search</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$text != ''">
                     <xsl:text>text</xsl:text>
                     <xsl:value-of select="$text"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.groups.search'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:groups.pools.add">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="group_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$group_id != ''">
            <xsl:text>&amp;group_id=</xsl:text>
            <xsl:value-of select="$group_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$group_id != ''">
                     <xsl:text>group_id</xsl:text>
                     <xsl:value-of select="$group_id"/>
                  </xsl:if>
                  <xsl:text>methodflickr.groups.pools.add</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.groups.pools.add'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:groups.pools.getContext">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="group_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$group_id != ''">
            <xsl:text>&amp;group_id=</xsl:text>
            <xsl:value-of select="$group_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$group_id != ''">
                     <xsl:text>group_id</xsl:text>
                     <xsl:value-of select="$group_id"/>
                  </xsl:if>
                  <xsl:text>methodflickr.groups.pools.getContext</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.groups.pools.getContext'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:groups.pools.getGroups">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="page" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.groups.pools.getGroups</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.groups.pools.getGroups'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:groups.pools.getPhotos">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="group_id" select="''"/>
      <xsl:param name="tags" select="''"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$group_id != ''">
            <xsl:text>&amp;group_id=</xsl:text>
            <xsl:value-of select="$group_id"/>
         </xsl:if>
         <xsl:if test="$tags != ''">
            <xsl:text>&amp;tags=</xsl:text>
            <xsl:value-of select="$tags"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:if test="$group_id != ''">
                     <xsl:text>group_id</xsl:text>
                     <xsl:value-of select="$group_id"/>
                  </xsl:if>
                  <xsl:text>methodflickr.groups.pools.getPhotos</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$tags != ''">
                     <xsl:text>tags</xsl:text>
                     <xsl:value-of select="$tags"/>
                  </xsl:if>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.groups.pools.getPhotos'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:groups.pools.remove">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="group_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$group_id != ''">
            <xsl:text>&amp;group_id=</xsl:text>
            <xsl:value-of select="$group_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$group_id != ''">
                     <xsl:text>group_id</xsl:text>
                     <xsl:value-of select="$group_id"/>
                  </xsl:if>
                  <xsl:text>methodflickr.groups.pools.remove</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.groups.pools.remove'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:interestingness.getList">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="date" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$date != ''">
            <xsl:text>&amp;date=</xsl:text>
            <xsl:value-of select="$date"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$date != ''">
                     <xsl:text>date</xsl:text>
                     <xsl:value-of select="$date"/>
                  </xsl:if>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:text>methodflickr.interestingness.getList</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.interestingness.getList'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:people.findByEmail">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="find_email" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$find_email != ''">
            <xsl:text>&amp;find_email=</xsl:text>
            <xsl:value-of select="$find_email"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$find_email != ''">
                     <xsl:text>find_email</xsl:text>
                     <xsl:value-of select="$find_email"/>
                  </xsl:if>
                  <xsl:text>methodflickr.people.findByEmail</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.people.findByEmail'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:people.findByUsername">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="username" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$username != ''">
            <xsl:text>&amp;username=</xsl:text>
            <xsl:value-of select="$username"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.people.findByUsername</xsl:text>
                  <xsl:if test="$username != ''">
                     <xsl:text>username</xsl:text>
                     <xsl:value-of select="$username"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.people.findByUsername'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:people.getInfo">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.people.getInfo</xsl:text>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.people.getInfo'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:people.getPublicGroups">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.people.getPublicGroups</xsl:text>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.people.getPublicGroups'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:people.getPublicPhotos">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:text>methodflickr.people.getPublicPhotos</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.people.getPublicPhotos'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:people.getUploadStatus">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.people.getUploadStatus</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.people.getUploadStatus'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.addTags">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="tags" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$tags != ''">
            <xsl:text>&amp;tags=</xsl:text>
            <xsl:value-of select="$tags"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.addTags</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
                  <xsl:if test="$tags != ''">
                     <xsl:text>tags</xsl:text>
                     <xsl:value-of select="$tags"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.addTags'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.delete">
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
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.delete</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.delete'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getAllContexts">
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
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.getAllContexts</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getAllContexts'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getContactsPhotos">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="count" select="''"/>
      <xsl:param name="just_friends" select="''"/>
      <xsl:param name="single_photo" select="''"/>
      <xsl:param name="include_self" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$count != ''">
            <xsl:text>&amp;count=</xsl:text>
            <xsl:value-of select="$count"/>
         </xsl:if>
         <xsl:if test="$just_friends != ''">
            <xsl:text>&amp;just_friends=</xsl:text>
            <xsl:value-of select="$just_friends"/>
         </xsl:if>
         <xsl:if test="$single_photo != ''">
            <xsl:text>&amp;single_photo=</xsl:text>
            <xsl:value-of select="$single_photo"/>
         </xsl:if>
         <xsl:if test="$include_self != ''">
            <xsl:text>&amp;include_self=</xsl:text>
            <xsl:value-of select="$include_self"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$count != ''">
                     <xsl:text>count</xsl:text>
                     <xsl:value-of select="$count"/>
                  </xsl:if>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:if test="$include_self != ''">
                     <xsl:text>include_self</xsl:text>
                     <xsl:value-of select="$include_self"/>
                  </xsl:if>
                  <xsl:if test="$just_friends != ''">
                     <xsl:text>just_friends</xsl:text>
                     <xsl:value-of select="$just_friends"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.getContactsPhotos</xsl:text>
                  <xsl:if test="$single_photo != ''">
                     <xsl:text>single_photo</xsl:text>
                     <xsl:value-of select="$single_photo"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getContactsPhotos'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getContactsPublicPhotos">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:param name="count" select="''"/>
      <xsl:param name="just_friends" select="''"/>
      <xsl:param name="single_photo" select="''"/>
      <xsl:param name="include_self" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$count != ''">
            <xsl:text>&amp;count=</xsl:text>
            <xsl:value-of select="$count"/>
         </xsl:if>
         <xsl:if test="$just_friends != ''">
            <xsl:text>&amp;just_friends=</xsl:text>
            <xsl:value-of select="$just_friends"/>
         </xsl:if>
         <xsl:if test="$single_photo != ''">
            <xsl:text>&amp;single_photo=</xsl:text>
            <xsl:value-of select="$single_photo"/>
         </xsl:if>
         <xsl:if test="$include_self != ''">
            <xsl:text>&amp;include_self=</xsl:text>
            <xsl:value-of select="$include_self"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$count != ''">
                     <xsl:text>count</xsl:text>
                     <xsl:value-of select="$count"/>
                  </xsl:if>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:if test="$include_self != ''">
                     <xsl:text>include_self</xsl:text>
                     <xsl:value-of select="$include_self"/>
                  </xsl:if>
                  <xsl:if test="$just_friends != ''">
                     <xsl:text>just_friends</xsl:text>
                     <xsl:value-of select="$just_friends"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.getContactsPublicPhotos</xsl:text>
                  <xsl:if test="$single_photo != ''">
                     <xsl:text>single_photo</xsl:text>
                     <xsl:value-of select="$single_photo"/>
                  </xsl:if>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getContactsPublicPhotos'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getContext">
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
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.getContext</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getContext'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getCounts">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="dates" select="''"/>
      <xsl:param name="taken_dates" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$dates != ''">
            <xsl:text>&amp;dates=</xsl:text>
            <xsl:value-of select="$dates"/>
         </xsl:if>
         <xsl:if test="$taken_dates != ''">
            <xsl:text>&amp;taken_dates=</xsl:text>
            <xsl:value-of select="$taken_dates"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$dates != ''">
                     <xsl:text>dates</xsl:text>
                     <xsl:value-of select="$dates"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.getCounts</xsl:text>
                  <xsl:if test="$taken_dates != ''">
                     <xsl:text>taken_dates</xsl:text>
                     <xsl:value-of select="$taken_dates"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getCounts'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getExif">
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
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.getExif</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
                  <xsl:if test="$secret != ''">
                     <xsl:text>secret</xsl:text>
                     <xsl:value-of select="$secret"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getExif'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
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
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.getInfo</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
                  <xsl:if test="$secret != ''">
                     <xsl:text>secret</xsl:text>
                     <xsl:value-of select="$secret"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getInfo'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getNotInSet">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="min_upload_date" select="''"/>
      <xsl:param name="max_upload_date" select="''"/>
      <xsl:param name="min_taken_date" select="''"/>
      <xsl:param name="max_taken_date" select="''"/>
      <xsl:param name="privacy_filter" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$min_upload_date != ''">
            <xsl:text>&amp;min_upload_date=</xsl:text>
            <xsl:value-of select="$min_upload_date"/>
         </xsl:if>
         <xsl:if test="$max_upload_date != ''">
            <xsl:text>&amp;max_upload_date=</xsl:text>
            <xsl:value-of select="$max_upload_date"/>
         </xsl:if>
         <xsl:if test="$min_taken_date != ''">
            <xsl:text>&amp;min_taken_date=</xsl:text>
            <xsl:value-of select="$min_taken_date"/>
         </xsl:if>
         <xsl:if test="$max_taken_date != ''">
            <xsl:text>&amp;max_taken_date=</xsl:text>
            <xsl:value-of select="$max_taken_date"/>
         </xsl:if>
         <xsl:if test="$privacy_filter != ''">
            <xsl:text>&amp;privacy_filter=</xsl:text>
            <xsl:value-of select="$privacy_filter"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:if test="$max_taken_date != ''">
                     <xsl:text>max_taken_date</xsl:text>
                     <xsl:value-of select="$max_taken_date"/>
                  </xsl:if>
                  <xsl:if test="$max_upload_date != ''">
                     <xsl:text>max_upload_date</xsl:text>
                     <xsl:value-of select="$max_upload_date"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.getNotInSet</xsl:text>
                  <xsl:if test="$min_taken_date != ''">
                     <xsl:text>min_taken_date</xsl:text>
                     <xsl:value-of select="$min_taken_date"/>
                  </xsl:if>
                  <xsl:if test="$min_upload_date != ''">
                     <xsl:text>min_upload_date</xsl:text>
                     <xsl:value-of select="$min_upload_date"/>
                  </xsl:if>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$privacy_filter != ''">
                     <xsl:text>privacy_filter</xsl:text>
                     <xsl:value-of select="$privacy_filter"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getNotInSet'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getPerms">
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
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.getPerms</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getPerms'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getRecent">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.getRecent</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getRecent'"/>
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
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.getSizes</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getSizes'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getUntagged">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="min_upload_date" select="''"/>
      <xsl:param name="max_upload_date" select="''"/>
      <xsl:param name="min_taken_date" select="''"/>
      <xsl:param name="max_taken_date" select="''"/>
      <xsl:param name="privacy_filter" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$min_upload_date != ''">
            <xsl:text>&amp;min_upload_date=</xsl:text>
            <xsl:value-of select="$min_upload_date"/>
         </xsl:if>
         <xsl:if test="$max_upload_date != ''">
            <xsl:text>&amp;max_upload_date=</xsl:text>
            <xsl:value-of select="$max_upload_date"/>
         </xsl:if>
         <xsl:if test="$min_taken_date != ''">
            <xsl:text>&amp;min_taken_date=</xsl:text>
            <xsl:value-of select="$min_taken_date"/>
         </xsl:if>
         <xsl:if test="$max_taken_date != ''">
            <xsl:text>&amp;max_taken_date=</xsl:text>
            <xsl:value-of select="$max_taken_date"/>
         </xsl:if>
         <xsl:if test="$privacy_filter != ''">
            <xsl:text>&amp;privacy_filter=</xsl:text>
            <xsl:value-of select="$privacy_filter"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:if test="$max_taken_date != ''">
                     <xsl:text>max_taken_date</xsl:text>
                     <xsl:value-of select="$max_taken_date"/>
                  </xsl:if>
                  <xsl:if test="$max_upload_date != ''">
                     <xsl:text>max_upload_date</xsl:text>
                     <xsl:value-of select="$max_upload_date"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.getUntagged</xsl:text>
                  <xsl:if test="$min_taken_date != ''">
                     <xsl:text>min_taken_date</xsl:text>
                     <xsl:value-of select="$min_taken_date"/>
                  </xsl:if>
                  <xsl:if test="$min_upload_date != ''">
                     <xsl:text>min_upload_date</xsl:text>
                     <xsl:value-of select="$min_upload_date"/>
                  </xsl:if>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$privacy_filter != ''">
                     <xsl:text>privacy_filter</xsl:text>
                     <xsl:value-of select="$privacy_filter"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getUntagged'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getWithGeoData">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="min_upload_date" select="''"/>
      <xsl:param name="max_upload_date" select="''"/>
      <xsl:param name="min_taken_date" select="''"/>
      <xsl:param name="max_taken_date" select="''"/>
      <xsl:param name="privacy_filter" select="''"/>
      <xsl:param name="sort" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$min_upload_date != ''">
            <xsl:text>&amp;min_upload_date=</xsl:text>
            <xsl:value-of select="$min_upload_date"/>
         </xsl:if>
         <xsl:if test="$max_upload_date != ''">
            <xsl:text>&amp;max_upload_date=</xsl:text>
            <xsl:value-of select="$max_upload_date"/>
         </xsl:if>
         <xsl:if test="$min_taken_date != ''">
            <xsl:text>&amp;min_taken_date=</xsl:text>
            <xsl:value-of select="$min_taken_date"/>
         </xsl:if>
         <xsl:if test="$max_taken_date != ''">
            <xsl:text>&amp;max_taken_date=</xsl:text>
            <xsl:value-of select="$max_taken_date"/>
         </xsl:if>
         <xsl:if test="$privacy_filter != ''">
            <xsl:text>&amp;privacy_filter=</xsl:text>
            <xsl:value-of select="$privacy_filter"/>
         </xsl:if>
         <xsl:if test="$sort != ''">
            <xsl:text>&amp;sort=</xsl:text>
            <xsl:value-of select="$sort"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:if test="$max_taken_date != ''">
                     <xsl:text>max_taken_date</xsl:text>
                     <xsl:value-of select="$max_taken_date"/>
                  </xsl:if>
                  <xsl:if test="$max_upload_date != ''">
                     <xsl:text>max_upload_date</xsl:text>
                     <xsl:value-of select="$max_upload_date"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.getWithGeoData</xsl:text>
                  <xsl:if test="$min_taken_date != ''">
                     <xsl:text>min_taken_date</xsl:text>
                     <xsl:value-of select="$min_taken_date"/>
                  </xsl:if>
                  <xsl:if test="$min_upload_date != ''">
                     <xsl:text>min_upload_date</xsl:text>
                     <xsl:value-of select="$min_upload_date"/>
                  </xsl:if>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$privacy_filter != ''">
                     <xsl:text>privacy_filter</xsl:text>
                     <xsl:value-of select="$privacy_filter"/>
                  </xsl:if>
                  <xsl:if test="$sort != ''">
                     <xsl:text>sort</xsl:text>
                     <xsl:value-of select="$sort"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getWithGeoData'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.getWithoutGeoData">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="min_upload_date" select="''"/>
      <xsl:param name="max_upload_date" select="''"/>
      <xsl:param name="min_taken_date" select="''"/>
      <xsl:param name="max_taken_date" select="''"/>
      <xsl:param name="privacy_filter" select="''"/>
      <xsl:param name="sort" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$min_upload_date != ''">
            <xsl:text>&amp;min_upload_date=</xsl:text>
            <xsl:value-of select="$min_upload_date"/>
         </xsl:if>
         <xsl:if test="$max_upload_date != ''">
            <xsl:text>&amp;max_upload_date=</xsl:text>
            <xsl:value-of select="$max_upload_date"/>
         </xsl:if>
         <xsl:if test="$min_taken_date != ''">
            <xsl:text>&amp;min_taken_date=</xsl:text>
            <xsl:value-of select="$min_taken_date"/>
         </xsl:if>
         <xsl:if test="$max_taken_date != ''">
            <xsl:text>&amp;max_taken_date=</xsl:text>
            <xsl:value-of select="$max_taken_date"/>
         </xsl:if>
         <xsl:if test="$privacy_filter != ''">
            <xsl:text>&amp;privacy_filter=</xsl:text>
            <xsl:value-of select="$privacy_filter"/>
         </xsl:if>
         <xsl:if test="$sort != ''">
            <xsl:text>&amp;sort=</xsl:text>
            <xsl:value-of select="$sort"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:if test="$max_taken_date != ''">
                     <xsl:text>max_taken_date</xsl:text>
                     <xsl:value-of select="$max_taken_date"/>
                  </xsl:if>
                  <xsl:if test="$max_upload_date != ''">
                     <xsl:text>max_upload_date</xsl:text>
                     <xsl:value-of select="$max_upload_date"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.getWithoutGeoData</xsl:text>
                  <xsl:if test="$min_taken_date != ''">
                     <xsl:text>min_taken_date</xsl:text>
                     <xsl:value-of select="$min_taken_date"/>
                  </xsl:if>
                  <xsl:if test="$min_upload_date != ''">
                     <xsl:text>min_upload_date</xsl:text>
                     <xsl:value-of select="$min_upload_date"/>
                  </xsl:if>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$privacy_filter != ''">
                     <xsl:text>privacy_filter</xsl:text>
                     <xsl:value-of select="$privacy_filter"/>
                  </xsl:if>
                  <xsl:if test="$sort != ''">
                     <xsl:text>sort</xsl:text>
                     <xsl:value-of select="$sort"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.getWithoutGeoData'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.recentlyUpdated">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="min_date" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$min_date != ''">
            <xsl:text>&amp;min_date=</xsl:text>
            <xsl:value-of select="$min_date"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.recentlyUpdated</xsl:text>
                  <xsl:if test="$min_date != ''">
                     <xsl:text>min_date</xsl:text>
                     <xsl:value-of select="$min_date"/>
                  </xsl:if>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.recentlyUpdated'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.removeTag">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="tag_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$tag_id != ''">
            <xsl:text>&amp;tag_id=</xsl:text>
            <xsl:value-of select="$tag_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.removeTag</xsl:text>
                  <xsl:if test="$tag_id != ''">
                     <xsl:text>tag_id</xsl:text>
                     <xsl:value-of select="$tag_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.removeTag'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.search">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:param name="tags" select="''"/>
      <xsl:param name="tag_mode" select="''"/>
      <xsl:param name="text" select="''"/>
      <xsl:param name="min_upload_date" select="''"/>
      <xsl:param name="max_upload_date" select="''"/>
      <xsl:param name="min_taken_date" select="''"/>
      <xsl:param name="max_taken_date" select="''"/>
      <xsl:param name="license" select="''"/>
      <xsl:param name="sort" select="''"/>
      <xsl:param name="privacy_filter" select="''"/>
      <xsl:param name="bbox" select="''"/>
      <xsl:param name="accuracy" select="''"/>
      <xsl:param name="extras" select="''"/>
      <xsl:param name="per_page" select="''"/>
      <xsl:param name="page" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$tags != ''">
            <xsl:text>&amp;tags=</xsl:text>
            <xsl:value-of select="$tags"/>
         </xsl:if>
         <xsl:if test="$tag_mode != ''">
            <xsl:text>&amp;tag_mode=</xsl:text>
            <xsl:value-of select="$tag_mode"/>
         </xsl:if>
         <xsl:if test="$text != ''">
            <xsl:text>&amp;text=</xsl:text>
            <xsl:value-of select="$text"/>
         </xsl:if>
         <xsl:if test="$min_upload_date != ''">
            <xsl:text>&amp;min_upload_date=</xsl:text>
            <xsl:value-of select="$min_upload_date"/>
         </xsl:if>
         <xsl:if test="$max_upload_date != ''">
            <xsl:text>&amp;max_upload_date=</xsl:text>
            <xsl:value-of select="$max_upload_date"/>
         </xsl:if>
         <xsl:if test="$min_taken_date != ''">
            <xsl:text>&amp;min_taken_date=</xsl:text>
            <xsl:value-of select="$min_taken_date"/>
         </xsl:if>
         <xsl:if test="$max_taken_date != ''">
            <xsl:text>&amp;max_taken_date=</xsl:text>
            <xsl:value-of select="$max_taken_date"/>
         </xsl:if>
         <xsl:if test="$license != ''">
            <xsl:text>&amp;license=</xsl:text>
            <xsl:value-of select="$license"/>
         </xsl:if>
         <xsl:if test="$sort != ''">
            <xsl:text>&amp;sort=</xsl:text>
            <xsl:value-of select="$sort"/>
         </xsl:if>
         <xsl:if test="$privacy_filter != ''">
            <xsl:text>&amp;privacy_filter=</xsl:text>
            <xsl:value-of select="$privacy_filter"/>
         </xsl:if>
         <xsl:if test="$bbox != ''">
            <xsl:text>&amp;bbox=</xsl:text>
            <xsl:value-of select="$bbox"/>
         </xsl:if>
         <xsl:if test="$accuracy != ''">
            <xsl:text>&amp;accuracy=</xsl:text>
            <xsl:value-of select="$accuracy"/>
         </xsl:if>
         <xsl:if test="$extras != ''">
            <xsl:text>&amp;extras=</xsl:text>
            <xsl:value-of select="$extras"/>
         </xsl:if>
         <xsl:if test="$per_page != ''">
            <xsl:text>&amp;per_page=</xsl:text>
            <xsl:value-of select="$per_page"/>
         </xsl:if>
         <xsl:if test="$page != ''">
            <xsl:text>&amp;page=</xsl:text>
            <xsl:value-of select="$page"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$accuracy != ''">
                     <xsl:text>accuracy</xsl:text>
                     <xsl:value-of select="$accuracy"/>
                  </xsl:if>
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$bbox != ''">
                     <xsl:text>bbox</xsl:text>
                     <xsl:value-of select="$bbox"/>
                  </xsl:if>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:if test="$license != ''">
                     <xsl:text>license</xsl:text>
                     <xsl:value-of select="$license"/>
                  </xsl:if>
                  <xsl:if test="$max_taken_date != ''">
                     <xsl:text>max_taken_date</xsl:text>
                     <xsl:value-of select="$max_taken_date"/>
                  </xsl:if>
                  <xsl:if test="$max_upload_date != ''">
                     <xsl:text>max_upload_date</xsl:text>
                     <xsl:value-of select="$max_upload_date"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.search</xsl:text>
                  <xsl:if test="$min_taken_date != ''">
                     <xsl:text>min_taken_date</xsl:text>
                     <xsl:value-of select="$min_taken_date"/>
                  </xsl:if>
                  <xsl:if test="$min_upload_date != ''">
                     <xsl:text>min_upload_date</xsl:text>
                     <xsl:value-of select="$min_upload_date"/>
                  </xsl:if>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$privacy_filter != ''">
                     <xsl:text>privacy_filter</xsl:text>
                     <xsl:value-of select="$privacy_filter"/>
                  </xsl:if>
                  <xsl:if test="$sort != ''">
                     <xsl:text>sort</xsl:text>
                     <xsl:value-of select="$sort"/>
                  </xsl:if>
                  <xsl:if test="$tag_mode != ''">
                     <xsl:text>tag_mode</xsl:text>
                     <xsl:value-of select="$tag_mode"/>
                  </xsl:if>
                  <xsl:if test="$tags != ''">
                     <xsl:text>tags</xsl:text>
                     <xsl:value-of select="$tags"/>
                  </xsl:if>
                  <xsl:if test="$text != ''">
                     <xsl:text>text</xsl:text>
                     <xsl:value-of select="$text"/>
                  </xsl:if>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.search'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.setDates">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="date_posted" select="''"/>
      <xsl:param name="date_taken" select="''"/>
      <xsl:param name="date_taken_granularity" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$date_posted != ''">
            <xsl:text>&amp;date_posted=</xsl:text>
            <xsl:value-of select="$date_posted"/>
         </xsl:if>
         <xsl:if test="$date_taken != ''">
            <xsl:text>&amp;date_taken=</xsl:text>
            <xsl:value-of select="$date_taken"/>
         </xsl:if>
         <xsl:if test="$date_taken_granularity != ''">
            <xsl:text>&amp;date_taken_granularity=</xsl:text>
            <xsl:value-of select="$date_taken_granularity"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$date_posted != ''">
                     <xsl:text>date_posted</xsl:text>
                     <xsl:value-of select="$date_posted"/>
                  </xsl:if>
                  <xsl:if test="$date_taken != ''">
                     <xsl:text>date_taken</xsl:text>
                     <xsl:value-of select="$date_taken"/>
                  </xsl:if>
                  <xsl:if test="$date_taken_granularity != ''">
                     <xsl:text>date_taken_granularity</xsl:text>
                     <xsl:value-of select="$date_taken_granularity"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.setDates</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.setDates'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.setMeta">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="title" select="''"/>
      <xsl:param name="description" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$title != ''">
            <xsl:text>&amp;title=</xsl:text>
            <xsl:value-of select="$title"/>
         </xsl:if>
         <xsl:if test="$description != ''">
            <xsl:text>&amp;description=</xsl:text>
            <xsl:value-of select="$description"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$description != ''">
                     <xsl:text>description</xsl:text>
                     <xsl:value-of select="$description"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.setMeta</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
                  <xsl:if test="$title != ''">
                     <xsl:text>title</xsl:text>
                     <xsl:value-of select="$title"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.setMeta'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.setPerms">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="is_public" select="''"/>
      <xsl:param name="is_friend" select="''"/>
      <xsl:param name="is_family" select="''"/>
      <xsl:param name="perm_comment" select="''"/>
      <xsl:param name="perm_addmeta" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$is_public != ''">
            <xsl:text>&amp;is_public=</xsl:text>
            <xsl:value-of select="$is_public"/>
         </xsl:if>
         <xsl:if test="$is_friend != ''">
            <xsl:text>&amp;is_friend=</xsl:text>
            <xsl:value-of select="$is_friend"/>
         </xsl:if>
         <xsl:if test="$is_family != ''">
            <xsl:text>&amp;is_family=</xsl:text>
            <xsl:value-of select="$is_family"/>
         </xsl:if>
         <xsl:if test="$perm_comment != ''">
            <xsl:text>&amp;perm_comment=</xsl:text>
            <xsl:value-of select="$perm_comment"/>
         </xsl:if>
         <xsl:if test="$perm_addmeta != ''">
            <xsl:text>&amp;perm_addmeta=</xsl:text>
            <xsl:value-of select="$perm_addmeta"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$is_family != ''">
                     <xsl:text>is_family</xsl:text>
                     <xsl:value-of select="$is_family"/>
                  </xsl:if>
                  <xsl:if test="$is_friend != ''">
                     <xsl:text>is_friend</xsl:text>
                     <xsl:value-of select="$is_friend"/>
                  </xsl:if>
                  <xsl:if test="$is_public != ''">
                     <xsl:text>is_public</xsl:text>
                     <xsl:value-of select="$is_public"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.setPerms</xsl:text>
                  <xsl:if test="$perm_addmeta != ''">
                     <xsl:text>perm_addmeta</xsl:text>
                     <xsl:value-of select="$perm_addmeta"/>
                  </xsl:if>
                  <xsl:if test="$perm_comment != ''">
                     <xsl:text>perm_comment</xsl:text>
                     <xsl:value-of select="$perm_comment"/>
                  </xsl:if>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.setPerms'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.setTags">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="tags" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$tags != ''">
            <xsl:text>&amp;tags=</xsl:text>
            <xsl:value-of select="$tags"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.setTags</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
                  <xsl:if test="$tags != ''">
                     <xsl:text>tags</xsl:text>
                     <xsl:value-of select="$tags"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.setTags'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.comments.addComment">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="comment_text" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$comment_text != ''">
            <xsl:text>&amp;comment_text=</xsl:text>
            <xsl:value-of select="$comment_text"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$comment_text != ''">
                     <xsl:text>comment_text</xsl:text>
                     <xsl:value-of select="$comment_text"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.comments.addComment</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.comments.addComment'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.comments.deleteComment">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="comment_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$comment_id != ''">
            <xsl:text>&amp;comment_id=</xsl:text>
            <xsl:value-of select="$comment_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$comment_id != ''">
                     <xsl:text>comment_id</xsl:text>
                     <xsl:value-of select="$comment_id"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.comments.deleteComment</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.comments.deleteComment'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.comments.editComment">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="comment_id" select="''"/>
      <xsl:param name="comment_text" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$comment_id != ''">
            <xsl:text>&amp;comment_id=</xsl:text>
            <xsl:value-of select="$comment_id"/>
         </xsl:if>
         <xsl:if test="$comment_text != ''">
            <xsl:text>&amp;comment_text=</xsl:text>
            <xsl:value-of select="$comment_text"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$comment_id != ''">
                     <xsl:text>comment_id</xsl:text>
                     <xsl:value-of select="$comment_id"/>
                  </xsl:if>
                  <xsl:if test="$comment_text != ''">
                     <xsl:text>comment_text</xsl:text>
                     <xsl:value-of select="$comment_text"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.comments.editComment</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.comments.editComment'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.comments.getList">
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
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.comments.getList</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.comments.getList'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.geo.getLocation">
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
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.geo.getLocation</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.geo.getLocation'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.geo.getPerms">
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
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.geo.getPerms</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.geo.getPerms'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.geo.removeLocation">
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
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.geo.removeLocation</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.geo.removeLocation'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.geo.setLocation">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="lat" select="''"/>
      <xsl:param name="lon" select="''"/>
      <xsl:param name="accuracy" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$lat != ''">
            <xsl:text>&amp;lat=</xsl:text>
            <xsl:value-of select="$lat"/>
         </xsl:if>
         <xsl:if test="$lon != ''">
            <xsl:text>&amp;lon=</xsl:text>
            <xsl:value-of select="$lon"/>
         </xsl:if>
         <xsl:if test="$accuracy != ''">
            <xsl:text>&amp;accuracy=</xsl:text>
            <xsl:value-of select="$accuracy"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$accuracy != ''">
                     <xsl:text>accuracy</xsl:text>
                     <xsl:value-of select="$accuracy"/>
                  </xsl:if>
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$lat != ''">
                     <xsl:text>lat</xsl:text>
                     <xsl:value-of select="$lat"/>
                  </xsl:if>
                  <xsl:if test="$lon != ''">
                     <xsl:text>lon</xsl:text>
                     <xsl:value-of select="$lon"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.geo.setLocation</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.geo.setLocation'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.geo.setPerms">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="is_public" select="''"/>
      <xsl:param name="is_contact" select="''"/>
      <xsl:param name="is_friend" select="''"/>
      <xsl:param name="is_family" select="''"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$is_public != ''">
            <xsl:text>&amp;is_public=</xsl:text>
            <xsl:value-of select="$is_public"/>
         </xsl:if>
         <xsl:if test="$is_contact != ''">
            <xsl:text>&amp;is_contact=</xsl:text>
            <xsl:value-of select="$is_contact"/>
         </xsl:if>
         <xsl:if test="$is_friend != ''">
            <xsl:text>&amp;is_friend=</xsl:text>
            <xsl:value-of select="$is_friend"/>
         </xsl:if>
         <xsl:if test="$is_family != ''">
            <xsl:text>&amp;is_family=</xsl:text>
            <xsl:value-of select="$is_family"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$is_contact != ''">
                     <xsl:text>is_contact</xsl:text>
                     <xsl:value-of select="$is_contact"/>
                  </xsl:if>
                  <xsl:if test="$is_family != ''">
                     <xsl:text>is_family</xsl:text>
                     <xsl:value-of select="$is_family"/>
                  </xsl:if>
                  <xsl:if test="$is_friend != ''">
                     <xsl:text>is_friend</xsl:text>
                     <xsl:value-of select="$is_friend"/>
                  </xsl:if>
                  <xsl:if test="$is_public != ''">
                     <xsl:text>is_public</xsl:text>
                     <xsl:value-of select="$is_public"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.geo.setPerms</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.geo.setPerms'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.licenses.getInfo">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.licenses.getInfo</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.licenses.getInfo'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.licenses.setLicense">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="license_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$license_id != ''">
            <xsl:text>&amp;license_id=</xsl:text>
            <xsl:value-of select="$license_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$license_id != ''">
                     <xsl:text>license_id</xsl:text>
                     <xsl:value-of select="$license_id"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.licenses.setLicense</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.licenses.setLicense'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.notes.add">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="note_x" select="''"/>
      <xsl:param name="note_y" select="''"/>
      <xsl:param name="note_w" select="''"/>
      <xsl:param name="note_h" select="''"/>
      <xsl:param name="note_text" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$note_x != ''">
            <xsl:text>&amp;note_x=</xsl:text>
            <xsl:value-of select="$note_x"/>
         </xsl:if>
         <xsl:if test="$note_y != ''">
            <xsl:text>&amp;note_y=</xsl:text>
            <xsl:value-of select="$note_y"/>
         </xsl:if>
         <xsl:if test="$note_w != ''">
            <xsl:text>&amp;note_w=</xsl:text>
            <xsl:value-of select="$note_w"/>
         </xsl:if>
         <xsl:if test="$note_h != ''">
            <xsl:text>&amp;note_h=</xsl:text>
            <xsl:value-of select="$note_h"/>
         </xsl:if>
         <xsl:if test="$note_text != ''">
            <xsl:text>&amp;note_text=</xsl:text>
            <xsl:value-of select="$note_text"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.notes.add</xsl:text>
                  <xsl:if test="$note_h != ''">
                     <xsl:text>note_h</xsl:text>
                     <xsl:value-of select="$note_h"/>
                  </xsl:if>
                  <xsl:if test="$note_text != ''">
                     <xsl:text>note_text</xsl:text>
                     <xsl:value-of select="$note_text"/>
                  </xsl:if>
                  <xsl:if test="$note_w != ''">
                     <xsl:text>note_w</xsl:text>
                     <xsl:value-of select="$note_w"/>
                  </xsl:if>
                  <xsl:if test="$note_x != ''">
                     <xsl:text>note_x</xsl:text>
                     <xsl:value-of select="$note_x"/>
                  </xsl:if>
                  <xsl:if test="$note_y != ''">
                     <xsl:text>note_y</xsl:text>
                     <xsl:value-of select="$note_y"/>
                  </xsl:if>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.notes.add'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.notes.delete">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="note_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$note_id != ''">
            <xsl:text>&amp;note_id=</xsl:text>
            <xsl:value-of select="$note_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.notes.delete</xsl:text>
                  <xsl:if test="$note_id != ''">
                     <xsl:text>note_id</xsl:text>
                     <xsl:value-of select="$note_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.notes.delete'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.notes.edit">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="note_id" select="''"/>
      <xsl:param name="note_x" select="''"/>
      <xsl:param name="note_y" select="''"/>
      <xsl:param name="note_w" select="''"/>
      <xsl:param name="note_h" select="''"/>
      <xsl:param name="note_text" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$note_id != ''">
            <xsl:text>&amp;note_id=</xsl:text>
            <xsl:value-of select="$note_id"/>
         </xsl:if>
         <xsl:if test="$note_x != ''">
            <xsl:text>&amp;note_x=</xsl:text>
            <xsl:value-of select="$note_x"/>
         </xsl:if>
         <xsl:if test="$note_y != ''">
            <xsl:text>&amp;note_y=</xsl:text>
            <xsl:value-of select="$note_y"/>
         </xsl:if>
         <xsl:if test="$note_w != ''">
            <xsl:text>&amp;note_w=</xsl:text>
            <xsl:value-of select="$note_w"/>
         </xsl:if>
         <xsl:if test="$note_h != ''">
            <xsl:text>&amp;note_h=</xsl:text>
            <xsl:value-of select="$note_h"/>
         </xsl:if>
         <xsl:if test="$note_text != ''">
            <xsl:text>&amp;note_text=</xsl:text>
            <xsl:value-of select="$note_text"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.notes.edit</xsl:text>
                  <xsl:if test="$note_h != ''">
                     <xsl:text>note_h</xsl:text>
                     <xsl:value-of select="$note_h"/>
                  </xsl:if>
                  <xsl:if test="$note_id != ''">
                     <xsl:text>note_id</xsl:text>
                     <xsl:value-of select="$note_id"/>
                  </xsl:if>
                  <xsl:if test="$note_text != ''">
                     <xsl:text>note_text</xsl:text>
                     <xsl:value-of select="$note_text"/>
                  </xsl:if>
                  <xsl:if test="$note_w != ''">
                     <xsl:text>note_w</xsl:text>
                     <xsl:value-of select="$note_w"/>
                  </xsl:if>
                  <xsl:if test="$note_x != ''">
                     <xsl:text>note_x</xsl:text>
                     <xsl:value-of select="$note_x"/>
                  </xsl:if>
                  <xsl:if test="$note_y != ''">
                     <xsl:text>note_y</xsl:text>
                     <xsl:value-of select="$note_y"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.notes.edit'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.transform.rotate">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="degrees" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$degrees != ''">
            <xsl:text>&amp;degrees=</xsl:text>
            <xsl:value-of select="$degrees"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$degrees != ''">
                     <xsl:text>degrees</xsl:text>
                     <xsl:value-of select="$degrees"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photos.transform.rotate</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.transform.rotate'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photos.upload.checkTickets">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="tickets" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$tickets != ''">
            <xsl:text>&amp;tickets=</xsl:text>
            <xsl:value-of select="$tickets"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photos.upload.checkTickets</xsl:text>
                  <xsl:if test="$tickets != ''">
                     <xsl:text>tickets</xsl:text>
                     <xsl:value-of select="$tickets"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photos.upload.checkTickets'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.addPhoto">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photoset_id" select="''"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photoset_id != ''">
            <xsl:text>&amp;photoset_id=</xsl:text>
            <xsl:value-of select="$photoset_id"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photosets.addPhoto</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
                  <xsl:if test="$photoset_id != ''">
                     <xsl:text>photoset_id</xsl:text>
                     <xsl:value-of select="$photoset_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.addPhoto'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.create">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="title" select="''"/>
      <xsl:param name="description" select="''"/>
      <xsl:param name="primary_photo_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$title != ''">
            <xsl:text>&amp;title=</xsl:text>
            <xsl:value-of select="$title"/>
         </xsl:if>
         <xsl:if test="$description != ''">
            <xsl:text>&amp;description=</xsl:text>
            <xsl:value-of select="$description"/>
         </xsl:if>
         <xsl:if test="$primary_photo_id != ''">
            <xsl:text>&amp;primary_photo_id=</xsl:text>
            <xsl:value-of select="$primary_photo_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$description != ''">
                     <xsl:text>description</xsl:text>
                     <xsl:value-of select="$description"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photosets.create</xsl:text>
                  <xsl:if test="$primary_photo_id != ''">
                     <xsl:text>primary_photo_id</xsl:text>
                     <xsl:value-of select="$primary_photo_id"/>
                  </xsl:if>
                  <xsl:if test="$title != ''">
                     <xsl:text>title</xsl:text>
                     <xsl:value-of select="$title"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.create'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.delete">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photoset_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photoset_id != ''">
            <xsl:text>&amp;photoset_id=</xsl:text>
            <xsl:value-of select="$photoset_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photosets.delete</xsl:text>
                  <xsl:if test="$photoset_id != ''">
                     <xsl:text>photoset_id</xsl:text>
                     <xsl:value-of select="$photoset_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.delete'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.editMeta">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photoset_id" select="''"/>
      <xsl:param name="title" select="''"/>
      <xsl:param name="description" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photoset_id != ''">
            <xsl:text>&amp;photoset_id=</xsl:text>
            <xsl:value-of select="$photoset_id"/>
         </xsl:if>
         <xsl:if test="$title != ''">
            <xsl:text>&amp;title=</xsl:text>
            <xsl:value-of select="$title"/>
         </xsl:if>
         <xsl:if test="$description != ''">
            <xsl:text>&amp;description=</xsl:text>
            <xsl:value-of select="$description"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$description != ''">
                     <xsl:text>description</xsl:text>
                     <xsl:value-of select="$description"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photosets.editMeta</xsl:text>
                  <xsl:if test="$photoset_id != ''">
                     <xsl:text>photoset_id</xsl:text>
                     <xsl:value-of select="$photoset_id"/>
                  </xsl:if>
                  <xsl:if test="$title != ''">
                     <xsl:text>title</xsl:text>
                     <xsl:value-of select="$title"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.editMeta'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.editPhotos">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photoset_id" select="''"/>
      <xsl:param name="primary_photo_id" select="''"/>
      <xsl:param name="photo_ids" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photoset_id != ''">
            <xsl:text>&amp;photoset_id=</xsl:text>
            <xsl:value-of select="$photoset_id"/>
         </xsl:if>
         <xsl:if test="$primary_photo_id != ''">
            <xsl:text>&amp;primary_photo_id=</xsl:text>
            <xsl:value-of select="$primary_photo_id"/>
         </xsl:if>
         <xsl:if test="$photo_ids != ''">
            <xsl:text>&amp;photo_ids=</xsl:text>
            <xsl:value-of select="$photo_ids"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photosets.editPhotos</xsl:text>
                  <xsl:if test="$photo_ids != ''">
                     <xsl:text>photo_ids</xsl:text>
                     <xsl:value-of select="$photo_ids"/>
                  </xsl:if>
                  <xsl:if test="$photoset_id != ''">
                     <xsl:text>photoset_id</xsl:text>
                     <xsl:value-of select="$photoset_id"/>
                  </xsl:if>
                  <xsl:if test="$primary_photo_id != ''">
                     <xsl:text>primary_photo_id</xsl:text>
                     <xsl:value-of select="$primary_photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.editPhotos'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.getContext">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:param name="photoset_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="$photoset_id != ''">
            <xsl:text>&amp;photoset_id=</xsl:text>
            <xsl:value-of select="$photoset_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photosets.getContext</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
                  <xsl:if test="$photoset_id != ''">
                     <xsl:text>photoset_id</xsl:text>
                     <xsl:value-of select="$photoset_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.getContext'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.getInfo">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photoset_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photoset_id != ''">
            <xsl:text>&amp;photoset_id=</xsl:text>
            <xsl:value-of select="$photoset_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photosets.getInfo</xsl:text>
                  <xsl:if test="$photoset_id != ''">
                     <xsl:text>photoset_id</xsl:text>
                     <xsl:value-of select="$photoset_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.getInfo'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.getList">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photosets.getList</xsl:text>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.getList'"/>
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
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$extras != ''">
                     <xsl:text>extras</xsl:text>
                     <xsl:value-of select="$extras"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photosets.getPhotos</xsl:text>
                  <xsl:if test="$page != ''">
                     <xsl:text>page</xsl:text>
                     <xsl:value-of select="$page"/>
                  </xsl:if>
                  <xsl:if test="$per_page != ''">
                     <xsl:text>per_page</xsl:text>
                     <xsl:value-of select="$per_page"/>
                  </xsl:if>
                  <xsl:if test="$photoset_id != ''">
                     <xsl:text>photoset_id</xsl:text>
                     <xsl:value-of select="$photoset_id"/>
                  </xsl:if>
                  <xsl:if test="$privacy_filter != ''">
                     <xsl:text>privacy_filter</xsl:text>
                     <xsl:value-of select="$privacy_filter"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.getPhotos'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.orderSets">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photoset_ids" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photoset_ids != ''">
            <xsl:text>&amp;photoset_ids=</xsl:text>
            <xsl:value-of select="$photoset_ids"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photosets.orderSets</xsl:text>
                  <xsl:if test="$photoset_ids != ''">
                     <xsl:text>photoset_ids</xsl:text>
                     <xsl:value-of select="$photoset_ids"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.orderSets'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.removePhoto">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photoset_id" select="''"/>
      <xsl:param name="photo_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photoset_id != ''">
            <xsl:text>&amp;photoset_id=</xsl:text>
            <xsl:value-of select="$photoset_id"/>
         </xsl:if>
         <xsl:if test="$photo_id != ''">
            <xsl:text>&amp;photo_id=</xsl:text>
            <xsl:value-of select="$photo_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photosets.removePhoto</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
                  <xsl:if test="$photoset_id != ''">
                     <xsl:text>photoset_id</xsl:text>
                     <xsl:value-of select="$photoset_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.removePhoto'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.comments.addComment">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photoset_id" select="''"/>
      <xsl:param name="comment_text" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photoset_id != ''">
            <xsl:text>&amp;photoset_id=</xsl:text>
            <xsl:value-of select="$photoset_id"/>
         </xsl:if>
         <xsl:if test="$comment_text != ''">
            <xsl:text>&amp;comment_text=</xsl:text>
            <xsl:value-of select="$comment_text"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$comment_text != ''">
                     <xsl:text>comment_text</xsl:text>
                     <xsl:value-of select="$comment_text"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photosets.comments.addComment</xsl:text>
                  <xsl:if test="$photoset_id != ''">
                     <xsl:text>photoset_id</xsl:text>
                     <xsl:value-of select="$photoset_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.comments.addComment'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.comments.deleteComment">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="comment_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$comment_id != ''">
            <xsl:text>&amp;comment_id=</xsl:text>
            <xsl:value-of select="$comment_id"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$comment_id != ''">
                     <xsl:text>comment_id</xsl:text>
                     <xsl:value-of select="$comment_id"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photosets.comments.deleteComment</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.comments.deleteComment'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.comments.editComment">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="comment_id" select="''"/>
      <xsl:param name="comment_text" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$comment_id != ''">
            <xsl:text>&amp;comment_id=</xsl:text>
            <xsl:value-of select="$comment_id"/>
         </xsl:if>
         <xsl:if test="$comment_text != ''">
            <xsl:text>&amp;comment_text=</xsl:text>
            <xsl:value-of select="$comment_text"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$comment_id != ''">
                     <xsl:text>comment_id</xsl:text>
                     <xsl:value-of select="$comment_id"/>
                  </xsl:if>
                  <xsl:if test="$comment_text != ''">
                     <xsl:text>comment_text</xsl:text>
                     <xsl:value-of select="$comment_text"/>
                  </xsl:if>
                  <xsl:text>methodflickr.photosets.comments.editComment</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.comments.editComment'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:photosets.comments.getList">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="photoset_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$photoset_id != ''">
            <xsl:text>&amp;photoset_id=</xsl:text>
            <xsl:value-of select="$photoset_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.photosets.comments.getList</xsl:text>
                  <xsl:if test="$photoset_id != ''">
                     <xsl:text>photoset_id</xsl:text>
                     <xsl:value-of select="$photoset_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.photosets.comments.getList'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:reflection.getMethodInfo">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="method_name" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$method_name != ''">
            <xsl:text>&amp;method_name=</xsl:text>
            <xsl:value-of select="$method_name"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.reflection.getMethodInfo</xsl:text>
                  <xsl:if test="$method_name != ''">
                     <xsl:text>method_name</xsl:text>
                     <xsl:value-of select="$method_name"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.reflection.getMethodInfo'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:reflection.getMethods">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.reflection.getMethods</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.reflection.getMethods'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:tags.getHotList">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="period" select="''"/>
      <xsl:param name="count" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$period != ''">
            <xsl:text>&amp;period=</xsl:text>
            <xsl:value-of select="$period"/>
         </xsl:if>
         <xsl:if test="$count != ''">
            <xsl:text>&amp;count=</xsl:text>
            <xsl:value-of select="$count"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$count != ''">
                     <xsl:text>count</xsl:text>
                     <xsl:value-of select="$count"/>
                  </xsl:if>
                  <xsl:text>methodflickr.tags.getHotList</xsl:text>
                  <xsl:if test="$period != ''">
                     <xsl:text>period</xsl:text>
                     <xsl:value-of select="$period"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.tags.getHotList'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:tags.getListPhoto">
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
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.tags.getListPhoto</xsl:text>
                  <xsl:if test="$photo_id != ''">
                     <xsl:text>photo_id</xsl:text>
                     <xsl:value-of select="$photo_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.tags.getListPhoto'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:tags.getListUser">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.tags.getListUser</xsl:text>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.tags.getListUser'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:tags.getListUserPopular">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:param name="count" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$count != ''">
            <xsl:text>&amp;count=</xsl:text>
            <xsl:value-of select="$count"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$count != ''">
                     <xsl:text>count</xsl:text>
                     <xsl:value-of select="$count"/>
                  </xsl:if>
                  <xsl:text>methodflickr.tags.getListUserPopular</xsl:text>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.tags.getListUserPopular'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:tags.getListUserRaw">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="tag" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$tag != ''">
            <xsl:text>&amp;tag=</xsl:text>
            <xsl:value-of select="$tag"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.tags.getListUserRaw</xsl:text>
                  <xsl:if test="$tag != ''">
                     <xsl:text>tag</xsl:text>
                     <xsl:value-of select="$tag"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.tags.getListUserRaw'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:tags.getRelated">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="tag" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$tag != ''">
            <xsl:text>&amp;tag=</xsl:text>
            <xsl:value-of select="$tag"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.tags.getRelated</xsl:text>
                  <xsl:if test="$tag != ''">
                     <xsl:text>tag</xsl:text>
                     <xsl:value-of select="$tag"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.tags.getRelated'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:test.echo">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.test.echo</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.test.echo'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:test.login">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.test.login</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.test.login'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:test.null">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="true() or $f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.test.null</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.test.null'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:urls.getGroup">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="group_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$group_id != ''">
            <xsl:text>&amp;group_id=</xsl:text>
            <xsl:value-of select="$group_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:if test="$group_id != ''">
                     <xsl:text>group_id</xsl:text>
                     <xsl:value-of select="$group_id"/>
                  </xsl:if>
                  <xsl:text>methodflickr.urls.getGroup</xsl:text>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.urls.getGroup'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:urls.getUserPhotos">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.urls.getUserPhotos</xsl:text>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.urls.getUserPhotos'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:urls.getUserProfile">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="user_id" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$user_id != ''">
            <xsl:text>&amp;user_id=</xsl:text>
            <xsl:value-of select="$user_id"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.urls.getUserProfile</xsl:text>
                  <xsl:if test="$user_id != ''">
                     <xsl:text>user_id</xsl:text>
                     <xsl:value-of select="$user_id"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.urls.getUserProfile'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:urls.lookupGroup">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="url" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$url != ''">
            <xsl:text>&amp;url=</xsl:text>
            <xsl:value-of select="$url"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.urls.lookupGroup</xsl:text>
                  <xsl:if test="$url != ''">
                     <xsl:text>url</xsl:text>
                     <xsl:value-of select="$url"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.urls.lookupGroup'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="f:urls.lookupUser">
      <xsl:param name="api_key" select="$f:api_key"/>
      <xsl:param name="url" select="''"/>
      <xsl:variable name="uriparams">
         <xsl:if test="$api_key != ''">
            <xsl:text>&amp;api_key=</xsl:text>
            <xsl:value-of select="$api_key"/>
         </xsl:if>
         <xsl:if test="$url != ''">
            <xsl:text>&amp;url=</xsl:text>
            <xsl:value-of select="$url"/>
         </xsl:if>
         <xsl:if test="$f:auth_token != ''">
            <xsl:text>&amp;auth_token=</xsl:text>
            <xsl:value-of select="$f:auth_token"/>
            <xsl:text>&amp;api_sig=</xsl:text>
            <xsl:call-template name="f:flickr.auth">
               <xsl:with-param name="sig">
                  <xsl:if test="$api_key != ''">
                     <xsl:text>api_key</xsl:text>
                     <xsl:value-of select="$api_key"/>
                  </xsl:if>
                  <xsl:text>auth_token</xsl:text>
                  <xsl:value-of select="$f:auth_token"/>
                  <xsl:text>methodflickr.urls.lookupUser</xsl:text>
                  <xsl:if test="$url != ''">
                     <xsl:text>url</xsl:text>
                     <xsl:value-of select="$url"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <xsl:call-template name="f:flickr">
         <xsl:with-param name="method" select="'flickr.urls.lookupUser'"/>
         <xsl:with-param name="uriparams" select="$uriparams"/>
      </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>