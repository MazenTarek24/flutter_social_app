abstract class SocialStates{
}

class SocialInitialState extends SocialStates{}

class SocialLoadingState extends SocialStates{}

class SocialNewPostState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
 final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialStates{}
class SocialGetAllUserSuccessState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates{
 final String error;

 SocialGetAllUserErrorState(this.error);

}

class changeSocialBottomNavBarStated extends SocialStates{}


class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}


//post states
class SocialUploadPostImageLoadingState extends SocialStates {}
class SocialUploadPostImageSuccessState extends SocialStates {}
class SocialUploadPostImageErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}
class SocialCreatePostSuccessState extends SocialStates {}
class SocialCreatePostErrorState extends SocialStates {}

class SocialRemovePostSuccessState extends SocialStates {}

//get posts
class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
 final String error;
 SocialGetPostsErrorState(this.error);
}
// get comments
class SocialGetCommentsSuccessState extends SocialStates{}
class SocialGetCommentsErrorState extends SocialStates{
 final String error;
 SocialGetCommentsErrorState(this.error);
}
//posts like
class SocialLikePostsSuccessState extends SocialStates{}
class SocialLikePostsErrorState extends SocialStates{
 final String error;
 SocialLikePostsErrorState(this.error);
}

class SocialCommentPostsSuccessState extends SocialStates{}
class SocialCommentPostsErrorState extends SocialStates{
 final String error;
 SocialCommentPostsErrorState(this.error);
}


// chat states
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{
 final String error;
 SocialSendMessageErrorState(this.error);
}

class SocialGetMessageSuccessState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{
 final String error;
 SocialGetMessageErrorState(this.error);
}
// chatImageState
class SocialChatImagePickedSuccessState extends SocialStates{

}
class SocialChatImagePickedErrorState extends SocialStates{

}

