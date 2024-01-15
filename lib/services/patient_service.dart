import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:appecg/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class PatientService {

  /*Future<List<PatientModel>?> getAllPatients() async {
    final response = await http.get(Uri.parse(urlFlask));
    if(response.statusCode == 200){
      var json = response.body;
      return patientModelFromJson(json);
    }
    return null;
  }*/
 
  Future<dynamic> addPatient(data, imagePath) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$urlFlask/predict'),
    );
    request.fields.addAll(data);
    
    final file = File(imagePath);
    request.files.add(http.MultipartFile(
      'photo', 
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: basename(imagePath),
      contentType: MediaType('image', extension(imagePath))
    
    ));

    final response = await request.send();

    final httpResponse = await http.Response.fromStream(response);
    if (httpResponse.statusCode == 200) {
      Map<String, dynamic> jsonObject = json.decode(httpResponse.body);
      return jsonObject;
    } else {
      throw Exception('Error al enviar datos al servidor');
    }
  }

  Future<Uint8List> getImage(subFolder, imageName) async {
    String imageUrl = '$urlFlask/images/$subFolder/$imageName';

    http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Error loading image: ${response.statusCode}');
    }
  }

  Future<Uint8List> cascade(String document, String imagePath) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$urlFlask/cascade'),
    );
    var data = {'document': document};
    request.fields.addAll(data);
    
    final file = File(imagePath);
    request.files.add(http.MultipartFile(
      'photo', 
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: basename(imagePath),
      contentType: MediaType('image', extension(imagePath))
    ));
    
    final response = await request.send();
    final httpResponse = await http.Response.fromStream(response);
    if (httpResponse.statusCode == 200) {
      Uint8List byteData = httpResponse.bodyBytes;
      return byteData;
    } else {
      throw Exception('Error al enviar datos al servidor');
    }
  }

}