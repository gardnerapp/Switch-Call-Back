import 'package:flutter/material.dart';
import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Add> selectedItems;

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            selectedItems == null ? new Text("hog") : new ListView.builder(
              shrinkWrap: true,
                itemCount: selectedItems.length,
                itemBuilder: (BuildContext cntx, int index) {
                    return new Text(selectedItems[index].name);
                }),
            MySwitchList(myList,
                parentListUpdate: (List<Add> childList) =>
                    setState(() => selectedItems = childList))
          ],
        ),
    ),
      );
  }
}

class MySwitchList extends StatefulWidget {
  final AddList sides;
  Function(List<Add>) parentListUpdate;
  MySwitchList(this.sides, {this.parentListUpdate});

  @override
  _MySwitchListState createState() => _MySwitchListState();
}

class _MySwitchListState extends State<MySwitchList> {
  List<Add> callbackList = [];

  @override
  Widget build(BuildContext context) {
    List<Switch> myList = List.generate(this.widget.sides.items.length,
            (index) => Switch(this.widget.sides.items[index],
              addSelected: (Add item, bool val ){
              switch(val){
                case true:
                  callbackList.add(item);
                  this.widget.parentListUpdate(this.callbackList);
                  break;
                case false:
                  callbackList.remove(item);
                  this.widget.parentListUpdate(this.callbackList);
                  break;
              }
              print(callbackList); //Do not Need to Use Set State because addition of item is not effecting the build of this widget
              },
        ));
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                this.widget.sides.msg,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              Wrap(children: myList)
            ]));
  }

}

class Switch extends StatefulWidget {
  final Add item;
  final Function(Add , bool) addSelected;
  Switch(this.item, {this.addSelected});

  @override
  _SwitchState createState() => _SwitchState();
}

class _SwitchState extends State<Switch> {
  bool _value = false;
  Add newItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
          color: Colors.white70,
          child: SwitchListTile(
            value: _value,
            onChanged: (bool newValue) {
              setState(() {
                _value = newValue;
              });
                newItem = this.widget.item;
              this.widget.addSelected(newItem, newValue);
            },
            title: Text(this.widget.item.name),
            activeColor: Colors.deepOrangeAccent,
            inactiveThumbColor: Colors.white,
            secondary: Icon(
              Icons.fastfood,
              color: Colors.amber,
            ),
          ),
        ));
  }
}

/*
  addSelected(CheckOutItem item, bool value){
    switch (value){
      case false:
        BlocProvider.of<FoodBloc>(context).add(FoodEvent.delete(item));
        BlocProvider.of<PriceCubit>(context).remove(item.price);
        break;
      case true:
        BlocProvider.of<FoodBloc>(context).add(FoodEvent.add(item));
        BlocProvider.of<PriceCubit>(context).add(item.price);
        break;

    }
  }*/

