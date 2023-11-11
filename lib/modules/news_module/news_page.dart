import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/widgets/custom_header_widget.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.inversePrimary,
              child:
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    child: Icon(Icons.arrow_back_rounded,
                      color: Theme.of(context).colorScheme.inverseSurface,),
                    onTap: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 20),
                const CustomHeader(text: 'Novidades')
              ]),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              '12/06/2022 :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          )),
                      const InfoDetails(
                          message:
                              'Criação de grupos privados, não indexados na pesquisa,'
                              ' com atribuição de senha.'),
                      const InfoDetails(message: 'Listagem de usuários por sala.'),
                      const InfoDetails(
                          message: 'Nova UI para a pesquisa de Grupos.'),
                      const InfoDetails(message: 'Adição de NavigationRail para Web'),
                      const InfoDetails(
                          message: 'Correção da tabela de cores das Tarefas.'),
                      const InfoDetails(
                          message: 'Correção de animação ao trocar de páginas.'),
                      const InfoDetails(message: 'Adição de Chat por sala.'),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              '12/03/2023 :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          )),
                      const InfoDetails(message: 'Adição de Dark Mode.'),

                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoDetails extends StatelessWidget {
  const InfoDetails({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: const Icon(
            Icons.check,
            size: 13,
          ),
        ),
        Expanded(
          child: Text(
            message,
          ),
        )
      ]),
    );
  }
}
