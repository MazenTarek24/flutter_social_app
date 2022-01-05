import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cupit/cupit.dart';
import 'package:social_app/layout/social_app/social_cupit/states.dart';
import 'package:social_app/model/social_model/chat_model.dart';
import 'package:social_app/model/social_model/user_model.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetails extends StatelessWidget {

  SocialUserModel? userModel;

  ChatDetails({
    this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return Builder(
    //   builder: ( context) {
    //     SocialCubit.get(context).getMessages(
    //       receiverId: userModel?.uid,
    //     );
    return BlocProvider(create: (BuildContext context) =>
        SocialCubit()..getMessages(
            receiverId: userModel?.uId),

      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel?.image,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel?.name,
                    ),
                  ],
                ),
              ),
              body:  Column(
                  children: [
                    ConditionalBuilder(
                      condition: SocialCubit
                          .get(context)
                          .messages
                          .length > 0,
                      builder: (context) =>
                          Expanded(
                           child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var message = SocialCubit
                                          .get(context)
                                          .messages[index];

                                      if ( uId == message.senderId )
                                        return buildMyMessage(message);

                                      return buildMessage(message);
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                    itemCount: SocialCubit
                                        .get(context)
                                        .messages
                                        .length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ),
                      fallback: (context) =>
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receiverId: userModel?.uId,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text,
                                //  senderrId: SocialCubit.get(context).usersModel?.uid,
                                );
                                messageController.text = '';
                              },
                              minWidth: 1.0,
                              child: Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ]
              ),

          );
        },
      ),
    );
  }
      }

      Widget buildMessage(MessageModel model) =>
          Expanded(
         child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(
                    10.0,
                  ),
                  topStart: Radius.circular(
                    10.0,
                  ),
                  topEnd: Radius.circular(
                    10.0,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text(
                model.text.toString(),
              ),
            ),
         ),
          );

      Widget buildMyMessage(MessageModel model) =>
         Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(
                  .2,
                ),
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(
                    10.0,
                  ),
                  topStart: Radius.circular(
                    10.0,
                  ),
                  topEnd: Radius.circular(
                    10.0,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text(
                model.text.toString(),
              ),
            ),
          ),
          );

//      if(SocialCubit.get(context).pickPostImage !=null)
// Stack(
//  alignment: AlignmentDirectional.bottomCenter,
//  children: [
//   Align(
//     child: Stack(
//       alignment: AlignmentDirectional.topEnd,
//       children: [
//         Container(
//           height: 140.0,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(
//                   4.0
//               ),
//               topLeft: Radius.circular(
//                   4.0
//               ),
//             ),
//             image: DecorationImage(
//               image: (chatImage==null
//               ?'image not selected' : FileImage(chatImage)) as ImageProvider
//             ),
//           ),
//         )
//       ],
//     ),
//   )
//   ],
// ),