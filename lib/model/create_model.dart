import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> addPengunjung(
    String name, String usia, String tujuan, String date, String range) async {
  final response = await http.post(
    Uri.parse('http://192.168.172.30/api_perpustakaan/create.php'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: <String, String>{
      'nama': name,
      'usia': usia,
      'tujuan': tujuan,
      'date': date,
      'range': range,
    },
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    try {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['message'] == 'created!') {
        print('Added successfully');
      } else {
        throw Exception('Failed to add: ${jsonResponse['error']}');
      }
    } catch (e) {
      throw Exception('Failed to parse response: ${response.body}');
    }
  } else {
    throw Exception('Failed to add. HTTP status code: ${response.statusCode}');
  }
}
