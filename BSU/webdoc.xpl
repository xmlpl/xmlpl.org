import xmlpl.xml;
import xmlpl.string;
import xmlpl.curl;

node[] eval(element e);
node[] eval(element e, integer &section);

integer sectionDepth = 1;

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

  <a name=(url_escape(section/@name))>
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
    <a href=("#" + url_escape(section/@name))>value(section/@name);</a>

    if (section/section) <ol>
      foreach (section/section)
        doSectionContents(.);
    </ol>
  </li>
}

node[] doContents(element e) {
  <h2>"Contents";</h2>
  <ol class="contents">
    foreach (e/../section)
      doSectionContents(.);
  </ol>
}

node[] doCode(element e) {
  <div class="code">
    <pre>e/node();</pre>
  </div>
}

node[] doInlineCode(element e) {
  <span class="inline">e/node();</span>
}

node[] doDefault(element e) {
	integer section = 1;

  <(name(e))>
    e/@*;

    foreach (e/node()) {
      if (Element(.)) eval(Element(.), section);
      else .;
    }
  </>
}

node[] eval(element e, integer &section) {
  switch (name(e)) {
  case "section": doSection(e, section++); break;
  case "code": doCode(e); break;
  case "inline": doInlineCode(e); break;
  case "contents": doContents(e); break;
  default: doDefault(e);
  }
}

node[] eval(element e) {
	integer section = 1;
  eval(e, section);
}

node[] main(document in) {
	integer section = 1;

	foreach (in/*) eval(., section);
}
