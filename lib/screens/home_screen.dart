import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import '../widgets/search_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _idController = TextEditingController();
  final UserService _userService = UserService();

  UserModel? _user;
  String? _error;

  void _buscarUsuario() async {
    setState(() {
      _user = null;
      _error = null;
    });

    final id = int.tryParse(_idController.text);
    if (id == null) {
      setState(() => _error = 'ID inválido. Digite um número entre 1 e 12.');
      return;
    }

    try {
      final user = await _userService.fetchUserById(id);
      setState(() => _user = user);
    } catch (e) {
      setState(() => _error = 'Erro ao buscar usuário. Tente novamente.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 110,),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: 300,
              height: 300,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF81D4FA),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 50)],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  const Text('Digite o ID(1 a 12)', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30,),

                  Center(

                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _idController,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40,),
                  ElevatedButton(
                    onPressed: _buscarUsuario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Buscar', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_user != null) SearchCard(user: _user!),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
