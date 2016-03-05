import xmlpl.xml;

boolean is_distinct(string[] &distinct_set, string s) {
  foreach (distinct_set)
    if (. == s) return false;

  distinct_set ,= s;

  return true;
}

node[] main(document in) {
  <html><head/><body>
    foreach (decendant_or_self(in/*, QName("ACT"))) <span>
      element act = .;
      <h1>act/TITLE/text();</h1>
      <ul>
        string[] distinct_set;

        foreach (decendant_or_self(act, QName("SPEAKER")))
          if (is_distinct(distinct_set, ./text()))
            <li>./text();</li>
      </ul>
    </span>
  </body></html>
}
