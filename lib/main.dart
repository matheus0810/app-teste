import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/cadastro_cliente.dart';
import 'pages/clientes_cadastrados.dart';
import 'pages/editar_cliente.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
routes: {
  '/': (context) => const HomePage(),
  '/cadastro_cliente': (context) => const CadastroCliente(),
  '/clientes_cadastrados': (context) => const ClientesCadastrados(),
  '/editar_cliente': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return EditarCliente(
      clienteId: args['clienteId'],
      dadosCliente: args['dadosCliente'],
    );
  },
},

      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastro_cliente');
              },
              child: const Text('Cadastrar Cliente'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/clientes_cadastrados');
              },
              child: const Text('Lista de Clientes'),
            ),
          ],
        ),
      ),
    );
  }
}