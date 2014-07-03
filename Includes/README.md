**Description**
An XSLT format that generates the HTML for the Head section CSS and javascript include tags that appear in the Head section of each page.

Goals
* Ensure certain CSS and javascript code (e.g. Google Analytics) are added to each page.
* Manage all CSS and javascript code in one place.
* Flexibility to add or remove certain components from individual pages via the data definition.

* Default includes
	* jQuery 1.6.4
	* /_css/styles.css
	* /_css/print.css
	* Google Analytics
	* Site Improve

* Conditional includes
	* Homepage and News homepage
		* site://reboot/_css/homepage-1.4/homepage.css
		* Typekit
		* flexslider
	* Based on data definition fields
		* Fancybox
		* [jQuery SuperSleight](http://allinthehead.com/retro/338/supersleight-jquery-plugin)
		* [jQuery UI 1.8.2](http://jqueryui.com)
		* [jQuery Cycle Plugin](http://jquery.malsup.com/cycle/)
		* [PrettyPhoto]
		* Google Maps API
		* Google Maps Banner javascript
		* [Flickr Side Widget](http://www.newmediacampaigns.com/page/jquery-flickr-plugin)
		* jQuery Tweet

Disadvantages
* Having this as the only mechanism for including CSS and javascript doesn't provide other users the flexibility to add special case CSS or javascript.