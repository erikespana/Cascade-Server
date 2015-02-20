List upcoming open houses.

Display date (e.g. "DEC 25"), the title (with optional link). The title displayed must be short (e.g. < 30 characters) The other events will be managed in Cascade Server by admissions staff. Events will be categorized as: Application deadlines Event Closing Open house
Uses the following Velocity tools:

_XPathTool
_SortTool
_DateTool Uses this technique to get around the data definition date quirk.
_${_EscapeTool.xml($xml) to safely escape any special characters.


**Q: Why isn't my open house appearing on the /admissions/visit/open-houses/index page?**
- Make sure the page is being indexed.
- The page hasn't expired. To check, edit the asset and click the **Metadata** pane. Is there an **End Date** configured for them?
