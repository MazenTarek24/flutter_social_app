
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_app.dart';
import 'package:social_app/modules/social_app/social_app_login/state/state.dart';
import 'package:social_app/modules/social_app/social_register_screen/social_register_screen.dart';
import 'package:social_app/shared/components/copmponents.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';

import 'cubit/cubit.dart';

class SocialLogin extends StatelessWidget {


  var formKey = GlobalKey<FormState>();

  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create : (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit , SocialLoginState>
      (
        listener: (context , state){
          if (state is SocialErrorState) {
            showToast(
              message: state.error,
              state: ToastState.Error,
            );
          }
          if(state is SocialLoginSuccessfulState)
            {
              CasheHelper.saveData
                (
                  key: 'uId',
                  value: state.uId,
              ).then((value) {

                NavigateTo(context, SocialLayout());

              });
            }
        },
        builder: (context , state)=> Scaffold(
          appBar: AppBar(
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultTextField(
                          onSubmit: (value) {
                            print(value);
                          },
                          onTap: () {},
                          // textForUnValid: 'Enter your username',
                          controller: email,
                          type: TextInputType.emailAddress,
                          text: 'Username',
                          prefix: Icons.alternate_email),

                      SizedBox(
                        height: 15.0,
                      ),
                      defaultTextField(
                          onSubmit: (value) {
                            if (formKey.currentState?.validate() == true) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: email.text,
                                  password: password.text);
                            }
                          },
                          onTap: () {},
                          //    textForUnValid: 'Enter you password',
                          controller: password,
                          type: TextInputType.visiblePassword,
                          text: 'Password',
                          prefix: Icons.lock,
                          isPassword:SocialLoginCubit.get(context).isPassword,
                          suffix:SocialLoginCubit.get(context).suffix,
                          suffixFunction: () {
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          }),

                      SizedBox(
                        height: 30.0,
                      ),

                      state is!SocialLoadingState
                          ? defaultButton(
                        function: () {
                          print('button taped');
                          if (formKey.currentState?.validate() ==
                              true) {
                            SocialLoginCubit.get(context).userLogin(
                                email: email.text,
                                password: password.text);
                          } else {
                            print('else button');
                          }
                        },
                        text: 'Login',
                        color: Colors.indigo,
                      )
                          : Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo,
                        ),
                      ),

                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              NavigateTo(context,SocialRegisterScreen());
                            },
                            child: Text(
                                'Register Now'
                            ),

                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

    );

  }
}
