Data Definition fields:
* Title
* Photo
* Caption - may contain &#8217 characters.
* Span - unclear where the text is populated from. 
* Notes
Development Notes
* Using image filename for alt tag (e.g. cat.jpg). Cascade doesn't seem capable of including the image file's metadata from the structured data block. Tried setting the Render Content Depth = 3, in the data definition, but it had no effect.