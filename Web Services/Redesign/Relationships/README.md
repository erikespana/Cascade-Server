**template-relationships.php**

Displays all the assets related to a given template.
How to use:
- Select a template in Cascade
- Copy the **?id=######&type=template** from the browser's address bar
- Paste it after the script's filename
- Optional: Specify `&auth=prod` or `&auth=dev` in the URL parameter.
  - ie: ```template-relationships.php?id=556cef9f0a2295fe03fd8ab6b9df794f&type=template```

**test-asset-factory.php**

Gets an asset factory object and updates its placement folder, using the following classes.

  * http://www.upstate.edu/cascade-admin/projects/web-services/oop/classes/asset-classes/asset-factory.php
  * http://www.upstate.edu/cascade-admin/projects/web-services/oop/classes/cascade.php

Based on Wing Ming Chan's [cascade_ws](http://www.upstate.edu/cascade-admin/projects/web-services/index.php) library and [Asset Factory recipes](http://www.upstate.edu/cascade-admin/projects/web-services/oop/recipes/asset-factory-recipes.php).
