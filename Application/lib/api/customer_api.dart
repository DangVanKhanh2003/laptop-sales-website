import 'package:http/http.dart' as http;

class CustomerApi {
  final String _url = 'http://dangvankhanhblog.io.vn:7138/api/CustomerAccount';

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_url/Login?email=$email&password=$password');
    final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      // Đã lấy được danh mục, chuyển sang đối tượng
      return response.body;
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Lỗi đăng nhập: ${response.body}');
    }
  }

  Future<dynamic> register({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(
      '$_url/RegisterAccount?email=$email&password=$password',
    );
    final response = await http.post(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      // Đã lấy được danh mục, chuyển sang đối tượng
      return;
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Lỗi đăng ký: ${response.statusCode}');
    }
  }
}
