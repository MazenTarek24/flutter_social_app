import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cupit/cupit.dart';
import 'package:social_app/layout/social_app/social_cupit/states.dart';
import 'package:social_app/model/social_model/user_model.dart';
import 'package:social_app/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/copmponents.dart';

class SocialChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>
      (
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
            condition: SocialCubit.get(context).users.length > 0,
            builder: (context)=> ListView.separated(
              itemBuilder: (context, index)=> buildChatItem(cubit.users[index], context),
              separatorBuilder:(context,index)=> myDivider(),
              itemCount: cubit.users.length,
            ),
          fallback:(context)=> Center( child: CircularProgressIndicator()),
        );

      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context ) =>InkWell(
    onTap: () {
      NavigateTo(context,
          ChatDetails(
            userModel: model,
      ));
    },
    child: Padding(
          padding: EdgeInsets.all(20.0),
      child :Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                '${model.image}'
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

                ],
              )
          ),
          SizedBox(
            width: 15.0,
          ),

        ],
      ),
      ),
      );
}

