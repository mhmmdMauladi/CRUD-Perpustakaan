import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> updatePengunjung(int id, String name, String usia, String tujuan,
    String date, String range) async {
  final response = await http.post(
    Uri.parse('http://192.168.172.30/api_perpustakaan/update.php'),
    body: {
      'id_pengunjung': id.toString(),
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
      if (jsonResponse['message'] == 'updated!') {
        print('Updated successfully');
      } else {
        throw Exception('Failed to update: ${jsonResponse['error']}');
      }
    } catch (e) {
      throw Exception('Failed to parse response: ${response.body}');
    }
  } else {
    throw Exception(
        'Failed to update. HTTP status code: ${response.statusCode}');
  }
}
