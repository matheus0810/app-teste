import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({super.key});

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final MaskedTextController cnpjController = MaskedTextController(mask: '00.000.000/0000-00');
  final TextEditingController enderecoController = TextEditingController();
  final MaskedTextController telefoneController = MaskedTextController(mask: '(00) 00000-0000');
  final MaskedTextController cepController = MaskedTextController(mask: '00000-000');
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();

  final CollectionReference usuarios =
      FirebaseFirestore.instance.collection('usuarios');

  void salvarUsuario() async {
    String nome = nomeController.text;
    String email = emailController.text;
    String cnpj = cnpjController.text;
    String endereco = enderecoController.text;
    String telefone = telefoneController.text;
    String cep = cepController.text;
    String cidade = cidadeController.text;
    String estado = estadoController.text;

    if (nome.isNotEmpty &&
        email.isNotEmpty &&
        cnpj.isNotEmpty &&
        endereco.isNotEmpty &&
        telefone.isNotEmpty &&
        cep.isNotEmpty &&
        cidade.isNotEmpty &&
        estado.isNotEmpty) {
      await usuarios.add({
        'nome': nome,
        'email': email,
        'cnpj': cnpj,
        'endereco': endereco,
        'telefone': telefone,
        'cep': cep,
        'cidade': cidade,
        'estado': estado,
        'dataCadastro': DateTime.now(),
      });

      nomeController.clear();
      emailController.clear();
      cnpjController.clear();
      enderecoController.clear();
      telefoneController.clear();
      cepController.clear();
      cidadeController.clear();
      estadoController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente cadastrado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Cliente')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: cnpjController,
              decoration: const InputDecoration(labelText: 'CNPJ'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: cepController,
              decoration: const InputDecoration(labelText: 'CEP'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: enderecoController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            TextField(
              controller: cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: estadoController,
              decoration: const InputDecoration(labelText: 'Estado'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvarUsuario,
              child: const Text('Cadastrar Cliente'),
            ),
          ],
        ),
      ),
    );
  }
}
