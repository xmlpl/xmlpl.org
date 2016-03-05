import xmlpl.xml;
import xmlpl.string;

element[] get_amounts(element[] e) {  
  prefix ns = Prefix("", "http://recipes.org");

  decendant_or_self(e, QName(ns, "ingredient"))[@name == "flour"];
}

string[] main(document in) {
  real amount = 0;
  
  foreach (get_amounts(in/*))
    amount += ator(value(@amount));

  amount + "\n";
}
