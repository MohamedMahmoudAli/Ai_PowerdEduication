abstract class SocialRegisterState {}

class SocialRegisterInitialState extends SocialRegisterState {}

class SocialRegisterLoadingState extends SocialRegisterState {}

class SocialRegisterSuccessState extends SocialRegisterState {}

class SocialRegisterErrorState extends SocialRegisterState {
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialChangePasswordRegisterState extends SocialRegisterState {}

class SocialusercreateLoadingState extends SocialRegisterState {}

class SocialusercreateSuccessState extends SocialRegisterState {}
class SocialusercreateSuccessIfAdmin extends SocialRegisterState {}
class SocialusercreateSuccessIfUser extends SocialRegisterState {}
class SocialusercreateSuccessGrade extends SocialRegisterState {}

class SocialusercreateErrorState extends SocialRegisterState {
  final String error;

  SocialusercreateErrorState(this.error);
}
