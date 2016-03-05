import xmlpl.stdio;

node[] main() {
  string url = "http://rss.slashdot.org/Slashdot/slashdotDevelopers"; element firstItem = open(url)/RDF/item[0];

  firstItem/title/text();
  "\n";
  firstItem/description/node();
}
