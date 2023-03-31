// import 'package:auto_route/auto_route.dart';
// import 'package:chatiques/features/ai_conversation/ai_conversation_wrapper.dart';
// import 'package:chatiques/features/chat_list/chat_list_screen.dart';

// @MaterialAutoRouter(
//   replaceInRouteName: 'Screen,Route',
//   routes: <AutoRoute>[
//     AutoRoute(page: ChatListScreen, initial: true),
//     AutoRoute(page: AiConversationWrapper),
//   ],
// )
// class $AppRouter {}

import 'package:auto_route/auto_route.dart';
import 'package:chatiques/navigation/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    // AutoRoute(path: '/', page: AuthRoute.page)
    AutoRoute(
      path: '/',
      page: ChatListWrapper.page,
    ),
    AutoRoute(
      path: '/chat/:chatId',
      page: AiConversationWrapper.page,
    )
  ];
}
