// To parse this JSON data, do
//
//     final petDetailsModel = petDetailsModelFromJson(jsonString);

import 'dart:convert';

PetDetailsModel petDetailsModelFromJson(String str) => PetDetailsModel.fromJson(json.decode(str));

String petDetailsModelToJson(PetDetailsModel data) => json.encode(data.toJson());

class PetDetailsModel {
    final int? status;
    final List<Datum>? data;
    final String? message;

    PetDetailsModel({
        this.status,
        this.data,
        this.message,
    });

    factory PetDetailsModel.fromJson(Map<String, dynamic> json) => PetDetailsModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    final int? id;
    final String? userName;
    final String? petName;
    final String? petType;
    final String? gender;
    final String? location;
    final String? image;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Datum({
        this.id,
        this.userName,
        this.petName,
        this.petType,
        this.gender,
        this.location,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userName: json["user_name"],
        petName: json["pet_name"],
        petType: json["pet_type"],
        gender: json["gender"],
        location: json["location"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "pet_name": petName,
        "pet_type": petType,
        "gender": gender,
        "location": location,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
