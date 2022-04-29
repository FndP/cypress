import 'dart:io';

import 'package:get_storage/get_storage.dart';

///base url
var baseUrl = "https://jsonplaceholder.typicode.com";

GetStorage? storage;

///api end points
String getPhotosUrl = "/photos";
String getAlbumsUrl = "/albums";

///to check internet connectivity :)
Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

GetStorage? getStorage() {
  storage ??= GetStorage();
  return storage;
}

///for debug purpose :)
printLog(var msg) {
  print(msg);
}
