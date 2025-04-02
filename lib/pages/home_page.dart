import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return CustomScaffold(
      title: 'Home',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo, ${user?.displayName} ''.'.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall,
            ), 
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildOptionCard(
                    icon: Icons.person,
                    title: "Cliente",
                    description: "Cadastro e Lista de Clientes",
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                          leading: const Icon(Icons.person_add),
                          title: const Text("Cadastrar Cliente"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/cadastro_cliente');
                          },
                          ),
                          ListTile(
                          leading: const Icon(Icons.list),
                          title: const Text("Clientes Cadastrados"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/clientes_cadastrados');
                          },
                          ),
                        ],
                        ),
                        actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar"),
                        ),
                        ],
                      );
                      },
                    ),
                  ),
                  _buildOptionCard(
                    icon: Icons.work,
                    title: "Vagas",
                    description: "Cadastro e Lista de Vagas",
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                          leading: const Icon(Icons.add),
                          title: const Text("Cadastrar Vaga"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/cadastrar_vaga');
                          },
                          ),
                          ListTile(
                          leading: const Icon(Icons.list),
                          title: const Text("Vagas Cadastradas"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/lista_vagas');
                          },
                          ),
                        ],
                        ),
                        actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar"),
                        ),
                        ],
                      );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
