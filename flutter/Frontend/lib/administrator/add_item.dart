import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:Login/administrator/data_class.dart';

class HomePageManager {
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());

  Future addItem(propertyNum, description, acquisitionDate, estimatedLife,      //ADD ITEM
      officeDesignation, serialNum) async {
    resultNotifier.value = RequestLoadInProgress();
    const endpoint = 'http://192.168.1.19:1337/api/items';
    var url = Uri.parse(endpoint);

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var data = jsonEncode({
      'data': {
        'propertyNum': propertyNum,
        'description': description,
        'acquisitionDate': acquisitionDate,
        'estimatedLife': estimatedLife,
        'officeDesignation': officeDesignation,
        'serialNum': serialNum,
      }
    });
    var response = await http.post(
      url,
      headers: headers,
      body: data,
    );

    print('Status code: ${response.statusCode}');
    print('Item List: ${response.body}');
    _handleResponse(response);
  }

  void _handleResponse(Response response) {
    if (response.statusCode >= 400) {
      resultNotifier.value = RequestLoadFailure();
    } else {
      resultNotifier.value = RequestLoadSuccess(response.body);
    }
  }
}

class MyForm extends StatefulWidget {
  // int id;
  // MyForm(this.id);
  @override
  _MyFormState createState() => _MyFormState();
}

TextEditingController propertyNumberController =
    TextEditingController(text: item.propertyNum);
TextEditingController descriptionController =
    TextEditingController(text: item.description);
TextEditingController acquisitionDateController =
    TextEditingController(text: item.acquisitionDate);
TextEditingController estimatedLifeController =
    TextEditingController(text: item.estimatedLife);
TextEditingController officeDesignationController =
    TextEditingController(text: item.officeDesignation);
TextEditingController serialNumController =
    TextEditingController(text: item.serialNum);

Item item = Item(
    propertyNum: '',
    description: '',
    acquisitionDate: '',
    estimatedLife: '',
    officeDesignation: '',
    serialNum: '');

class _MyFormState extends State<MyForm> {
  final stateManager = HomePageManager();
  // int id;
  // _MyFormState(this.id);
  // Item item = Item(0, '', '', '', '', '', '');
  // Future save() async {
  //   if (item.id == 0) {
  //     await http.post('http://10.10.10.15:1337/api/administrators',
  //         headers: <String, String>{
  //           'Context-Type': 'application/json;charset=UTF-8'
  //         },
  //         body: <String, String>{
  //           'propertyNumber': item.propertyNumber,
  //           'description': item.description,
  //           'acquisitionDate': item.acquisitionDate,
  //           'estimatedLife': item.estimatedLife,
  //           'officeDesignation': item.officeDesignation,
  //           'brandSerialNumber': item.brandSerialNumber
  //         });
  //   } else {
  //     await http.put(
  //         'http://10.10.10.15:1337/api/administrators${item.id.toString()}',
  //         headers: <String, String>{
  //           'Context-Type': 'application/json;charset=UTF-8'
  //         },
  //         body: <String, String>{
  //           'propertyNumber': item.propertyNumber,
  //           'description': item.description,
  //           'acquisitionDate': item.acquisitionDate,
  //           'estimatedLife': item.estimatedLife,
  //           'officeDesignation': item.officeDesignation,
  //           'brandSerialNumber': item.brandSerialNumber
  //         });
  //   }
  //   Navigator.push(
  //       context, new MaterialPageRoute(builder: (context) => Home(1, 0)));
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   if (id != 0) {
  //     getOne();
  //   }
  // }

  // void getOne() async {
  //   var data =
  //       await http.get('http://localhost:1337/api/items${this.id}');
  //   var u = json.decode(data.body);
  //   setState(() {
  //     item = Item(
  //         u['id'],
  //         u['propertyNumber'],
  //         u['description'],
  //         u['acquisitionDate'],
  //         u['estimatedLife'],
  //         u['officeDesignation'],
  //         u['brandSerialNumber']);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            children: [
              Visibility(
                visible: false,
                child: TextField(
                    controller:
                        TextEditingController(text: item.id.toString())),
              ),
              //
              TextField(
                controller: TextEditingController(text: item.propertyNum),
                onChanged: (val) {
                  item.propertyNum = val;
                },
                decoration: const InputDecoration(
                    labelText: "Property Number",
                    icon: Icon(Icons.error_outline)),
              ),
              //
              TextField(
                controller: TextEditingController(text: item.description),
                onChanged: (val) {
                  item.description = val;
                },
                decoration: const InputDecoration(
                    labelText: "Description", icon: Icon(Icons.error_outline)),
              ),
              //
              TextField(
                controller: TextEditingController(text: item.acquisitionDate),
                onChanged: (val) {
                  item.acquisitionDate = val;
                },
                decoration: const InputDecoration(
                    labelText: "Acquisition Date",
                    icon: Icon(Icons.error_outline)),
              ),
              //
              TextField(
                controller: TextEditingController(text: item.estimatedLife),
                onChanged: (val) {
                  item.estimatedLife = val;
                },
                decoration: const InputDecoration(
                    labelText: "Estimated Life",
                    icon: Icon(Icons.error_outline)),
              ),
              //
              TextField(
                controller: TextEditingController(text: item.officeDesignation),
                onChanged: (val) {
                  item.officeDesignation = val;
                },
                decoration: const InputDecoration(
                    labelText: "Office Designation",
                    icon: Icon(Icons.error_outline)),
              ),
              //
              TextField(
                controller: TextEditingController(text: item.serialNum),
                onChanged: (val) {
                  item.serialNum = val;
                },
                decoration: const InputDecoration(
                    labelText: "Brand Serial Number",
                    icon: Icon(Icons.error_outline)),
              ),
              //
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
                child: ElevatedButton(
                    onPressed: () {
                      stateManager.addItem(
                          propertyNumberController.text,
                          descriptionController.text,
                          acquisitionDateController.text,
                          estimatedLifeController.text,
                          officeDesignationController.text,
                          serialNumController.text);
                    },
                     style: ElevatedButton.styleFrom(
                                primary: const Color(0xfffd5800),
                              ),
                              child: const Text("Add Item"),
                    // child: const Text(
                    //   'Add Item',
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // )
                    ),

                // child: MaterialButton(
                //   onPressed: addItem,
                //   minWidth: double.infinity,
                //   color: Colors.orange,
                //   textColor: Colors.white,
                //   child: const Text("Save Item"),
                // ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
