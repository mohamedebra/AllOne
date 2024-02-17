abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  var data;
  LoginSuccess(this.data);
}

class LoginError extends LoginState {
  String error;
  LoginError(this.error);
}
