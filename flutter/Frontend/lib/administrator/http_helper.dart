import 'package:Login/administrator/admin/data_class.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';




class HomePageManager {
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());

  Future<void> deleteItem() async {
    resultNotifier.value = RequestLoadInProgress();
    Response response = await http.delete(
      Uri.parse('http://10.10.10.15:1337/api/items/1'), //edit filter
    );
    print('Status code: ${response.statusCode}');
    print('Deleted item: ${response.body}');
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
