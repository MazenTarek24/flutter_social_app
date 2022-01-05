class CommentsModel {
  dynamic message;
  String? uId;
  String? postId;

  CommentsModel({
    this.message,
    this.uId,
    this.postId,

  });

  CommentsModel.fromJson(Map<String , dynamic> json)
  {
    message = json['message'];
    uId = json['uId'];
    postId = json['postId'];

  }

  Map<String , dynamic> toMap()
  {
    return {
      'message': message,
      'uid':uId,
      'postId':postId,

    };
  }
}