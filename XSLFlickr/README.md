**flickr1-noauth.xsl** is a version of XSL Flickr that excludes all services requiring authentication. So far, the library supports the following Flickr API methods:
* [photos.getInfo](https://www.flickr.com/services/api/flickr.photos.getInfo.html)
* [photos.getSizes](https://www.flickr.com/services/api/explore/flickr.photos.getSizes)
* [photosets.getPhotos](https://www.flickr.com/services/api/flickr.galleries.getPhotos.html)

Just like with XSL Flickr, declare a prefix for the library namespace, import the library, define a global parameter for your API key and you're ready to use it.

#### Background ####
1. After seeing Matt Carter's "Blogging and Photo Gallery" presentation, I began using Norman Walsh's XSL library (specifically flickr1.xsl) to leverage Flickr's API in Cascade Server.
2. In June 2014, flickr1.xsl stopped working because [this namespace](http://nwalsh.com/xslt/ext/com.nwalsh.xslt.Digest) went offline.
3. To get around this, I've started rewriting the XSLT templates, without the code that relates to the namespace.

#### Related Links ####
[Flickr API Documentation](https://www.flickr.com/services/api/)

[Matt Carter's 2011 presentation](http://mdcarter.people.unm.edu/csuc11/presentations/csuc11/index.html)

[XSL Flickr library by Norman Walsh](http://norman.walsh.name/2005/projects/xslflickr)

#### Requirements ####
* XSLT 1.0