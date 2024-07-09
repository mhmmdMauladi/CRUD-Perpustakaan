import 'dart:convert';
import 'package:http/http.dart' as http;

class ModelPengunjung {
  int id;
  String name;
  String usia;
  String tujuan;
  String date;
  String range;
  String image;

  ModelPengunjung({
    required this.id,
    required this.name,
    required this.usia,
    required this.tujuan,
    required this.date,
    required this.range,
    required this.image,
  });

  factory ModelPengunjung.fromJson(Map<String, dynamic> json) {
    return ModelPengunjung(
      id: int.tryParse(json['id_pengunjung']?.toString() ?? '0') ?? 0,
      name: json['nama'] ?? 'Unknown',
      usia: json['usia'] ?? 'Unknown',
      tujuan: json['tujuan'] ?? 'Unknown',
      date: json['date'] ?? 'Unknown',
      range: json['range'] ?? 'Unknown',
      image: "user-3.png",
    );
  }
}

Future<List<ModelPengunjung>> fetchPengunjung() async {
  final response = await http
      .get(Uri.parse('http://192.168.172.30/api_perpustakaan/read.php'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => ModelPengunjung.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load doctors');
  }
}
