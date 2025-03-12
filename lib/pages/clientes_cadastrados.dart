import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editar_cliente.dart';

class ClientesCadastrados extends StatefulWidget {
  const ClientesCadastrados({super.key});

  @override
  ClientesCadastradosState createState() => ClientesCadastradosState();
}

class ClientesCadastradosState extends State<ClientesCadastrados> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Pesquisar...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum cliente cadastrado.'));
          }

          final clientes = snapshot.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final nome = data['nome']?.toLowerCase() ?? '';
            return nome.contains(searchQuery);
          }).toList();

          return ListView.builder(
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              final cliente = clientes[index];
              final data = cliente.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['nome'] ?? 'Nome não informado'),
                subtitle: Text(data['email'] ?? 'Email não informado'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarCliente(
                              clienteId: cliente.id,
                              dadosCliente: data,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(cliente.id)
                            .delete();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}