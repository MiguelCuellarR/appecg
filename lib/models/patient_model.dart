// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<PatientModel> patientModelFromJson(String str) {
  final List<dynamic> jsonData = json.decode(str);
  List<PatientModel> patients = List<PatientModel>.from(jsonData.map((x) => PatientModel.fromJson(x)));
  return patients;
}

String patientModelToJson(List<PatientModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientModel {
    String document;
    String name;
    String ? middle_name;
    String last_name;
    String ? second_last_name;
    String age;
    String troponin_value;
    String photo;

    PatientModel({
        required this.document,
        required this.name,
        this.middle_name,
        required this.last_name,
        this.second_last_name,
        required this.age,
        required this.troponin_value,
        required this.photo,
    });

    factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        document: json["document"],
        name: json["name"],
        middle_name: json["middle_name"],
        last_name: json["last_name"],
        second_last_name: json["second_last_name"],
        age: json["age"],
        troponin_value: json["troponin_value"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "document": document,
        "name": name,
        "middle_name": middle_name,
        "last_name": last_name,
        "second_last_name": second_last_name,
        "age": age,
        "troponin_value": troponin_value,
        "photo": photo,
    };
}
