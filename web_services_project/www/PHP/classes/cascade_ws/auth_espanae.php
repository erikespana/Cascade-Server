<?php 
require_once( 'ws_lib.php' );

$wsdl = "https://oceania.union.edu:8443/ws/services/AssetOperationService?wsdl";
$auth           = new stdClass();
$auth->username = "espanae";
$auth->password = "-";

// set up the service
$service = new AssetOperationHandlerService( $wsdl, $auth );

// create an empty object for a one-time operation
$asset = new stdClass();
?>