<?php
// Get the template Id as a URL parameter

// if id or type not passed as parameter
if(   (!isset($_REQUEST['id']) )
   || (!isset($_REQUEST['type']) ) ) {
	$id = $_REQUEST['id'];
	$type = $_REQUEST['type'];
} else {

  $id = $_REQUEST['id'];
  $type = $_REQUEST['type'];
}

	// tdi-dev: TDI/_cascade/templates/Standard Page
	//$templateId = "556cef9f0a2295fe03fd8ab6b9df794f";

	if ( $_REQUEST['auth'] ) {
		switch ($_REQUEST['auth']) {
			case 'prod':	require_once( 'auth_prod.php' ); 			break;
			case 'dev':		require_once( 'auth_dev.php' );				break;
			default:			require_once( 'auth_dev.php' );				break;
		}
	} else {
		require_once( 'auth_dev.php' );
	}
	// Get the Cascade instance to authenticate to as a URL parameter


	/* Uses the following classes:
	- Asset class
	  http://upstate.edu/cascade-admin/projects/web-services/oop/classes/asset-classes/
	- Property class
	  http://upstate.edu/cascade-admin/projects/web-services/oop/classes/property-classes/child.php
	  Template::getSubscribers() returns an array of Identifier objects.
	  Identifier objects are Child objects.

	  The Child::getPathPath() method is defined in Child.

	- Utility Class
	  Uses the StringUtility::getNameFromPath( $path ) method to get the asset name from its path.
	  http://www.upstate.edu/cascade-admin/projects/web-services/oop/classes/utility-classes.php
	  The Child::getPathPath() method is defined in Child.
	  Note that for a child, there is no name. Therefore, there is no getName method. But if you want to get the name of an asset from a path, use StringUtility::getNameFromPath( $path ), and if you are interested in the parent container of the asset, use StringUtility::getParentPathFromPath( $path ).To get the name of an asset from a path, use
	*/
	use cascade_ws_AOHS      as aohs;
	use cascade_ws_constants as c;
	use cascade_ws_asset     as a;
	use cascade_ws_property  as p;
	use cascade_ws_utility   as u;
	use cascade_ws_exception as e;

	// Gets the related pages for a content type
	function getCTRelationships( $contentType, $service ) {
		// get related content types
		$pages = $contentType->getAsset( $service )->getSubscribers();
		$pageCount = $indexBlock = $other = 0;
		$ctRelCount = count( $pages );
		if( $ctRelCount > 0 ) {
			echo "\t\t\t<ol>\n";	// content types
			foreach( $pages as $page ) { // PAGE
				echo "\t\t\t\t<li>[". $page->getType() ."] site://" . $page->getPathSiteName() . "/" . $page->getPathPath() . "\r\n";
				switch ( $page->getType() ) {
					case 'page':
						$pageCount ++;	break;
					case 'block_INDEX':
						$indexBlock ++;	break;
					defaolt:
						$other ++;break;
				}
			}
			echo "\t\t\t</ol>\n";	// content types
		}
		return $pageCount;
	}

	// Gets the related content types for a configuration set
	function getConfSetRels( $configSet, $service) {
		$pageCount = 0;

		// get related content types
		$contentTypes = $configSet->getAsset( $service )->getSubscribers();

		echo "\t\t<ol>\n";	// content types
		// loop through related content types
		foreach( $contentTypes as $contentType ) {
			// $contentTypeName = u\StringUtility::getNameFromPath($contentType->getPathPath());
			echo "\t\t\t<li>site://" . $contentType->getPathSiteName() . "/" . $contentType->getPathPath() . " [". $contentType->getType() ."]" . "\r\n";
			// get the related pages for a content type
			$pageCount += getCTRelationships( $contentType, $service );

		} // end foreach
		echo "\t\t</ol></li>\n"; // close configuration set unordered list

		return $pageCount;
	}

	// Gets the related configuration sets for a template
	function getTemplateRelationships( $template, $service ) {
		$pageCount = 0;
		// [". $template->getType() ."]
		echo "\t<li>site://" . $template->getSiteName() . "/" . $template->getPath() . "\r\n";
		//echo "[".$identifier->type."] site://".$identifier->path->siteName."/".$identifier->path->path."\r\n";

		// get asset's related configuration sets
		$configSets = $template->getSubscribers();

		echo "\t<ol>\n";	// configuration sets
		// loop through each configuration set
		foreach( $configSets as $configSet ) { // CONFIGURATION SET
			echo "\t\t<li>[". $configSet->getType() ."]  site://" . $configSet->getPathSiteName() . "/" . $configSet->getPathPath() . "\r\n";

			$pageCount += getConfSetRels( $configSet, $service);

		} // end foreach
		echo "\t</ol></li>\n";

		return $pageCount;
	}

	function getFormatRelationships( $format, $service) {
		$pageCount = 0;
		echo "\t<li>site://" . $format->getSiteName() . "/" . $format->getPath() . "\r\n";
		$formatRels = $format->getSubscribers();
		echo "\t<ol>\n";
		foreach ($formatRels as $asset) {
			$pageCount = getTemplateRelationships( $asset, $service );
		} // end foreach
		echo "\t</ol></li>\n";
		return $pageCount;
	}

	$pageCount = 0;
	echo "<ol>\n"; // templates
	try {
		// get source asset
		switch ($type) {
			case 'template':
				$asset = $cascade->getAsset(a\Template::TYPE, $id );
				$pageCount = getTemplateRelationships( $asset, $service );
				break;
				// doesn't work
			case 'format':
				$asset = $cascade->getAsset(a\ScriptFormat::TYPE, $id );
				$pageCount = getFormatRelationships( $asset, $service);
				break;
			default:
				echo "<p>Not a Template or Format.</p>";
				break;
		}
		echo "<p><strong>Total Pages: " . $pageCount . "</strong></p>\r\n";
	}
	catch( Exception $e ) {
	    echo S_PRE . $e . E_PRE;
	}
	catch( Error $er ) {
	    echo S_PRE . $er . E_PRE;
	}
	echo "</ol>\n";

?>
