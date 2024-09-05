import 'package:hive/hive.dart';
part 'data_intership_model.g.dart'; // Generated file


@HiveType(typeId: 1) // Unique ID for this type
class DataIntershipModel extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String location;

  @HiveField(2)
  String description;
  @HiveField(3)
  String shortdescription;
  @HiveField(4)
  String sujet;

  @HiveField(5)
  List<String> images;


  @HiveField(6)
  String linkDin;

  @HiveField(7)
  String pfeBook2023;

  @HiveField(8)
  String pfeBook2024;
  @HiveField(9)
  String web;
  @HiveField(10)
  String email;
  @HiveField(11)
  String long;
  @HiveField(12)
  String lat;




  DataIntershipModel({
    required this.name,
    required this.location,
    required this.description,
    required this.shortdescription,
    required this.sujet,
    required this.images,
    required this.linkDin,
    required this.pfeBook2023,
    required this.pfeBook2024,
    required this.web,
    required this.email,
    required this.long,
    required this.lat,
  });

  factory DataIntershipModel.fromJson(Map<String, dynamic> json) {
    return DataIntershipModel(
      name: json['name'],
      location: json['location'],
      shortdescription: json['shortdescription'],
      description: json['description'],
      sujet: json['sujet'] ?? '',
      images: List<String>.from(json['Images']),
      linkDin: json['linkDin'],
      pfeBook2023: json['pfeBook2023'],
      pfeBook2024: json['pfeBook2024'],
      web: json['web'],
      email: json['email'],
      long: json['long'],
      lat: json['lat'],
    );
  }
}
