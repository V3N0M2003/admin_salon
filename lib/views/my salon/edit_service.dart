import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditServicePage extends StatefulWidget {
  final String documentId;

  const EditServicePage({required this.documentId});

  @override
  _EditServicePageState createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  String? _selectedGender;
  String? _selectedCategory;
  late TextEditingController _priceController;
  // ignore: unused_field
  late File _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _getServiceDetails();
  }

  Future<void> _getServiceDetails() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('services')
          .doc(widget.documentId)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = data['name'];
          _descriptionController.text = data['description'];
          _selectedGender = data['gender'];
          _selectedCategory = data['category'];
          _priceController.text = data['price'].toString();
        });
      }
    } catch (e) {
      print('Error getting service details: $e');
    }
  }

  Future<void> _updateService() async {
    try {
      /*String imageName = _nameController.text.replaceAll(' ', '_');
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$imageName');
      UploadTask uploadTask = storageReference.putFile(_selectedImage);
      TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
*/
      await FirebaseFirestore.instance
          .collection('services')
          .doc(widget.documentId)
          .update({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'gender': _selectedGender,
        'category': _selectedCategory,
        'price': num.parse(_priceController.text),
        //'imageUrl': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Service updated successfully')));
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Service updated successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    } catch (e) {
      print('Error updating service: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating service')));
    }
  }

  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Service'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
                items: ['Male', 'Female', 'Unisex']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: ['Hair cut', 'Facial', 'Beard', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              SizedBox(height: 20),
              /*ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _selectImage(ImageSource.gallery);
              },
              child: Text('Select Image from Gallery'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _selectImage(ImageSource.camera);
              },
              child: Text('Take Picture'),
            ),
            Image.file(
              _selectedImage,
              height: 150,
              width: 150,
            ),*/
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: _updateService,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
