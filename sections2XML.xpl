import xmlpl.xml;
import xmlpl.string;

node[] eval(element e);
node[] eval(element[] e);



integer grammarDepth = 1;

node[] tabs() {
  integer i;
  for (i = 0; i < grammarDepth; i++)
    "\u00A0\u00A0";
}

node[] doGrammarPart(element e);

node[] doToken(element e) {
  string x = e/text();

  <a class="token" href=("#grm:" + downcase(x))>
    upcase(left(x, 1)) + left(x, -1);
  </a>
}

node[] doSymbol(element e) {
  "'"; e/text(); "'";
}

node[] doKeyword(element e) {
  <span class="keyword">e/text();</span>
}

node[] doOr(element e) {
  boolean first = true;

  foreach (e/*) {
    if (first) {
      first = false;
      "(";
      if (e/@break == "true") " ";

    } else {
      if (e/@break == "true") {<br/> tabs();}
      else " ";
      "| ";
    }


    grammarDepth++;
    doGrammarPart(.);
    grammarDepth --;
  }

  if (e/@break == "true") {<br/> tabs();}
  ")";
}

node[] doCat(element e) {
  boolean first = true;

  if (size(e/*) > 1) {
    if (grammarDepth > 1) "(";
    grammarDepth++;
  }

  foreach (e/*) {
    if (first) first = false;
    else " ";

    doGrammarPart(.);
  }

  if (size(e/*) > 1) {
    grammarDepth --;
    if (grammarDepth > 1) ")";
  }
}

node[] doStar(element e) {
  doCat(e);
  "*";
}

node[] doPlus(element e) {
  doCat(e);
  "+";
}

node[] doOption(element e) {
  doCat(e);
  "?";
}

node[] doCharSet(element e) {
  "["; e/text(); "]";
}

node[] doGrammar(element grammar) {
  <div class="grammar">
    <a name=("grm:" + downcase(grammar/@name))> </a>
    <b>value(grammar/@name);</b> " ::= ";
    if (grammar/@break == "true") {<br/> tabs();}

    doCat(grammar);
  </div>
}

node[] doGrammarPart(element e, boolean &match) {
  match = true;

  switch (name(e)) {
    case "grammar": doGrammar(e); break;
    case "or": doOr(e); break;
    case "cat": doCat(e); break;
    case "t": doToken(e); break;
    case "k": doKeyword(e); break;
    case "s": doSymbol(e); break;
    case "minus": "-"; break;
    case "dot": "."; break;
    case "c": doCharSet(e); break;
    case "star": doStar(e); break;
    case "plus": doPlus(e); break;
    case "option": doOption(e); break;
    case "br": <br/> break;
    default: match = false;
  }
}

node[] doGrammarPart(element e) {
  boolean match;
  doGrammarPart(e, match);
}



integer sectionDepth = 0;

node[] doSection(element section, string idx);

node[] doSubsections(element section, string idx) {
  if (idx != "") idx = idx + ".";
  integer count = 1;

  foreach(section/*) switch(name(.)) {
    case "section": {
      doSection(., idx + (string)count++);
      break;
    }

    default: eval(.);
  }
}

node[] doSection(element section, string idx) {
  if (section/@disabled == "true") return;

  sectionDepth++;

  string header = "h" + sectionDepth;

  <a name=(section/@name)>
    <(header)>
      idx;
      if (idx != "") ") ";
      value(section/@name);
    </>
  </a>

  doSubsections(section, idx);

  sectionDepth --;
}

node[] doSection(element section) {
  doSection(section, 1);
}

node[] doSectionContents(element section) {
  if (section/@disabled == "true") return;

  <li>
    <a href=("#" + value(section/@name))>value(section/@name);</a>

    if (section/section) <ol>
      foreach (section/section)
        doSectionContents(.);
    </ol>
  </li>
}

node[] doInlineCode(element e) {
  <span class="inline">e/node();</span>
}

node[] doDefault(element e) {
  <(name(e))>
    e/@*;

    foreach (e/node()) {
      if (Element(.)) eval(Element(.));
      else .;
    }
  </>
}

node[] eval(element e) {
  switch (name(e)) {
  case "section": doSection(e); break;
  case "inline": doInlineCode(e); break;
  default: {
    boolean match;
    doGrammarPart(e, match);
    if (!match) doDefault(e);
  }
  }
}

node[] eval(element[] e) {
  foreach (e) eval(.);
}

node[] main(document in) {
  <body>
    <h1>value(in/section/@name);</h1>

    <h1>"Contents";</h1>
    <ol>
      foreach (in/section/section)
        doSectionContents(.);
    </ol>

    doSubsections(in/*, "");
  </body>
}
