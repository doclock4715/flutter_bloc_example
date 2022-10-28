import 'dart:convert';

import 'package:flutter_bloc_example/models/random_number.dart';
import 'package:flutter_bloc_example/models/spacex_model.dart';
import 'package:http/http.dart' as http;

class SpaceXRepostitory {
  String endpoint = "https://api.spacexdata.com/v4/launches/";

  Future<List<SpaceX>> getSpaceXLaunchesData() async {
    Uri url = Uri.parse(endpoint);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List decodedResponseBody = jsonDecode(response.body);
      return decodedResponseBody.map(((e) => SpaceX.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
//To demonstrate refresh
  Future<List<RandomNumber>> getRandomNumber() async {
    Uri url = Uri.parse("https://csrng.net/csrng/csrng.php?max=100");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List decodedResponseBody = jsonDecode(response.body);
      return decodedResponseBody.map(((e) => RandomNumber.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
