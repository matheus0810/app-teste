import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'pages/cadastro_cliente.dart';
import 'pages/clientes_cadastrados.dart';
import 'pages/editar_cliente.dart';
import 'pages/lista_vagas.dart';
import 'pages/cadastro_vaga.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

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
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
      routes: {
        '/cadastro_cliente': (context) => const CadastroCliente(),
        '/clientes_cadastrados': (context) => const ClientesCadastrados(),
        '/editar_cliente': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return EditarCliente(
            clienteId: args['clienteId'],
            dadosCliente: args['dadosCliente'],
          );
        },
        '/cadastrar_vaga': (context) => const CadastroVaga(),
        '/lista_vagas': (context) => const ListaVagas(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
