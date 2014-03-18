# WuFoo Forms #

#### Summary ####
 Generates an inventory of Wufoo forms listed in chronological order, along with notification information.
 The report shows each form's:
* Title
* Creation date
* Email addresses set to receive form notifications

#### Requirements ####
* Cascade Server 6.10+ with Velocity 1.7
* A [Wufoo.com](http://wufoo.com) account

#### Setup ####
* Visit [https://{subdomain}.wufoo.com/api/v3/forms.xml](http://help.wufoo.com/articles/en_US/SurveyMonkeyArticleType/The-Forms-API) (replace {subdomain} with your Wufoo account subdomain).
* Copy and paste the source code into a new XML block in Cascade Server.
* Attach the XML block to a template region.
* Attach forms.vm or forms-count.vm to the same region as the XML block.

#### forms.vm ####
	
* Generates a 3-column HTML table listing each form's title, creation date and notification email addresses.

#### forms-count.vm ####

* Returns the total number of forms associated with your Wufoo account.