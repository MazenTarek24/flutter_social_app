
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/social_model/user_model.dart';
import 'package:social_app/modules/social_app/social_app_login/state/state.dart';


class SocialLoginCubit extends Cubit<SocialLoginState> {
 SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  late SocialUserModel loginModel;

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(SocialLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      print(value.user?.email);
      emit(SocialLoginSuccessfulState(value.user!.uid));

    }).catchError((error)
    {
      print(error.toString());
      emit(SocialErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(SocialChangePasswordVisibilityState());
  }
}