// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:chatiques/features/ai_conversation/ai_conversation_wrapper.dart'
    as _i4;
import 'package:chatiques/features/auth/auth_screen.dart' as _i1;
import 'package:chatiques/features/chat_list/chat_list_screen.dart' as _i3;
import 'package:chatiques/features/chat_list/chat_list_wrapper.dart' as _i2;
import 'package:chatiques/screens/auth/login_screen.dart' as _i5;
import 'package:chatiques/screens/chat_details/chat_details.dart' as _i6;
import 'package:flutter/material.dart' as _i8;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    ChatListWrapper.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChatListWrapper(),
      );
    },
    ChatListRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ChatListScreen(),
      );
    },
    AiConversationWrapper.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AiConversationWrapperArgs>(
          orElse: () => AiConversationWrapperArgs(
              chatId: pathParams.getString('chatId')));
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.AiConversationWrapper(
          key: args.key,
          chatId: args.chatId,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LoginScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    ChatDetails.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ChatDetails(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i7.PageRouteInfo<void> {
  const AuthRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatListWrapper]
class ChatListWrapper extends _i7.PageRouteInfo<void> {
  const ChatListWrapper({List<_i7.PageRouteInfo>? children})
      : super(
          ChatListWrapper.name,
          initialChildren: children,
        );

  static const String name = 'ChatListWrapper';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChatListScreen]
class ChatListRoute extends _i7.PageRouteInfo<void> {
  const ChatListRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ChatListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatListRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AiConversationWrapper]
class AiConversationWrapper
    extends _i7.PageRouteInfo<AiConversationWrapperArgs> {
  AiConversationWrapper({
    _i8.Key? key,
    required String chatId,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          AiConversationWrapper.name,
          args: AiConversationWrapperArgs(
            key: key,
            chatId: chatId,
          ),
          rawPathParams: {'chatId': chatId},
          initialChildren: children,
        );

  static const String name = 'AiConversationWrapper';

  static const _i7.PageInfo<AiConversationWrapperArgs> page =
      _i7.PageInfo<AiConversationWrapperArgs>(name);
}

class AiConversationWrapperArgs {
  const AiConversationWrapperArgs({
    this.key,
    required this.chatId,
  });

  final _i8.Key? key;

  final String chatId;

  @override
  String toString() {
    return 'AiConversationWrapperArgs{key: $key, chatId: $chatId}';
  }
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i8.Key? key,
    String title = 'Login',
    List<_i7.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<LoginRouteArgs> page =
      _i7.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    this.title = 'Login',
  });

  final _i8.Key? key;

  final String title;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [_i6.ChatDetails]
class ChatDetails extends _i7.PageRouteInfo<void> {
  const ChatDetails({List<_i7.PageRouteInfo>? children})
      : super(
          ChatDetails.name,
          initialChildren: children,
        );

  static const String name = 'ChatDetails';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
