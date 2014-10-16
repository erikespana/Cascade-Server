Requirements

  * List 3 upcoming events.
  * For each event, display date (e.g. "DEC 25"), the title (with optional link).
The title displayed must be short (e.g. < 30 characters)
The other events will be managed in Cascade Server by admissions staff.
Events will be categorized as:
Application deadlines
Event
Closing
Open house

Uses the following Velocity tools:
* [_XPathTool](http://www.hannonhill.com/kb/Script-Formats/#xpath-tool)
* [_SortTool](http://www.hannonhill.com/kb/Script-Formats/#sort-tool)
* [_DateTool](http://www.hannonhill.com/kb/Script-Formats/#date-tool)
Uses [this technique](http://help.hannonhill.com/discussions/how-do-i/387-start-date-value-in-index-block-vs-data-definition-page-chooser) to get around the data definition date quirk.
* [_${_EscapeTool.xml($xml)](http://www.hannonhill.com/kb/Script-Formats/#escape-tool) to safely escape any special characters.

