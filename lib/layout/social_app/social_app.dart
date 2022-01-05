import 'package:conditional_builder/conditional_builder.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cupit/cupit.dart';
import 'package:social_app/layout/social_app/social_cupit/states.dart';
import 'package:social_app/model/social_model/user_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {

  SocialUserModel? usersModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()
        ..getComments(),
        // ..getChatMessages(receiverId: usersModel!.uid.toString()),

    child:BlocConsumer<SocialCubit ,SocialStates>
      (
        listener:(context , state){
          // if (state is SocialNewPostState) {
          //   NavigateTo(
          //     context,
          //     PostsScreen(),
          //   );
          // }
        },
        builder: (context , state)
     {

    var cubit = SocialCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cubit.titles[cubit.currentIndex],
        ),

      ),
      body: cubit.socialScreens[cubit.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cubit.currentIndex,
        onTap : (index){
          cubit.changeBottomNavBar(index);
        },
        items: [
        BottomNavigationBarItem(
            icon: Icon(IconBroken.Home),
          label: 'Home',
        ),
      BottomNavigationBarItem(
          icon: Icon(IconBroken.Chat),
     label: 'Chat',
      ),
          BottomNavigationBarItem(
            icon: Icon(IconBroken.Activity),
            label: 'Posts',
          ),
      BottomNavigationBarItem(
          icon: Icon(IconBroken.Setting),
     label: 'Setting',
      ),
      ],
      ),

    );

     }
     ),
    );

  }
}
