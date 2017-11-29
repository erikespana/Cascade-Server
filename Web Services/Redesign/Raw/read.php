<?php
require_once('auth-dev.php');

// if id or type not passed as parameter
if(   (!isset($_REQUEST['id']) )
   || (!isset($_REQUEST['type']) ) ) {
     //'path' => array('path' => '/my-xml-block', 'siteName' => 'TDI'),
     //OR
     // metadatasetcontainer (false)
     //$identifier = array('id' => '556cdc190a2295fe03fd8ab658980546','type' => 'metadatasetcontainer');
     // contenttypecontainer [message] => The requested asset does not exist
     /*
     // metadataset (true)
     $identifier = array('id' => '556ce8c40a2295fe03fd8ab6b3bccb66','type' => 'metadataset');
     // contenttypecontainer [message] => The requested asset does not exist
     $identifier = array('id' => '556cdc190a2295fe03fd8ab658980546','type' => 'contenttypecontainer');
     // TDI/_cascade/formats/default
     $identifier = array('id' => '556cefc40a2295fe03fd8ab6098449e9','type' => 'format');
     $id = '628d06f80a2295fe4ad254a30795645a';
     $type = 'metadataset';
     */
     $id = "556cdcd00a2295fe03fd8ab6c21fc671";
     $type = "contenttypecontainer";
} else {

  $id = $_REQUEST['id'];
  $type = $_REQUEST['type'];
}

$identifier = array('id' => $id, 'type' => $type);
$readParams = array ('authentication' => $auth, 'identifier' => $identifier);
$reply = $client->read($readParams);
print_r ($reply);
/*
if ($reply->readReturn->success=='true')
	echo "Success. Block's xml: " . $reply->readReturn->asset->xmlBlock->xml;
else
	echo "Error occurred: " . $reply->readReturn->message;
*/
?>
