import xmlpl.xml;
import xmlpl.curl;

:: Forward Declaration
node[] evaluate(element e, integer depth, integer &index, string label);

node[] doChildren(element e, integer depth, integer &index, string label) {
  foreach (e/node())
    if (Element(.)) evaluate(Element(.), depth, index, label);
    else .; :: If it's not an element just copy it.
}

node[] doContents(element e) {
  <ol>
    foreach (e/section) <li>
      <a href=("#" + url_escape(@title))>
        value(@title);
      </a>

      if (./section) doContents(.);
    </li>
  </ol>
}

node[] doSection(element e, integer depth, integer &index, string label) {
  integer subindex = 1;
  string newlabel = label + index + ".";

  <a name=(url_escape(e/@title))>
    <("h" + (depth + 1))>
      newlabel;
      " ";
      value(e/@title);
    </>
  </a>

  doChildren(e, depth + 1, subindex, newlabel);

  index++;
}

node[] evaluate(element e, integer depth, integer &index, string label) {
  switch (name(e)) {
  :: Process contents starting from the parent element
  case "contents": doContents(e/..); break;
  case "section": doSection(e, depth, index, label); break;

  default:
    :: Copy the element
    <(name(e))>
      e/@*; :: Copy attributes

      doChildren(e, depth, index, label);
    </>
  }
}

node[] main(document in) {
  integer index = 1;

  <html>
    <head>
      <link rel="stylesheet" href="style.css" type="text/css"/>
      <title>value(in/webdoc/@title);</title>
    </head>
    <body>
      <h1>value(in/webdoc/@title);</h1>

      foreach (in/webdoc/*)
        evaluate(., 1, index, "");

    </body>
  </head>
}
