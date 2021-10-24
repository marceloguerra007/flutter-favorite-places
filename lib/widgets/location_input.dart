import 'package:favorite_places/screens/map_screen.dart';
import 'package:favorite_places/utils/location_util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;

  const LocationInput({required this.onSelectPosition});

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl = '';

  void _showPreview(double latitude, double longitude){
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: latitude, 
      longitude: longitude
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude!, locData.longitude!);
      
      if (locData != null)
        widget.onSelectPosition(locData);      
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async{
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen()
      )
    );

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);

    // ignore: unnecessary_null_comparison
    if (selectedPosition != null)
      widget.onSelectPosition(selectedPosition);
  }
  
  @override
  Widget build(BuildContext context) {    
    
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey
            )
          ),
          child: _previewImageUrl == '' 
          ? Text('Nenhuma localização definida')
          : Image.network(
            _previewImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(              
              icon: Icon(Icons.location_on), 
              label: Text('Localização Atual'),
              onPressed:_getCurrentUserLocation ,
            ),
            SizedBox(width: 10),
            ElevatedButton.icon(              
              icon: Icon(Icons.map), 
              label: Text('Selecione no Mapa'),              
              onPressed: _selectOnMap, 
            ),
          ],
        )
      ],
    );
  }
}