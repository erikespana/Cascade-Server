# Majors #

Use the Content Module to list information about Union's majors, minors and programs.

#### Summary ####
* 1. Majors, Minors and Programs links
* 2. List all 44 majors
* 3. For each major, display the Content Introduction, Content Copy, Contact Info and Outcome data.

#### Requirements ####
* Cascade Server 6.10+ with Velocity 1.7
* Kurogo 1.3

#### Setup ####
* Create a Content Type Index Block that indexes the content of each major.
* Attach the block/format to a page region that generates the feeds-major.ini file.
* Attach forms.vm or forms-count.vm to the same region as the XML block.

#### majors.vm ####
	
* Generates a feeds.ini file for a grouped list of all majors.

https://modolabs.jira.com/wiki/display/KDOC/Content+Module