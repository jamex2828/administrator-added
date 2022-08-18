import 'package:Login/administrator/admin/data_class.dart';
import 'package:Login/administrator/user/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';

class Users extends StatefulWidget {
  Users({Key? key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());
  
  get id => null;

  // Future getUsers() //not working
  Future<void> getUsers() async {
    resultNotifier.value = RequestLoadInProgress();
    Response response = await http.get(
      Uri.parse('http://10.10.10.15:1337/api/userlists'),
    );
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Users: ${response.body}');
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
       if(this.id != 0){
        getUsers();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text("Data null shit"),
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
                    title: Text(snapshot.data[index].propertyNum),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data[index].description),
                          
                        ]),

                    /////////////////////////////////////////////////////////////////////////////
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserDetails(snapshot.data[index])));
                    },
                  );
                });
          }
        });
  }
}
