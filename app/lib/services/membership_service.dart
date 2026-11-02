import 'dart:convert';
import 'package:http/http.dart' as http;

class MembershipService {
  static Future<Map<String, dynamic>?> checkMembership(int userId) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/membership/check/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        return decodedData; // Mengembalikan data ke UI
      } else {
        print("Gagal mengambil data: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error koneksi: $e");
      return null;
    }
  }
}