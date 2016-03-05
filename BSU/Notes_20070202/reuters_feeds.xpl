import xmlpl.stdio;
import xmlpl.curl;
import xmlpl.xml;
import xmlpl.stdlib;
import xmlpl.string;

string url = "http://feeds.reuters.com/reuters/";

string[] feeds =
	"globalCoverage2",
	"topNews",
	"smallBusinessNews",
	"domesticNews",
	"worldNews",
	"politicsNews",
	"entertainment",
	"technologyNews",
	"scienceNews",
	"internetNews",
	"sportsNews",
	"healthNews",
	"oddlyEnoughNews",
	"inDepthNews",
	"environment";

string getQValue(string[] query, string name) {
  integer i;
  for (i = 0; i + 1 < size(query); i += 2)
    if (name == query[i]) return url_unescape(query[i + 1]);

  return "";
}

node[] doFrames() {
  <html>
    <frameset rows="30%, 70%">
      <frame src="?feed=scienceNews"/>
      <frame name="frame" src="about:blank"/>
    </frameset>
  </html>
}

node[] doFeed(string feed) {
  element rss = open("http://feeds.reuters.com/reuters/" + feed)/rss;

  <http>
    <head>
      rss/channel/title;
    </head>
    <body>
      <form method="get">
        <strong>"Select Feed: ";</strong>

        <select name="feed">
          foreach (feeds)
            <option value=(.)>
              if (. == feed) Attribute("selected", "true");
              .;
            </option>
        </select>

        <input class="button" value="Go" type="submit"/>

        <strong>rss/channel/title/text();</strong>
      </form>

      <ol>
        foreach (rss/channel/item) <li>
          ./pubDate/text(); ": ";
          <a target="frame" href=(./link/text())>./title/text();</a>
        </li>
      </ol>
    </body>
  </http>
}

node[] main() {
  string[] query = tokenize(getenv("QUERY_STRING"), "&=");
	string feed = getQValue(query, "feed");

	:: Output CGI string
  "Content-type: text/html\n\n";

	if (feed != "") doFeed(feed);
	else doFrames();
}
