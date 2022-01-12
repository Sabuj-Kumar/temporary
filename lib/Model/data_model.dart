// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

DataModel registerModelFromJson(String str) =>
    DataModel.fromJson(json.decode(str));

String registerModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.email,
    this.username,
    this.password,
    this.confirmPassword,
    this.salary,
    this.latitude,
    this.longitude,
    this.id,
  });

  String? email;
  String? username;
  String? password;
  String? confirmPassword;
  double? salary;
  double? latitude;
  double? longitude;
  String? id;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      email: json["email"],
      username: json["username"],
      password: json["password"],
      confirmPassword: json["confirm_password"],
      salary: double.parse(json["salary"]),
      latitude: double.parse(json["latitude"]),
      longitude: double.parse(json["longitude"]),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "password": password,
        "confirm_password": confirmPassword,
        "salary": salary,
        "latitude": latitude,
        "longitude": longitude,
        "id": id,
      };
}
