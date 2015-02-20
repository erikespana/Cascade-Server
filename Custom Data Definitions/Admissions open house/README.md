## Troubleshooting Tips

**Q: Why isn't my open house appearing on the /admissions/visit/open-houses/index page?**
- Make sure the page is being indexed
- and the page hasn't expired.
  - To check, edit the asset and click the **Metadata** pane. Is there an **End Date** configured for them?

### Algorithm

1. Index pages in /admissions/visit/open-houses/schedule, by ascending folder order.
2. XPath: //system-page[dynamic-metadata[name='public']/value = 'Yes'][system-data-structure/event-date > /system-index-block/@current-time]
3. Sort by system-data-structure/event-date values, in ascending order.
For each page:
  <li>Date (Apr. 24, 2015)
      <br/>
      <strong>Title (with optional link)</strong>
  </li>

### Uses the following Velocity tools

_XPathTool
_SortTool
_DateTool Uses this technique to get around the data definition date quirk.
_${_EscapeTool.xml($xml) to safely escape any special characters.
