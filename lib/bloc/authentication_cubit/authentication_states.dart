sealed class AuthenticationState {}

class AuthenticatedState<T> extends AuthenticationState {
  final T data;

  AuthenticatedState(this.data);
}

class UnauthenticatedState extends AuthenticationState {}
