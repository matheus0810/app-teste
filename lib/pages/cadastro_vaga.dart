import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroVaga extends StatefulWidget {
  const CadastroVaga({super.key});

  @override
  State<CadastroVaga> createState() => _CadastroVagaState();
}

class _CadastroVagaState extends State<CadastroVaga> {
  final localizacaoController = TextEditingController();

  void salvarVaga() async {
    if (tituloController.text.isNotEmpty &&
        descricaoController.text.isNotEmpty &&
        EmpresaController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('vagas').add({
        'titulo': tituloController.text,
        'descricao': descricaoController.text,
        'empresa': EmpresaController.text,
        'dataCadastro': DateTime.now(),
        'ativo': true,
      });

      tituloController.clear();
      descricaoController.clear();
      EmpresaController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vaga cadastrada com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
    }
  }

  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final EmpresaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Vaga')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: 'Título da Vaga'),
            ),
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
            ),
            TextField(
              controller: EmpresaController,
              decoration: const InputDecoration(labelText: 'Empresa'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvarVaga,
              child: const Text('Cadastrar Vaga'),
            ),
          ],
        ),
      ),
    );
  }
}
