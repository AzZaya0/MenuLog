part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnGoogleLogin extends LoginEvent {
  final BuildContext context;

  OnGoogleLogin({required this.context});
}

class OnGoogleLogout extends LoginEvent {}
