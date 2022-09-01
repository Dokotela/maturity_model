class Domain {
  Domain();
  List<Group> groups = [];
}

class Group {
  Group();

  List<Item> items = [];
}

class SubGroup extends Item {
  SubGroup(String text) : super(text);

  List<Question> questions = [];
}

class Question extends Item {
  Question(
    String text,
    this.level1,
    this.level2,
    this.level3,
    this.level4,
    this.level5,
  ) : super(text);

  String level1;
  String level2;
  String level3;
  String level4;
  String level5;
}

abstract class Item {
  Item(this.text);

  String text;
}
