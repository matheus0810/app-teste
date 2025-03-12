import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


class DetalhesVagaScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetalhesVagaScreen({super.key, required this.data});

  @override
  _DetalhesVagaScreenState createState() => _DetalhesVagaScreenState();
}

class _DetalhesVagaScreenState extends State<DetalhesVagaScreen> {
  final GlobalKey _globalKey = GlobalKey(); // Chave para capturar a tela


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Detalhes da Vaga")),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _globalKey,
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Título do anúncio
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "OPORTUNIDADE EM ${widget.data['localizacao']?.toUpperCase() ?? "LOCAL NÃO INFORMADO"}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                /// Cargo e salário
                Text(
                  "${widget.data['titulo']?.toUpperCase() ?? "CARGO NÃO INFORMADO"}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Salário R\$ ${widget.data['salario'] ?? "Não informado"}",
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                /// Requisitos
                const Text(
                  "REQUISITOS:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.data['descricao'] ?? "Nenhuma descrição disponível.",
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 16),

                /// Informações de contato
                Text(
                  widget.data['contato'] ?? "(Número não informado)",
                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                ),

                const SizedBox(height: 20),

                /// Redes sociais
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.whatsapp,
                          color: Colors.green),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.email, color: Colors.red),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
