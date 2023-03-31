import 'package:chatiques/navigation/router.dart';
import 'package:flutter/material.dart';

class ChatiquesApp extends StatelessWidget {
  const ChatiquesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    // return MaterialApp(
    //   title: 'Chatiques',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   onGenerateRoute: (settings) {
    //     return MaterialPageRoute(
    //       builder: (context) {
    //         switch (settings.name) {
    //           case '/':
    //             return const AiConversationWrapper();
    //           case '/chat_details':
    //             return const ChatDetails();
    //           default:
    //             return const AiConversationWrapper();
    //         }
    //       },
    //     );
    //   },
    // );
    return MaterialApp.router(
      title: 'Chatiques',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
