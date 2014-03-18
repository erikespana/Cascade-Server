# Cascade Server Publish Sets #

 I'm using [cron expressions](http://www.quartz-scheduler.org/documentation/quartz-1.x/tutorials/crontrigger) to automate the publishing of pages from Cascade Server. Here's a list of the schedules with their cron expressions translated in English.


#### Admissions ####

During the academic year: published every 15 minutes starting at 1 minute past the hour (0 1/15 * ? * SUN-SAT).
During the summer: published at 10:01 every weekday (0 1 10 ? * MON-FRI).
* [/admissions/index.php](http://www.union.edu/admissions/)
* [/admissions/blogs/index.php](http://www.union.edu/admissions/blogs/)
* [/admissions/applicant_portal/sidebars/login.php]

Published daily at 5 pm (no cron expression required):

* [Admissions Open-Houses](http://www.union.edu/admissions/visit/open-houses/)

Published daily at 3 am (no cron expression required):

* [Admissions in Your Area](http://www.union.edu/admissions/in-your-area/)


#### News ####

Published on the 1st of each month at 5:30 pm (0 30 17 1 * ?):

* [/news/stories/index.php](http://www.union.edu/news/stories/)

Published weekdays at 5:30 pm (0 30 17 ? * MON-FRI):

* [news/in-the-media.php](http://www.union.edu/news/in-the-media.php)
* [news/announcements.php](http://www.union.edu/news/announcements.php)

Published every hour, between 9:30 am & 5:30 pm, on weekdays (0 30 9-17 ? * MON-FRI):

* [Alumni news](http://www.union.edu/news/alumni.php)
* [Faculty/Staff news](http://www.union.edu/news/faculty-staff.php)
* [Student news](http://www.union.edu/news/students.php)
* The current month's news archive (e.g. /news/stories/2013/04/index.php)


#### Audience Gateways ####

Published at the top of each hour, between 9 am & 6 pm, on weekdays (0 0 9-18 ? * MON-FRI):

* [Alumni gateway](http://www.union.edu/alumni/)
* [Alumni events](http://www.union.edu/alumni/events/index.php)
* [Becker special events](http://www.union.edu/offices/career/students/events/)
* [Employment Opportunities](http://www.union.edu/offices/human-resources/jobs/)


#### Social Media Caches ####

Published every 10 minutes starting at 9 minutes past the hour, seven days a week.  (0 0 9-18 ? * 1-7):

* [/feeds/chatter/admissions-blogs.xml](http://www.union.edu/feeds/chatter/admissions-blogs.xml)