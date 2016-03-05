import xmlpl.xml;


:: Forward Declaration
node[] dispatch(element e);


node[] doHello() {
  "Hello World!";
}

node[] doTableOfContents(element e) {
  <ol>
    foreach (e/../section) <li>
      <a href=("#" + (string)@name)>@name;</a>
    </li>
  </ol>
}

node[] doDoc(element e) {
  <html>
    <head/>
    <body>
      foreach (e/*) dispatch(.);
    </body>
  </html>
}

node[] dispatch(element e) {
  switch (name(e)) {
  case "hello": doHello(); break;
  case "table-of-contents": doTableOfContents(e); break;
  case "doc": doDoc(e); break;

  default:
    <(name(e))>
      e/@*;

      foreach (e/node()) {
        if (Element(.)) dispatch(Element(.));
        else .;
      }
    </>
  }
}

node[] main(document in, string[] args) {
  dispatch(in/*);
}
