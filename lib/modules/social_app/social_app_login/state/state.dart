
abstract class SocialLoginState {}

class SocialLoginInitialState extends SocialLoginState {}
class SocialLoginSuccessfulState extends SocialLoginState {

final String uId;
  SocialLoginSuccessfulState(this.uId);

}
class SocialLoadingState extends SocialLoginState {}
class SocialErrorState extends SocialLoginState {
  final String error;

  SocialErrorState(this.error);
}
class SocialChangePasswordVisibilityState extends SocialLoginState {}
