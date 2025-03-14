import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const CustomScaffold({
    Key? key,
    required this.body,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white), // Ícone branco
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          if (Navigator.canPop(context)) // Só exibe o botão de voltar se puder voltar
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  height: 2,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.people),
              title: const Text('Clientes'),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person_add),
                  title: const Text('Cadastro'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/cadastro_cliente');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('Lista de Clientes'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/clientes_cadastrados');
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.work),
              title: const Text('Vagas'),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Cadastrar Vaga'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/cadastrar_vaga');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('Lista de Vagas'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/lista_vagas');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
