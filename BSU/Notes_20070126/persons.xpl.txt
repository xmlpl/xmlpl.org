node[] main(document in) {
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>"xsl wiki ex.";</title> </head>
    <body>
      <h1>"Persons";</h1>
      <ul>
        foreach (in/persons/person) <li>
          ./family_name/text(); ", "; ./name/text();
        </li>
      </ul>
    </body>
  </html>
}
