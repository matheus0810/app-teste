import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/custom_scaffold.dart';

class CadastroVaga extends StatefulWidget {
  const CadastroVaga({super.key});

  @override
  State<CadastroVaga> createState() => _CadastroVagaState();
}

class _CadastroVagaState extends State<CadastroVaga> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final empresaController = TextEditingController();
  final cidadeController = TextEditingController();
  final contatoController = TextEditingController();
  final requisitosController = TextEditingController();

  void salvarVaga() async {
    if (tituloController.text.isNotEmpty &&
        descricaoController.text.isNotEmpty &&
        empresaController.text.isNotEmpty &&
        cidadeController.text.isNotEmpty &&
        contatoController.text.isNotEmpty &&
        requisitosController.text.isNotEmpty) {
      
      await FirebaseFirestore.instance.collection('vagas').add({
        'titulo': tituloController.text,
        'descricao': descricaoController.text,
        'empresa': empresaController.text,
        'cidade': cidadeController.text,
        'contato': contatoController.text,
        'requisitos': requisitosController.text,
        'dataCadastro': DateTime.now(),
        'ativo': true,
      });

      // Limpar os campos após salvar
      tituloController.clear();
      descricaoController.clear();
      empresaController.clear();
      cidadeController.clear();
      contatoController.clear();
      requisitosController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vaga cadastrada com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Cadastro de Vaga',
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
              controller: empresaController,
              decoration: const InputDecoration(labelText: 'Empresa'),
            ),
            TextField(
              controller: cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: contatoController,
              decoration: const InputDecoration(labelText: 'Número de Contato'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: requisitosController,
              decoration: const InputDecoration(labelText: 'Requisitos'),
              maxLines: 3,
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
