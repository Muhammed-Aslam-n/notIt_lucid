class UserDetailsModel {
  final String id;
  final String? name;
  final String? phoneNumber;

  UserDetailsModel({this.id='', this.name, this.phoneNumber});


  Map<String, dynamic> toJson() => {'id':id,'userName': name,'phoneNumber':phoneNumber};

  static UserDetailsModel fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(id: json['id'], name: json['userName'],phoneNumber: json['phoneNumber']);
}
