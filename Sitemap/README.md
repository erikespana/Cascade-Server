
Creates an [XML sitemap](http://www.union.edu/feeds/sitemaps/reboot.xml), using the [sitemaps.org](http://www.sitemaps.org/protocol.html) protocol (same protocol used by Google, Yahoo, and Bing).

I wrote this because Hannon Hill's [XSLT script](https://github.com/hannonhill/XSLT-Workbook/tree/master/Site-Map) doesn't work on Cascade Server sites employing a folder/page asset pair to represent a single webpage.

**Google Sitemap 2.vm**

* Hard-coded to ignore any URL that starts with /news because Google recommends submitting a separate sitemap for News articles.

* Only lists published pages and uses the last published date for the <lastmod> field.

* Flags pages not in folder/index form.

* Currently does not support priority node.

### Concerns ###
You'll have to experiment with how many levels deep to index. You don't want to use too many resources.

### Instructions ###
* Create an Index Block for the Cascade Site to be indexed.
* Create a template called "XML" using **template.xml**.
* Create an "XML" Configuration Set.
* Create an "XML" Content Type.
* Create a page asset using the "XML" Content Type.
    * Assign the Structured Data Block to the default block.
    * Assign **feed-block-aggregator.vm** as the default region.