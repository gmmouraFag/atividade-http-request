import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  Future<UserModel> fetchUserById(int id) async {
    final url = Uri.parse('https://reqres.in/api/users/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      if (data != null) {
        return UserModel.fromJson(data);
      } else {
        throw Exception('Usuário não encontrado!');
      }
    } else {
      throw Exception('Erro ao buscar usuário!');
    }
  }
}
