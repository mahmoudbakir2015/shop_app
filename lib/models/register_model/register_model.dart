class RegisterModel {
  bool? status;
  String? message;
  DataModelReg? data;

  RegisterModel({
    this.status,
    this.message,
    this.data,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataModelReg.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataModelReg {
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;

  DataModelReg({
    this.name,
    this.email,
    this.phone,
    this.id,
    this.image,
    this.token,
  });

  DataModelReg.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['id'] = id;
    data['image'] = image;
    data['token'] = token;
    return data;
  }
}
