import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quan_ly_benh_nhan_sqlite/data/DatabaseHelper.dart';
import 'package:quan_ly_benh_nhan_sqlite/models/MedicalRecord.dart';
import 'package:quan_ly_benh_nhan_sqlite/models/Patient.dart';

class ManagerRecord extends StatefulWidget {
  const ManagerRecord({Key? key}) : super(key: key);

  @override
  State<ManagerRecord> createState() => _ManagerRecordState();
}

class _ManagerRecordState extends State<ManagerRecord> {
  late List<MedicalRecord> medicalRecords;
  late List<Patient> patients;
  late TextEditingController diagnosisController;
  int? selectedPatientId;

  @override
  void initState() {
    super.initState();
    diagnosisController = TextEditingController();

    // Initialize patients before accessing it
    patients = [];

    // Load patients before rendering the dropdown
    loadPatients().then((_) {
      // Check if there are patients available
      if (patients.isNotEmpty) {
        // Use the first patient as the initial value
        selectedPatientId = patients.first.id;
      } else {
        // If no patients, set to null or any other appropriate default value
        selectedPatientId = null;
      }

      // Load medical records after patients are loaded
      loadMedicalRecords();
    });
  }

  Future<void> loadMedicalRecords() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    medicalRecords = await dbHelper.getAllMedicalRecords();
    setState(() {}); // Refresh the UI after loading medical records
  }

  Future<void> loadPatients() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    patients = await dbHelper.getAllPatients();
    setState(() {}); // Refresh the UI after loading patients
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Manage Medical Records'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .pop(); // This will go back to the previous screen
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Dropdown for selecting patient
            DropdownButtonFormField<int>(
              value: selectedPatientId,
              items: patients.map((patient) {
                return DropdownMenuItem<int>(
                  value: patient.id,
                  child: Text(patient.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPatientId =
                      value; // The value is not nullable, and DropdownButtonFormField will handle null case
                });
              },
            ),

            const SizedBox(height: 16.0),
            // TextField for entering diagnosis
            TextField(
              controller: diagnosisController,
              decoration: InputDecoration(
                labelText: 'Diagnosis',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (selectedPatientId != null) {
                  MedicalRecord newRecord = MedicalRecord(
                    id: generateRandomId(),
                    diagnosis: diagnosisController.text,
                    patientId: selectedPatientId!,
                  );

                  await DatabaseHelper.instance.insertMedicalRecord(newRecord);
                  loadMedicalRecords();
                }
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 16.0),
            // ListView for displaying medical records
            Expanded(
              child: ListView.builder(
                itemCount: medicalRecords.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(medicalRecords[index].diagnosis),
                    subtitle:
                        Text('Patient ID: ${medicalRecords[index].patientId}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int generateRandomId() {
    // Generate a random ID for the medical record
    return Random().nextInt(100000);
  }
}
