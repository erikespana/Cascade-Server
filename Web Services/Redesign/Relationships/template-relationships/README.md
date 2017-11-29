**template-relationships.php**

Displays all the assets related to a given template.
How to use:
- Select a template in Cascade
- Copy the **?id=######&type=template** from the browser's address bar
- Paste it after the script's filename
- Optional: Specify `&auth=prod` or `&auth=dev` in the URL parameter.
  - ie: `template-relationships.php?id=556cef9f0a2295fe03fd8ab6b9df794f&type=template`

** Status **
 After encountering:
- [pageconfigurationset] site://TDI/Bulletins Yearly Listing
  - site://TDI/Bulletin Yearly [contenttype]
Script throws **cascade_ws_exception\EmptyValueException: The input value cannot be empty.** exception.

```
cascade_ws_exception\EmptyValueException: The input value cannot be empty.  in N:\PublicAffairs\web\webservices\cascade_ws_ns7\property_classes\PossibleValue.class.php:123
Stack trace:
#0 N:\PublicAffairs\web\webservices\cascade_ws_ns7\property_classes\DynamicMetadataFieldDefinition.class.php(737): cascade_ws_property\PossibleValue->__construct(Object(stdClass))
#1 N:\PublicAffairs\web\webservices\cascade_ws_ns7\property_classes\DynamicMetadataFieldDefinition.class.php(96): cascade_ws_property\DynamicMetadataFieldDefinition->processPossibleValues(Array)
#2 N:\PublicAffairs\web\webservices\cascade_ws_ns7\asset_classes\MetadataSet.class.php(1945): cascade_ws_property\DynamicMetadataFieldDefinition->__construct(Object(stdClass))
#3 N:\PublicAffairs\web\webservices\cascade_ws_ns7\asset_classes\MetadataSet.class.php(291): cascade_ws_asset\MetadataSet->processDynamicMetadataFieldDefinition()
#4 N:\PublicAffairs\web\webservices\cascade_ws_ns7\asset_classes\ContentType.class.php(190): cascade_ws_asset\MetadataSet->__construct(Object(cascade_ws_AOHS\AssetOperationHandlerService), Object(stdClass))
#5 N:\PublicAffairs\web\webservices\cascade_ws_ns7\asset_classes\Asset.class.php(682): cascade_ws_asset\ContentType->__construct(Object(cascade_ws_AOHS\AssetOperationHandlerService), Object(stdClass))
#6 N:\PublicAffairs\web\webservices\cascade_ws_ns7\property_classes\Child.class.php(120): cascade_ws_asset\Asset::getAsset(Object(cascade_ws_AOHS\AssetOperationHandlerService), 'contenttype', '556ce2930a2295f...')
#7 C:\MAMP\htdocs\redesign2017\relationships\template-relationships.php(56): cascade_ws_property\Child->getAsset(Object(cascade_ws_AOHS\AssetOperationHandlerService))
#8 C:\MAMP\htdocs\redesign2017\relationships\template-relationships.php(90): getCTRelationships(Object(cascade_ws_property\Identifier), Object(cascade_ws_AOHS\AssetOperationHandlerService))
#9 C:\MAMP\htdocs\redesign2017\relationships\template-relationships.php(113): getConfSetRels(Object(cascade_ws_property\Identifier), Object(cascade_ws_AOHS\AssetOperationHandlerService))
#10 C:\MAMP\htdocs\redesign2017\relationships\template-relationships.php(140): getTemplateRelationships(Object(cascade_ws_asset\Template), Object(cascade_ws_AOHS\AssetOperationHandlerService))
#11 {main}
```
