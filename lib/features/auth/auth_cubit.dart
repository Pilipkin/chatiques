import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final vk = VKLogin();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        emit(Authenticated());
      } else {
        emit(AuthFailed("Ошибка авторизации Google"));
      }
    } catch (error) {
      emit(AuthFailed(error.toString()));
    }
  }

  Future<void> signInWithVk() async {
    try {
      await vk.initSdk();
      // final VKLoginResult result = await vk.logIn()

      // if (result.isValue) {
      //   final VKAccessToken? accessToken = result.asValue!.value;
      //   if (accessToken != null) {
      //     emit(Authenticated());
      //   } else {
      //     emit(AuthFailed("Ошибка авторизации VK"));
      //   }
      // } else {
      //   emit(AuthFailed(result.asError!.error.toString()));
      // }
    } catch (error) {
      emit(AuthFailed(error.toString()));
    }
  }
}
