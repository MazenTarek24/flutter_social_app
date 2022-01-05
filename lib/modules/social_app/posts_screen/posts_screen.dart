
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cupit/cupit.dart';
import 'package:social_app/layout/social_app/social_cupit/states.dart';
import 'package:social_app/model/social_model/user_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class PostsScreen extends StatelessWidget {

  var textEditingController = TextEditingController();

  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var postImage = SocialCubit.get(context).pickPostImage;

    return BlocConsumer<SocialCubit,SocialStates>
      (
        listener: (context,state){},
        builder:(context,state) {
          SocialUserModel? model = SocialCubit
              .get(context)
              .usersModel;

         return Scaffold(
            appBar: AppBar(

              leading: Icon(
                IconBroken.Arrow___Left_2,
              ),

              title: Text(
                'Create Post',
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    if (SocialCubit
                        .get(context)
                        .pickPostImage == null) {
                      SocialCubit.get(context).createPost(
                        text: textEditingController.text,
                        dateTime: now.toString(),
                      );
                    } else {
                      SocialCubit.get(context).createPostImage(
                        text: textEditingController.text,
                        dateTime: now.toString(),
                      );
                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialCreatePostLoadingState)
                    SizedBox(
                      height: 5.0,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                  '${model?.image}',
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          '${model?.name}',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),

                  TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind...',
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit
                      .get(context)
                      .pickPostImage != null )
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      4.0,
                                    ),
                                    topRight: Radius.circular(
                                      4.0,
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image: (postImage == null
                                        ? 'image not selected'.toString()
                                        : FileImage(
                                        postImage)) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Close_Square,
                                    size: 16.0,
                                  ),
                                ),
                                onPressed: () {
                                  SocialCubit.get(context).removeImagePost();
                                },

                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Add Photo',
                              ),

                              TextButton(
                                onPressed: () {},
                                child: Text(
                                    '# TAGS'
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
