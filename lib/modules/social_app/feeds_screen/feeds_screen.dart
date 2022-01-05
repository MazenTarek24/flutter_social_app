

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cupit/cupit.dart';
import 'package:social_app/layout/social_app/social_cupit/states.dart';
import 'package:social_app/model/social_model/comments_model.dart';
import 'package:social_app/model/social_model/post_model.dart';
import 'package:social_app/model/social_model/user_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialFeedsScreen extends StatelessWidget {

  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    SocialUserModel? model = SocialCubit.get(context).usersModel;

    return BlocConsumer<SocialCubit,SocialStates>
      (
        listener:(context,state){},
      builder: (context,state) {
          CommentsModel? model;

        return ConditionalBuilder(
            condition: SocialCubit.get(context).Posts.length > 0,
            builder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5.0,
                        margin: EdgeInsets.all(0.9),

                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image: NetworkImage(
                                "https://image.freepik.com/free-vector/business-teamwork-people-standing-brainstorm-discussing_40876-2657"
                                    ".jpg",
                              ),
                              fit: BoxFit.cover,
                              height: 200.0,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  9.0),
                              child: Text(
                                'communicate with friends',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildPostItem(SocialCubit.get(context).Posts[index], context ,index),
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: 8.0,
                            ),
                        itemCount: SocialCubit.get(context).Posts.length,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                    ]
                ),
              );
            },
            fallback: (context) => Center (child:CircularProgressIndicator()),
        );
      }
  );
}
Widget buildPostItem(PostModel model,context , index) {
  var userModel = SocialCubit.get(context).usersModel;
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${userModel?.image}',
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Row(
                        children:
                        [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption
                            ?.copyWith(
                          height: 1.4,
                        ),
                      ),

                    ],
                  )
              ),
              SizedBox(
                width: 15.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
                onPressed: () {},
              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme
                .of(context)
                .textTheme
                .subtitle1,
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     bottom: 10,
          //     top: 5,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 "#software",
          //                 style: Theme
          //                     .of(context)
          //                     .textTheme
          //                     .caption
          //                     ?.copyWith(
          //                   color: Colors.blue,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 "#software",
          //                 style: Theme
          //                     .of(context)
          //                     .textTheme
          //                     .caption
          //                     ?.copyWith(
          //                   color: Colors.blue,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: 15.0,
              ),
              child: Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${model.postImage}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                      '${SocialCubit.get(context).likes[index]}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).comments[index]}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 4.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'type your message here ...',
                      ),
                    ),
                  ),
                ),
                // Container(
                //   width: 45.0,
                //   height: 25.0,
                //   color: Colors.red[400],
                //   child:
                  MaterialButton(
                    onPressed: () {
                     SocialCubit.get(context).commentPosts(
                      postsId: SocialCubit.get(context).postsId[index]
                     ,uId:model.uid,
                     commentController: commentController.text );
                    },
                    minWidth: .1,
                    child: Icon(
                      IconBroken.Send,
                      size: 20.0,
                      color: Colors.amber,
                    ),
                  ),
              //  ),
              ]
          ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption,
                    ),
                  ],
                ),
                onTap: () {
                  SocialCubit.get(context).likePosts(SocialCubit.get(context).postsId[index]);
                },
              ),
          SizedBox(
            height: 5.0,
          ),
            ],
          ),

      ),
  );

}

}


