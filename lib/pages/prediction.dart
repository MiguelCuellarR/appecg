import 'dart:typed_data';
import 'package:appecg/services/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Prediction extends StatefulWidget {
  final int classResult;
  final String subFolder;
  final String urlImageGradCam;
  final String urlImage;

  const Prediction({
    Key? key,
    required this.classResult,
    required this.subFolder,
    required this.urlImageGradCam,
    required this.urlImage,
  }) : super(key: key);

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  Uint8List  ? displayedImage;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prediction',
          style: TextStyle(
            color: Colors.white
          ),),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.classResult == 0 ? 'Sick' : 'Healthy',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey[700],
                ),
                child: InkResponse(
                  onTap: () {
                    _updateImage(widget.subFolder, widget.urlImage);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey[700],
                ),
                child: InkResponse(
                  onTap: () {
                    _updateImage(widget.subFolder, widget.urlImageGradCam);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'GradCam',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              displayedImage != null
                ? Image.memory(displayedImage!, height: 200)
                : const Text('Please select an option'),
            ],
          ),
        ),
      )
    );
  }

  void _updateImage(String subFolder, String imageUrl) {
    setState(() {
      _loading = true;
    });
    PatientService().getImage(subFolder, imageUrl).then((Uint8List imageData) {
      setState(() {
        displayedImage = imageData;
        _loading = false;
      });
    }).catchError((error) {
      throw Exception('Error loading image: $error');
    }) ;
  }
}