import xmlpl.xml;

node[] doLink(element link) {
  <li>
    <a href=(link/@href)>value(link/@title);</a>
    if (link/node()) {
      " - "; link/node();
    }
  </li>
}

node[] doSection(element section) {
  <h1>value(section/@name);</h1>
  <ul>
    foreach (section/link) doLink(.);
  </ul>
}

node[] main(document in) {
  <body>
    foreach (in/links/section)
      doSection(.);
  </body>
}
