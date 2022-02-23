class UserTweetModel {
  final String id;
  final String? tweet;
  final String? dateTime;

  UserTweetModel({this.tweet, this.dateTime,this.id=''});

  Map<String, dynamic> toJson() => {'id':id,'tweet': tweet, 'time': dateTime};

  static UserTweetModel fromJson(Map<String, dynamic> json) =>
      UserTweetModel(id: json['id'],tweet: json['tweet'], dateTime: json['time']);
}
