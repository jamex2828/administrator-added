import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BorrowedItemsPage(),
    );
  }
}

//Creating a class user to store the data;
class Borrow {
  final String propertyNum;
  final String description;

  Borrow({
    required this.propertyNum,
    required this.description,
  });
}

class BorrowedItemsPage extends StatefulWidget {
  @override
  _BorrowedItemsPageState createState() => _BorrowedItemsPageState();
}

class _BorrowedItemsPageState extends State<BorrowedItemsPage> {
//Applying get request.

  Future<List<Borrow>> getRequest() async {
    //replace your restFull API here.
    String url =
        "http://10.10.10.15:1337/api/items"; // "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Borrow> borrowed = [];
    for (var singleUser in responseData) {
      Borrow borrow = Borrow(
        propertyNum: singleUser["property_no"],
        description: singleUser["description"],
      );

      //Adding user to the list.
      borrowed.add(borrow);
    }
    return borrowed;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Http Get Request."),
          leading: Icon(
            Icons.get_app,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: getRequest(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) => ListTile(
                    title: Text(snapshot.data[index].propertyNum), //.title
                    subtitle: Text(snapshot.data[index].description), //.body
                    contentPadding: EdgeInsets.only(bottom: 20.0),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}