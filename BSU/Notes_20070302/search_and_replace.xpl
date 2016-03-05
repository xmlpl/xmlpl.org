import xmlpl.xml;

node[] search_and_replace(element e, string search, string replace) {
	qname ename = name(e);

	if (ename == QName(search)) ename = replace;

	<(ename)>
    e/@*;

    foreach (e/node()) {
      if (Element(.)) search_and_replace(Element(.), search, replace);
      else .;
    }
  </>
}

node[] main(document in, string[] args) {
  search_and_replace(in/*, args[1], args[2]);
}
