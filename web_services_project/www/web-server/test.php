<h1>Reading a Text Block</h1>
<?php
requre_once('/www/PHP/classes/cascade_ws/auth_espanae.php');

/* change this path pointing to a valid text block */
$path      = "/espanae/2013/web_services/gravity";
/* change this to the site containing the text block */
$site_name = "development"; 

try
{
    $service->read( $service->createIdWithPathSiteNameType( 
        $path, $site_name, T::BLOCK ) );

    if( $service->isSuccessful() )
    {
        echo "Read successfully<br />";
        var_dump( $service->getReadAsset()->textBlock->text );
    }
    else
    {
        echo "Failed to read. " . $service->getMessage();
    }
}
catch( Exception $e )
{
    echo $e;
}
?>