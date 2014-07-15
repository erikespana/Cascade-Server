<?php
require_once('auth_espanae.php');

// id of asset factory reboot:/Asset Factories/News and Events/Story
$id = '856a06fc956aa0520003c37ee3ea4e35';

// id of folder reboot:/news/stories/2014/08
$targetID = '3a471488956aa05d31803cafed3a9cc9';
$targetPath = 'news/stories/2014/08';

try
{
    $af = AssetFactory::getAsset( $service, AssetFactory::TYPE, $id );
    
    // Try to retrieve an asset factory object (obviously a test object)
    echo L::ID . $af->getId() . BR .
         "Placement folder path: " .
         $af->getPlacementFolderPath() . BR .
         "Placement folder ID: " .
         $af->getPlacementFolderId() . BR;
    
    // Then, manipulate it by changing something inside, using the mutating methods defined in the class AssetFactory.
    
    
    $a = $af->setPlacementFolder( $cascade->getFolder( $targetPath, 'reboot' ));
    if( isset( $a ) ) echo $a->getId() . BR;
    
    
    // Verify that the placement folder was changed.
     echo L::ID . $af->getId() . BR .
         "Placement folder path: " .
         $af->getPlacementFolderPath() . BR .
         "Placement folder ID: " .
         $af->getPlacementFolderId();
    
}
catch( Exception $e )
{
    echo S_PRE . $e . E_PRE;
}

?>