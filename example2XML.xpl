import xmlpl.xml;

node[] doExample2XML(element example) {
  <body ("xmlns:ws")="http://www.xmlpl.org/website">
    <h2>"XmlPL By Example: ";<("ws:title")/></h2>

    example/intro;

    <h2>"Steps";</h2>
    <ol>
      foreach (example/step) <li>
        <a href=("#" + value(@name))>value(@title);</a>
      </li>
    </ol>

    integer i = 1;
    foreach (example/step) {
      <a name=(@name)><h2>i + ". "; value(@title);</h2></a>
      i++;
      <div class="step">
        ./node();
      </div>
    }
  </body>
}

node[] main(document in) {
  doExample2XML(in/example);
}
