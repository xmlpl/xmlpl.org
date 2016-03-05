import xmlpl.xml;
import xmlpl.curl;

:: Forward Declaration
node[] evaluate(element e);

node[] doChildren(element e) {
  foreach (e/node())
    if (Element(.)) evaluate(Element(.));
    else .; :: If it's not an element just copy it.
}

node[] doContents(element e) {
}

node[] doSection(element e) {
}

node[] evaluate(element e) {
  switch (name(e)) {
  :: Process contents starting from the parent element
  case "contents": doContents(e/..); break;
  case "section": doSection(e); break;

  default:
    :: Copy the element
    <(name(e))>
      e/@*; :: Copy attributes

      doChildren(e);
    </>
  }
}

node[] main(document in) {
  <html>
    <head>
      <title>value(in/webdoc/@title);</title>
    </head>
    <body>
      <h1>value(in/webdoc/@title);</h1>

      foreach (in/webdoc/*)
        evaluate(.);

    </body>
  </head>
}
