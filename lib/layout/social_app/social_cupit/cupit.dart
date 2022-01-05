
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/layout/social_app/social_cupit/states.dart';
import 'package:social_app/model/social_model/chat_model.dart';
import 'package:social_app/model/social_model/comments_model.dart';
import 'package:social_app/model/social_model/post_model.dart';
import 'package:social_app/model/social_model/user_model.dart';
import 'package:social_app/modules/social_app/chat_screen/chat_screen.dart';
import 'package:social_app/modules/social_app/feeds_screen/feeds_screen.dart';
import 'package:social_app/modules/social_app/posts_screen/posts_screen.dart';
import 'package:social_app/modules/social_app/setting_screen/setting_screen.dart';
import 'package:social_app/modules/social_app/social_app_login/social_login_screen.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/components/copmponents.dart';


class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);


  SocialUserModel? usersModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      usersModel = SocialUserModel.fromJson(value.data());
      print(usersModel?.name);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  List<Widget> socialScreens =
  [
    SocialFeedsScreen(),
    SocialChatScreen(),
    PostsScreen(),
    SettingsScreen(),
  ];

  List<String> titles =
  [
    'Feeds',
    'Chats',
    'Posts',
    'Settings',
  ];


  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    if (index == 1)
      getAllUser();
    // if (index == 3)
    //   emit(SocialNewPostState());
    currentIndex = index;
    emit(changeSocialBottomNavBarStated());
  }

  var picker = ImagePicker();

  File? profileImage;

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  // image_picker7901250412914563370.jpg

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  Future<void> uploadProfileImage({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) async {
    emit(SocialUserUpdateLoadingState());

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  Future<void> uploadCoverImage({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) async {
    emit(SocialUserUpdateLoadingState());

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

//   void updateUserImages({
//   @required String name,
//   @required String phone,
//   @required String bio,
// })
//   {
//     emit(SocialUserUpdateLoadingState());
//
//     if(coverImage != null)
//     {
//       uploadCoverImage();
//     } else if(profileImage != null)
//     {
//       uploadProfileImage();
//     } else if (coverImage != null && profileImage != null)
//     {
//
//     } else
//       {
//         updateUser(
//           name: name,
//           phone: phone,
//           bio: bio,
//         );
//       }
//   }
  void updateUser({
    @required String? name,
    @required String? phone,
    @required String? bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: usersModel?.email,
      cover: cover ?? usersModel?.cover,
      image: image ?? usersModel?.image,
      uId: usersModel?.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(usersModel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }


  File? pickPostImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      pickPostImage = File(pickedFile.path);
      emit(SocialUploadPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialUploadPostImageErrorState());
    }
  }

  void createPostImage({
    required String? text,
    required String? dateTime,

  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(pickPostImage!.path)
        .pathSegments
        .last}')
        .putFile(pickPostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
        print(error.toString() + "ggggggggg");
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print(error.toString() + "ffffffffff");
    });
  }

  void createPost({
    required String? text,
    required String? dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      text: text,
      dateTime: dateTime,
      Image: usersModel?.image,
      postImage: postImage ?? '',
      uid: usersModel?.uId,
      name: usersModel?.name,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removeImagePost() {
    pickPostImage = null;
    emit(SocialRemovePostSuccessState());
  }

  List<PostModel> Posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) =>
        {

          likes.add(value.docs.length),
          postsId.add(element.id),
          Posts.add(PostModel.fromJson(element.data())),

          emit(SocialGetPostsSuccessState()),
        }).catchError((onError) {

        });
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetPostsErrorState(onError.toString()));
    });
  }

  List<int> comments = [];

  void getComments() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comment').get().then((value) =>
        {

          comments.add(value.docs.length),
          // postsId.add(element.id),
          //  Posts.add(PostModel.fromJson(element.data())),

          emit(SocialGetCommentsSuccessState()),
        }).catchError((onError) {});
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetCommentsErrorState(onError.toString()));
    });
  }

  void likePosts(String postsId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId)
        .collection('likes')
        .doc(usersModel?.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((onError) {
      emit(SocialLikePostsErrorState(onError.toString()));
    });
  }

  void commentPosts({
    required String? postsId,
    required dynamic? uId,
    required dynamic? commentController,

  }) {
    CommentsModel model = CommentsModel(
      message: commentController,
      uId: uId,
      postId: postsId,

    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId)
        .collection('comment')
        .doc(usersModel?.uId)
        .set(model.toMap(),)
        .then((value) {
      emit(SocialCommentPostsSuccessState());
    }).catchError((onError) {
      emit(SocialCommentPostsErrorState(onError.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getAllUser() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uId)
          users.add(SocialUserModel.fromJson(element.data()));

        emit(SocialGetAllUserSuccessState());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetAllUserErrorState(onError.toString()));
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,

  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
      //  print("dsddddddddddddddddddddddddddddffffff" +usersModel?.uId );

    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessageSuccessState());
    });
  }

  File? pickChatImage;

  Future<void> getPickChatImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      pickChatImage = File(pickedFile.path);
      emit(SocialChatImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialChatImagePickedErrorState());
    }
  }

  // log out
  Future<void> signOut(context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      NavigateTo(context, SocialLogin());
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
