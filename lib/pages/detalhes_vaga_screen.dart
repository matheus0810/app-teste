import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart'; // Add this import for kIsWeb
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:html' as html; // Import necessário para Web

class DetalhesVagaScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetalhesVagaScreen({super.key, required this.data});

  @override
  _DetalhesVagaScreenState createState() => _DetalhesVagaScreenState();
}

class _DetalhesVagaScreenState extends State<DetalhesVagaScreen> {
  final GlobalKey _globalKey = GlobalKey(); // Chave para capturar a tela

  /// Captura a tela como imagem e salva no dispositivo
  Future<void> _salvarECompartilharImagem() async {
    try {
      RenderRepaintBoundary? boundary =
          _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        debugPrint("Erro ao capturar imagem: boundary é nulo.");
        return;
      }

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        debugPrint("Erro ao converter imagem.");
        return;
      }

      Uint8List pngBytes = byteData.buffer.asUint8List();

      if (kIsWeb) {
        // 🔹 SOLUÇÃO PARA WEB: Criar um Blob e fazer o Download
        final blob = html.Blob([pngBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", "vaga.png")
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        // 🔹 SOLUÇÃO PARA ANDROID/IOS: Salvar na galeria
        if (await Permission.storage.request().isGranted) {
          final result = await ImageGallerySaver.saveImage(pngBytes);
          if (result['isSuccess']) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Imagem salva na galeria!")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Permissão negada para salvar imagem.")),
          );
          return;
        }

        // 🔹 Salvar temporariamente para compartilhar
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/vaga.png');
        await file.writeAsBytes(pngBytes);

        // 🔹 Compartilhar a imagem
        await Share.shareXFiles([XFile(file.path)], text: "Confira essa vaga!");
      }
    } catch (e) {
      debugPrint("Erro ao capturar e salvar imagem: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao salvar imagem.")),
      );
    }
  }

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
                  "${widget.data['titulo']?.toUpperCase() ?? "CARGO NÃO INFORMADO"} | INÍCIO IMEDIATO",
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
                  "Interessados enviar currículo via WhatsApp:",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
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
                      onPressed: () {}, // Adicione o link para o Facebook
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.whatsapp,
                          color: Colors.green),
                      onPressed: () {}, // Adicione o link para abrir o WhatsApp
                    ),
                    IconButton(
                      icon: const Icon(Icons.email, color: Colors.red),
                      onPressed: () {}, // Adicione o link para o email
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      /// Botão de compartilhar no rodapé
      floatingActionButton: FloatingActionButton(
        onPressed: _salvarECompartilharImagem, 
        child: Text('Salvar'),
      ),
    );
  }
}
