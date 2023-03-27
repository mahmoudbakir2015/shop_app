class LoginModel {
  bool? status;
  String? message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData({
    this.email,
    this.name,
    this.image,
    this.phone,
    this.credit,
    this.token,
    this.id,
    this.points,
  });
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    credit = json['credit'];
    token = json['token'];
    points = json['points'];
  }
}
