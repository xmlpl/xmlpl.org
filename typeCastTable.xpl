import xmlpl.xml;
import xmlpl.string;

node[] main(document in) {
  element table = in/type_casts;

  <table border="1">
    <tr>
      <th/>
      foreach (table/col)
        <th>value(@type);</th>
    </tr>

    foreach (table/row) <tr>
      <th>value(@type);</th>

      foreach (./c) <td>
        string x = concat(./text());

        switch (x) {
        case "FALSE": Attribute("class", "false"); x = "false"; break;
        case "--------": break;
        case "TRUE": x = "true";
        default: Attribute("class", "true"); break;
        }

        x;
      </td>

      <th>value(@type);</th>
    </tr>

    <tr>
      <th/>
      foreach (table/col)
        <th>value(@type);</th>
    </tr>
  </table>
}
