import 'package:Login/administrator/add_item.dart';
import 'package:Login/administrator/item_list.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(Home(0, 0));
}

class Home extends StatefulWidget {
  int state;
  int id;
  Home(this.state, this.id, {Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState(state, id);
}

class _HomeState extends State<Home> {
  int state;
  int id;
  int _currentIndex = 1;
  Widget? _body;
  String? _title;
  _HomeState(this.state, this.id);
  @override
  void initState() {
    super.initState();
    changeView(state);
  }

  void _onTap(index) {
    changeView(index);
  }

  void changeView(index) {
    _currentIndex = index;
    setState(() {
      switch (index) {
        case 0:
          {
            _title = "Items";
            _body = MyList();
            break;
          }
        case 1:
          {
            _title = "Add Item";
            _body = MyForm();
            break;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text(_title!)),
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.table_chart), label: 'View'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
        ],
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    ));
  }
}
