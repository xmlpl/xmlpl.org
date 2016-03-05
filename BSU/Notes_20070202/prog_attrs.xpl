import xmlpl.xml;

node[] main() {
  integer i;
  integer j;
  string[] attrs = "first", "last", "address", "city";
  string[] data =
    "Clark", "Kent", "344 Clinton St., Apt. 3B", "Metropolis",
    "Sherlock", "Holmes", "221B Baker Street", "London",
    "Homer", "Simpsons", "742 Evergreen Terrace", "Springfield";

  <address_book>
    for (i = 0; i < size(data); i += 4)
      <entry>
        for (j = 0; j < 4; j++)
          Attribute(attrs[j], data[i + j]);
      </entry>
  </address_book>
}
