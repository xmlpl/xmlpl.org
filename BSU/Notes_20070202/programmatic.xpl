node[] main() {
  <root>
    integer i;
    string[] attrs = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j";

    for (i = 0; i < 10; i++)
      <("e" + i) (attrs[i])=(10 - i)>
        "Element " + i + "\n";
        <!-- Comment for element (i) -->
        <?processing instruction for element (i) ?>
      </>
  </root>
}
