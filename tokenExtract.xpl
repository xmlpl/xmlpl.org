import xmlpl.xml;

string[] dumpTokens(element e) {
  if (name(e) == "grammar") (string)e/@name + "\n";
  else foreach (e/*) dumpTokens(.);
}

string[] main(document in) {
  dumpTokens(in/*);
}
