import xmlpl.xml;
import xmlpl.string;

string[] main(document in) {
  prefix ns = Prefix("", "http://recipes.org");
	real amount = 0;

  foreach (decendant_or_self(in/*, QName(ns, "ingredient"))[@name == "flour"])
    amount += ator(value(@amount));

	amount + "\n";
}
