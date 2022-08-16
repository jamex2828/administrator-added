import 'package:Login/administrator/add_item.dart';
import 'package:Login/administrator/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:Login/administrator/data_class.dart';
import 'dart:async';

class MyList extends StatefulWidget {
  MyList({Key? key}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());

  late int id;
  // Future getItems() //not working
    Future<void> getItems() async {
    resultNotifier.value = RequestLoadInProgress();
    Response response = await http.get(
      Uri.parse('http://192.168.1.8:1337/api/items'),
    );
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Items: ${response.body}');
    _handleResponse(response);
  }

  void _handleResponse(Response response) {
    if (response.statusCode >= 400) {
      resultNotifier.value = RequestLoadFailure();
    } else {
      resultNotifier.value = RequestLoadSuccess(response.body);
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      if (id != 0) {
        getItems();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getItems(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text("Loading..."),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // title: Text(snapshot.data[index].propertyNum),
                    // subtitle: Text(snapshot.data[index].description),
                    ///////////////////////////////////////////////////////////////////
                    isThreeLine: true,
                    title: Text(snapshot.data![index].propertyNum),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data![index].description),
                          Text(snapshot.data![index].acquisitionDate),
                          Text(snapshot.data![index].estimatedLife),
                          Text(snapshot.data![index].officeDesignation),
                          Text(snapshot.data![index].serialNum),
                        ]),

                    /////////////////////////////////////////////////////////////////////////////
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyDetail(snapshot.data[index])));
                    },
                  );
                });
          }
        });
  }
}
