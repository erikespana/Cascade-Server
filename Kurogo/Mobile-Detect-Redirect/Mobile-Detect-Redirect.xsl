<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/>

    <xsl:template match="/system-index-block">
    
        <xsl:if test="calling-page/system-page/system-data-structure/includes/mobile != ''">
    
      <xsl:comment>#START-ROOT-CODE
&lt;?php
/* Copyright 2011, Modo Labs, Inc. */
/* See Kurogo Mobile Web LICENSE file for license information */

// include this at the top of your desktop site to redirect mobile devices to your mobile site
// pass ?fullsite=yes to force desktop site

$MOBI_SERVICE_URL = "https://modolabs-device.appspot.com/api/"; // url of device detection server if using external
$MOBI_SERVICE_VERSION = 2; 
$MOBI_SERVICE_TIMEOUT = 2; // if a timeout occurs, no redirection will happen
$MOBI_DETECTION_COOKIE_TIMEOUT = 600; // how long to keep the detection cookie (in seconds)

if ( !isset($_GET['fullsite']) || $_GET['fullsite'] != 'yes' ) {

    $mobile_platforms = array(
        'iphone',
        'android',
        'webos',
        'blackberry',
        'winmo',
        'palmos',
        'symbian',
        'featurephone',
        'bbplus'
    );

    if (isset($_COOKIE['kgo_pagetype'])) {
        $pagetype = $_COOKIE['kgo_pagetype'];
        $platform = $_COOKIE['kgo_platform'];
    } else {
        
        $pagetype = '';
        $platform = '';
        $user_agent = isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : '';

        $query = http_build_query(array(
            'user-agent' =&gt; $user_agent,
            'version'=&gt; $MOBI_SERVICE_VERSION
        ));

        $context = stream_context_create(array('http'=&gt;array('timeout'=&gt;$MOBI_SERVICE_TIMEOUT)));
        $url = $MOBI_SERVICE_URL . '?'.$query;
        if ($json = @file_get_contents($url, false, $context)) {
            $data = @json_decode($json, true);
            
            if (isset($data['pagetype'])) {
                $pagetype = $data['pagetype'];
                setcookie('kgo_pagetype', $pagetype, time() + $MOBI_DETECTION_COOKIE_TIMEOUT);
            }
        
            if (isset($data['platform'])) {
                $platform = $data['platform'];
                setcookie('kgo_platform', $platform, time() + $MOBI_DETECTION_COOKIE_TIMEOUT);
            }
        }     
    }
        
    if ( $pagetype!='tablet' &amp;&amp; in_array($platform, $mobile_platforms) ) {
        // don't redirect if the referrer was from the same site
        $referer = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '';
        if (!preg_match("!^http://" . $_SERVER['HTTP_HOST'] . '/!', $referer)) {
            // insert the URL of your mobile site
            header( "Location: <xsl:value-of select="calling-page/system-page/system-data-structure/includes/mobile"/>" );
            exit;
        }
    }
    
    // not a mobile device. continue on
}
?&gt;
#END-ROOT-CODE</xsl:comment>
    </xsl:if>
    
    </xsl:template>
</xsl:stylesheet>