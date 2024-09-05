import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn/model/data_intership_model.dart';

class DataServices{
  String baseUrl2 = "https://monpfeserverlessdata.netlify.app/api";

  Future<List<DataIntershipModel>> getInterships() async {
    var apiUrl1 = '/data';
    print(baseUrl2+apiUrl1);
    http.Response res = await http.get(Uri.parse(baseUrl2 + apiUrl1));
    print('Status Code: ${res.statusCode}');
    print('Response Body: ${res.body}');
    try {
      if (res.statusCode == 200) {

        var data = json.decode(res.body);


        List<dynamic> list = data['items'];


        print(list);


        return list.map((e) => DataIntershipModel.fromJson(e)).toList();
      } else {
        print("Failed to load data, status code: ${res.statusCode}");
        return <DataIntershipModel>[];
      }
    } catch (e) {
      print("Error: $e");
      return <DataIntershipModel>[];
    }
  }

}