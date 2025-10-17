part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class fetchlogin extends LoginEvent {
  final String? phoneNumber;
 

  fetchlogin({required this.phoneNumber,});
}
