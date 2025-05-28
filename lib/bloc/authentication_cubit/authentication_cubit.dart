import 'package:fast/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_states.dart';

typedef LoginCallback<T> = Future<T> Function();
typedef LogoutCallback = Future<dynamic> Function();

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final LoginCallback loginCallback;
  final LogoutCallback logoutCallback;

  AuthenticationCubit(
    super.initialState, {
    required this.loginCallback,
    required this.logoutCallback,
  });

  Future<void> login() async {
    final result = await loginCallback();

    if (result != null) {
      emit(AuthenticatedState(result));
    } else {
      emit(UnauthenticatedState());
    }
  }

  Future<void> logout() async {
    try {
      await logoutCallback();
    } catch (error) {
      Logger.error(error);
    }
  }
}
