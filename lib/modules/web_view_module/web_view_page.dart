// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// class WebViewPage extends StatefulWidget {
//   const WebViewPage({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewPage> createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   @override
//   Widget build(BuildContext context) {
//
//     final box = context.findRenderObject() as RenderBox?;
//
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//             color: Colors.black
//         ),
//         elevation: 0,
//         title: const Text(
//           "Freed Company",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Share.share('Compartilhei',
//                 subject: 'Compartilhei',);
//           },
//           child: Text('Share'),
//         ),
//       ),
//     );
//   }
// }
