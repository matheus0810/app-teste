import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/pages/detalhes_vaga_screen.dart';


class ListaVagas extends StatelessWidget {
  const ListaVagas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vagas Cadastradas')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('vagas').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhuma vaga cadastrada.'));
          }

          final vagas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: vagas.length,
            itemBuilder: (context, index) {
              final vaga = vagas[index];
              final data = vaga.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: ListTile(
                  title: Text(
                    data['titulo'] ?? 'Sem título',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Empresa: ${data['empresa'] ?? "Não informada"}'),
                  onTap: () {
                    // Navegar para a tela de detalhes da vaga
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesVagaScreen(data: data),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
