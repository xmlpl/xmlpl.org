node[] doSteps2XML(element steps) {
  <body xmlns:ws="http://www.xmlpl.org/website">
    <h2>"XmlPL By Example: ";<ws:title/></h2>

    foreach (steps/step) {
    }
  </body>
}

node[] main(document in) {
  doSteps2XML(in/steps);
}
