<?php

function showPage( $identifier ) {
	echo "(page) site://". $identifier->path->siteName ."/". $identifier->path->path . "\r\n";
}

// if template, show configuration sets
function template( $identifier, $auth ) {
  // get template id
  $identifier = array('id' => $identifier->id, 'type' => 'template');

  // get asset subscribers
  $reply = $client->listSubscribers(
    array ( 'authentication' => $auth,
            'identifier' => $identifier )
  );

	//echo "(format) site://". $identifier->path->siteName ."/". $identifier->path->path . "\r\n";
  return 
}
?>
