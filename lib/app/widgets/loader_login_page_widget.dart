import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'custom_snack_bar_widget.dart';


class LoaderLoginPage extends StatelessWidget {
  const LoaderLoginPage({
    Key? key,
    required this.getData,
    required this.getBack,
  }) : super(key: key);

  final Future getData;
  final Function getBack;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FutureBuilder(
            future: getData,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  Future.delayed(Duration.zero, () async {
                    CustomSnack().buildCardError("Dados inválidos, tente recuperar sua senha.");
                  });
                  Future.delayed(Duration.zero, () async {
                    getBack();
                  });
                }
              }
              return Container(
                color: Theme.of(context).colorScheme.surface,
                child: Center(
                  child: GFLoader(type: GFLoaderType.android,
                    androidLoaderColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                  ),
                ),
              );
            }));
  }
}
