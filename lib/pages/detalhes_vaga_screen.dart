import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/widgets/custom_scaffold.dart';

class DetalhesVagaScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetalhesVagaScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Detalhes da Vaga',
      body: Stack(
        children: [
          // Fundo com marca d'água "@povo_ninja"
          Positioned.fill(
            child: Opacity(
              opacity: 0.08,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(
                      20,
                      (index) => Text(
                        "@povo_ninja",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Conteúdo principal
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Cabeçalho estilizado
                CustomHeader(cidade: data['cidade'] ?? 'LOCAL NÃO INFORMADO'),
                SizedBox(height: 20),

                // Informações da vaga
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        (data['empresa'] ?? "Empresa não informada")
                                .toUpperCase() +
                            " CONTRATA:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        data['titulo'] ?? "Título não informado",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 10),
                      Text(
                        "REQUISITOS:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        data['requisitos'] ?? "Nenhum requisito informado",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),

                      // Contato
                      Text(
                        "Interessados enviar currículo via WhatsApp:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        data['contato'] ?? "Contato não disponível",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent),
                      ),
                      SizedBox(height: 12),

                      // Descrição
                      Text(
                        data['descricao'] ?? "Descrição não informada",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text('debug 14'),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Redes Sociais e Patrocinador
                Container(
                  color: Colors.blue.shade700,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                        ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset("assets/povo_ninja.jpg", width: 75),
                        ),
                      SizedBox(height: 10),
                      Text(
                        "SIGA NOSSAS REDES SOCIAIS:",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.instagram,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.facebook,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.whatsapp,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.telegram,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "PATROCINADOR OFICIAL:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Image.asset("assets/smartwork_logo.png", width: 150),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ========================= Cabeçalho Estilizado =========================

class CustomHeader extends StatelessWidget {
  final String cidade;

  const CustomHeader({super.key, required this.cidade});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Camada azul-claro (fundo)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: LightBlueClipper(),
            child: Container(
              height: 60,
              color: Colors.lightBlueAccent.shade100,
            ),
          ),
        ),

        // Camada azul-escuro principal
        ClipPath(
          clipper: DarkBlueClipper(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
            ),
            child: Text(
              "OPORTUNIDADE EM ${cidade.toUpperCase()} - PR",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ========================= Clipper Azul-Escuro =========================

class DarkBlueClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 10);
    path.quadraticBezierTo(
        size.width * 0.2, size.height + 5, size.width * 0.5, size.height - 5);
    path.quadraticBezierTo(
        size.width * 0.85, size.height - 20, size.width, size.height - 8);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ========================= Clipper Azul-Claro =========================

class LightBlueClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - 3);

    // Ajuste na primeira curva para manter suavidade
    path.quadraticBezierTo(size.width * 0, size.height - 130, size.width * 0.55,
        size.height - 130);

    // Ajuste na segunda curva para garantir fluidez
    path.quadraticBezierTo(
        size.width * 0.2, size.height + 10, size.width, size.height - 100);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
