import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: 200,
            child: Center(
              child: Text("PRO NERD",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
            child: Center(
              child: Text('SIMPLICITY FOR MORE',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
