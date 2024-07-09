import 'package:http/http.dart' as http;
import 'dart:convert';

// URL endpoint API
const String apiUrl = 'http://192.168.172.30/api_perpustakaan/delete.php';

// Fungsi untuk menghapus dokter
Future<void> deletePengunjung(int id) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'id_pengunjung': id.toString(),
    },
  );

  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    if (responseBody['message'] == 'deleted!') {
      print('deleted successfully');
    } else {
      throw Exception('Failed to delete');
    }
  } else {
    throw Exception('Failed to connect');
  }
}
