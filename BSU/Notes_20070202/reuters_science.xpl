import xmlpl.stdio;

node[] main() {
  element rss = open("http://feeds.reuters.com/reuters/scienceNews/")/rss;

  <http>
    <head>
      rss/channel/title;
    </head>
    <body>
      <h1>rss/channel/title/text();</h1>

      element image = rss/channel/image;

      if (image)
        <a href=(image/link/text())><img src=(image/url/text())/></a>

      <ol>
        foreach (rss/channel/item) <li>
          ./pubDate/text(); ": ";
          <a href=(./link/text())>./title/text();</a>
        </li>
      </ol>
    </body>
  </http>
}
