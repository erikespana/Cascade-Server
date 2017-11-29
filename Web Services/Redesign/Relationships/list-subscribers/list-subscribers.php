Subscribers:
<pre>
"type", "link"
<?php
require_once('auth-raw-dev.php');
require_once('list-subscribers-functions.php');

// Choose an asset (see type codes below)
//$identifier = array('id' => '556ce20f0a2295fe03fd8ab6c1f2b6ab',	'type' => 'contenttype' );
//$identifier = array('id' => '556cefc40a2295fe03fd8ab6098449e9',	'type' => 'format' );
//$identifier = array('id' => '556ce8c40a2295fe03fd8ab6b3bccb66','type' => 'metadataset');
// TDI/_cascade/formats/default
//$identifier = array('id' => '556cefc40a2295fe03fd8ab6098449e9', 'type' => 'format');
// TDI/_cascade/templates/Standard Page
//$identifier = array('id' => '556cef9f0a2295fe03fd8ab6b9df794f', 'type' => 'template');
$identifier = array('id' => '4950890e0a2295fe0f36697d1de38f2f', 'type' => 'workflowdefinition');

$listSubscribersParams = array ('authentication' => $auth, 'identifier' => $identifier);
// get asset subscribers
$reply = $client->listSubscribers($listSubscribersParams);
/*
returns array: $reply->listSubscribersReturn->subscribers->assetIdentifier
[identifier] => stdClass Object
    (
        [id] => 556cef9f0a2295fe03fd8ab6b9df794f
        [path] => stdClass Object
            (
                [path] => _cascade/templates/Standard Page
                [siteId] => 556cdc190a2295fe03fd8ab658980546
                [siteName] => TDI
            )

        [type] => template
        [recycled] =>
    )
*/
//print_r ($reply);

// check status of web services call
if ($reply->listSubscribersReturn->success=='true')
{
	$subscribers = $reply->listSubscribersReturn->subscribers->assetIdentifier;
	// check if no subscribers found
	if ( sizeof($subscribers) == 0 )
	{
		echo "NONE\r\n";
		exit;
	}
	// check if $subscribers is not array
	else if (!is_array($subscribers)) // For less than 2 elements, the returned object isn't an array
		$subscribers = array($subscribers);

	// loop through array of $subscribers
	foreach( $subscribers as $identifier )

			switch ( $identifier->type ) {
				/*case 'template':
					template($identifier);
					*/

				case 'page':
					showPage($identifier);
					break;

				default:
					echo "[".$identifier->type."] site://".$identifier->path->siteName."/".$identifier->path->path."\r\n";
					break;
			}

}
else
	echo "Error occurred: " . $reply->listSubscribersReturn->message;

/*
Type codes:
assetfactory
assetfactorycontainer
block
block_FEED
block_INDEX
block_TEXT
block_XHTML_DATADEFINITION
block_XML
block_TWITTER_FEED
connectorcontainer
twitterconnector
facebookconnector
wordpressconnector
googleanalyticsconnector
contenttype
contenttypecontainer
destination
editorconfiguration
file
folder
group
message
metadataset
metadatasetcontainer
page
pageconfigurationset
pageconfiguration
pageregion
pageconfigurationsetcontainer
publishset
publishsetcontainer
reference
role
datadefinition
datadefinitioncontainer
format
format_XSLT
format_SCRIPT
site
sitedestinationcontainer
symlink
target
template
transport
transport_fs
transport_ftp
transport_db
transport_cloud
transportcontainer
user
workflow
workflowdefinition
workflowdefinitioncontainer
*/
?>
</pre>
