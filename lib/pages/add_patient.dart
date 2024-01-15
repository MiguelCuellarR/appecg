import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:appecg/pages/prediction.dart';
import 'package:appecg/services/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:io';

class AddPatient extends StatefulWidget {
  const AddPatient({super.key});

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  
  final _formKey = GlobalKey<FormState>();
  String ? document;
  String ? firstName;
  String ? secondName;
  String ? firstSurname;
  String ? secondSurname;
  String ? troponinValue;
  String ? age;
  String ? imagePath;
  bool _loading = false;
  Uint8List  ? displayedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text(
          'ECG Data',
          style: TextStyle(
            color: Colors.white
          ),),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child:  
          SingleChildScrollView(
          child: Form(
            key: _formKey,

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Document'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a identity document';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        document = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      firstName = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Middle Name (Optional)'),
                    onSaved: (value) {
                      secondName = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a last name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      firstSurname = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Second Last Name (Optional)'),
                    onSaved: (value) {
                      secondSurname = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the age';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      age = value ?? "0";
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Troponin Value'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter troponin value';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      troponinValue = value ?? "0.0";
                    },
                  ),
                  
                  const SizedBox(height: 10,),
                  displayedImage != null ? Image.memory(displayedImage!, height: 300) : const Text(''),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.blueGrey[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          )
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                            size: 25
                          ),
                          onPressed: () {
                            _pickImageFromCamera();
                          }
                        ),
                      ),
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.blueGrey[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          )
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.collections,
                            color: Colors.white,
                            size: 25
                          ),
                          onPressed: () {
                            _pickImageFromGallery();
                          }
                        ),
                      ),
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.blueGrey[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          )
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.crop,
                            color: Colors.white,
                            size: 25
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate() && displayedImage != null) {
                              _formKey.currentState!.save();
                              setState(() {
                                _loading = true;
                              });
                              Uint8List bytes = await PatientService().cascade(document!, imagePath!);
                              setState(() {
                                displayedImage = bytes;
                                _saveModifiedImage();
                                _loading = false;
                              });
                            }
                          }
                        ),
                      ),
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (displayedImage != null){
                                setState(() {
                                  _loading = true;
                                });
                                _formKey.currentState!.save();
                                try {
                                  var result = await PatientService().addPatient({
                                      'document': document ?? "",
                                      'name': firstName ?? "",
                                      'middle_name': secondName ?? "",
                                      'last_name': firstSurname ?? "",
                                      'second_last_name': secondSurname ?? "",
                                      'age': age ?? "0",
                                      'troponin_value': troponinValue ?? "0.0"
                                    }
                                  , imagePath);
                                  
                                  int classValue = result['class'];
                                  String urlImageGradCam = result['url_image_grad_cam'];
                                  String urlImage = result['url_image'];

                                  setState(() {
                                    _loading = false;
                                  });
                                  
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Prediction(
                                        classResult: classValue,
                                        subFolder: document!,
                                        urlImageGradCam: path.basename(urlImageGradCam),
                                        urlImage: path.basename(urlImage)
                                      ),
                                    ),
                                  );
                                } catch (error) {
                                  throw Exception('Error with charging indicator $error');
                                }
                              } 
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ),
        )
      )
    );
  }

  Future _pickImageFromGallery() async {
    final chosenImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (chosenImage != null){
      final imageBytes = await chosenImage.readAsBytes();
      setState(() {
        displayedImage = imageBytes;   
        imagePath = chosenImage.path;
      });
    }
  }

  Future _pickImageFromCamera() async {
    final chosenImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (chosenImage != null){
      final imageBytes = await chosenImage.readAsBytes();
      setState(() {
        displayedImage = imageBytes;   
        imagePath = chosenImage.path;
      });
    }
  }

  Future<void> _saveModifiedImage() async {
    if (displayedImage != null) {
      await File(imagePath!).writeAsBytes(displayedImage!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Imagen guardada en $imagePath'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay ninguna imagen para guardar.'),
        ),
      );
    }
  }

}