import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class EditarCliente extends StatefulWidget {
  final String clienteId;
  final Map<String, dynamic> dadosCliente;

  const EditarCliente({super.key, required this.clienteId, required this.dadosCliente});

  @override
  State<EditarCliente> createState() => _EditarClienteState();
}

class _EditarClienteState extends State<EditarCliente> {
  late TextEditingController nomeController;
  late TextEditingController emailController;
  late MaskedTextController cnpjController;
  late TextEditingController enderecoController;
  late MaskedTextController telefoneController;
  late MaskedTextController cepController;
  late TextEditingController cidadeController;
  late TextEditingController estadoController;
  late TextEditingController observacoesController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.dadosCliente['nome']);
    emailController = TextEditingController(text: widget.dadosCliente['email']);
    cnpjController = MaskedTextController(mask: '00.000.000/0000-00', text: widget.dadosCliente['cnpj']);
    enderecoController = TextEditingController(text: widget.dadosCliente['endereco']);
    telefoneController = MaskedTextController(mask: '(00) 00000-0000', text: widget.dadosCliente['telefone']);
    cepController = MaskedTextController(mask: '00000-000', text: widget.dadosCliente['cep']);
    cidadeController = TextEditingController(text: widget.dadosCliente['cidade']);
    estadoController = TextEditingController(text: widget.dadosCliente['estado']);
  }

void salvarEdicao() async {
  await FirebaseFirestore.instance
      .collection('usuarios')
      .doc(widget.clienteId)
      .update({
    'nome': nomeController.text,
    'email': emailController.text,
    'cnpj': cnpjController.text,
    'endereco': enderecoController.text,
    'telefone': telefoneController.text,
    'cep': cepController.text,
    'cidade': cidadeController.text,
    'estado': estadoController.text,
  });

  if (mounted) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cliente atualizado com sucesso!')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Cliente')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: cnpjController, decoration: const InputDecoration(labelText: 'CNPJ')),
            TextField(controller: telefoneController, decoration: const InputDecoration(labelText: 'Telefone')),
            TextField(controller: cepController, decoration: const InputDecoration(labelText: 'CEP')),
            TextField(controller: enderecoController, decoration: const InputDecoration(labelText: 'Endereço')),
            TextField(controller: cidadeController, decoration: const InputDecoration(labelText: 'Cidade')),
            TextField(controller: estadoController, decoration: const InputDecoration(labelText: 'Estado')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvarEdicao,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
