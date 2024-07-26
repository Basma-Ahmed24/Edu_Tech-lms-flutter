

abstract class AuthStates {
}
class AuthInitialState extends AuthStates{}
class AuthLoadingState extends AuthStates{}
class AuthSucessState extends AuthStates{

}
class AuthErorrState extends AuthStates{
  final  erorr;
  AuthErorrState(this.erorr);
}
class LoadEgyCitysJsonState extends AuthStates{}
class GetTheValueState extends AuthStates{}