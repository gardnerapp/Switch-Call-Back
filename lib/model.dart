class Add{
  final String name;
  Add(this.name);
}

class AddList{
  final String msg;
  final List<Add> items;
  AddList(this.items, this.msg);
}

AddList myList = AddList([Add("Hello"), Add("Not Hello"), Add("Have a Good Day")], "Hopefully this works ");