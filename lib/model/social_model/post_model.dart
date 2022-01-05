class PostModel {
  String? uid;
  dynamic name;
  String? Image;
  String? text;
  String? postImage;
  String? dateTime;

  PostModel(
      {
        required this.name,
       this.uid,
       this.Image,
         this.text,
        this.postImage,
        this.dateTime,
      });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    uid = json?['uid'];
    Image = json?['image'];
    text = json?['text'];
    postImage = json?['postImage'];
    dateTime = json?['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'name': name,
      'uid': uid,
      'Image': Image,
      'text': text,
      'postImage': postImage,
    };
  }
}
