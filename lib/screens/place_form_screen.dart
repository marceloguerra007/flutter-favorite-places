import 'dart:io';

import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage){
    setState(() {
      _pickedImage = pickedImage;      
    });
    
  }

  void _selectPosition(LatLng position){
    setState(() {
      _pickedPosition = position;      
    });
  }

  bool isValidForm(){
    return _titleController.text.isNotEmpty && _pickedImage != null || _pickedPosition != null;
  }

  void _submitForm(){
    if (!isValidForm())
      return;

    Provider.of<PlacesProvider>(
      context, 
      listen: false
    )
    .addPlace(_titleController.text, _pickedImage!, _pickedPosition!);
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(        
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Titulo'
                      ),
                      controller: _titleController,
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 10),
                    ImageInput(onSelectImage: this._selectImage),
                    SizedBox(height: 10),
                    LocationInput(onSelectPosition: this._selectPosition)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(            
            icon: Icon(Icons.add), 
            label: Text('Adicionar'),            
            //(backgroundColor: Theme.of(context).accentColor),
            onPressed: isValidForm() ? _submitForm : null
          ),
        ],
      ),
    );
  }
}
