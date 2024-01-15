import 'package:appecg/models/patient_model.dart';
import 'package:appecg/pages/add_patient.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<PatientModel>? patients;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getRecord();  
  }

  getRecord() async {
    /*patients = await PatientService().getAllPatients();
    if (patients != null){
      setState(() {
        isLoaded = true;
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text('ECG Data'),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemCount: patients?.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text("${patients![index].name} ${patients![index].middle_name ?? ""} ${patients![index].last_name} ${patients![index].second_last_name ?? ""}"),
              subtitle: Text("Documento: ${patients![index].document}\n" 
                "Edad: ${patients![index].age}\n"
                "Troponina: ${patients![index].troponin_value}\n"
                "Archivo: ${patients![index].photo}"), 
              /*trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: (){}, 
                    icon: const Icon(Icons.edit)
                  ),
                  IconButton(
                    onPressed: (){}, 
                    icon: const Icon(Icons.delete)
                  )
                ],
              ),*/
            );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const AddPatient())
          ).then((data) {
            if (data != null) {
              getRecord();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
      

  }
}