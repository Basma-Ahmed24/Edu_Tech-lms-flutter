abstract class ProfileStates {
}
class ProfileInitialState extends ProfileStates{}
class ProfileLoadingState extends ProfileStates{}
class ProfileSucessState extends ProfileStates{

}
class ProfileErorrState extends ProfileStates{
  final  erorr;
  ProfileErorrState(this.erorr);
}