import 'package:http/http.dart' as http;
import 'dart:async';


getServer(String url) async{
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}