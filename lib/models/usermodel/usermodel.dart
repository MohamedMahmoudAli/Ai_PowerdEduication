class SocialUserModel {
  String? name;
  String? email;
  String? uId;
  bool? isAdmin;

  SocialUserModel(
      {this.name,
      this.email,
      this.uId,
      this.isAdmin,
    });
  SocialUserModel.fromjson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    uId = json['uId'];
    isAdmin = json['isAdmin'];

  }
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
      'uId': uId,
    };
  }
}
