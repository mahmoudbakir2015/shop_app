class SettingsModel {
  bool? status;
  dynamic message;
  DataSettingModel? data;

  SettingsModel({
    this.status,
    this.message,
    this.data,
  });

  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? DataSettingModel.fromJson(json['data']) : null;
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

class DataSettingModel {
  String? about;
  String? terms;

  DataSettingModel({
    this.about,
    this.terms,
  });

  DataSettingModel.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about'] = about;
    data['terms'] = terms;
    return data;
  }
}
