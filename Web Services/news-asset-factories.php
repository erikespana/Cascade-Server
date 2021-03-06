<?php
require_once('auth_espanae.php');

// Set Placement Folder for news asset factories
$articles = 'news/stories/2014/09';
$photos = $articles . '/photos';

// Asset factories to update
$story              = '856a06fc956aa0520003c37ee3ea4e35';
$inTheMedia         = '8aa64e6a956aa07801a565c62180ba82';
$photoLandscape     = '09be0c17956aa05200af1cb10203468a';
$photoPortrait      = '0aac3e18956aa05200af1cb1997c8969';
$galleryLandscape   = '0b0166cc956aa05200af1cb1407a50c9';
$galleryPortrait    = '0aad607f956aa05200af1cb194fbada9';
$noResize           = '0e7d1c4b956aa05200af1cb174f5d4ee';

// Asset factory ID's and corresponding placement folders
$factories = array(
    $story              => $articles,
    $inTheMedia         => $articles,
    $photoLandscape     => $photos,
    $photoPortrait      => $photos,
    $galleryLandscape   => $photos,
    $galleryPortrait    => $photos,
    $noResize           => $photos
);

echo "<h1>Update News Asset Factories</h1>";

// Iterate through news asset factories
foreach ($factories as $key => $value) {
    
    try {
        // Retrieve the asset factory object
        $af = AssetFactory::getAsset( $service, AssetFactory::TYPE, $key);
        echo "<p>Changed <b>" . $af->getId();
        
        // Change placement folder, using the mutating methods defined in the class AssetFactory.
        $a = $af->setPlacementFolder( $cascade->getFolder( $value, 'reboot' ))->edit();
        echo "</b> placement folder to <b>" . $af->getPlacementFolderPath() . "</b></p>";
               
    } catch( Exception $e ) {
        echo S_PRE . $e . E_PRE;
    }
    
}
?>