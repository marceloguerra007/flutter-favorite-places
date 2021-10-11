import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({ Key? key }) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    String _previewImageUrl = '';
    
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
              onPressed: (){},
            ),
            SizedBox(width: 10),
            ElevatedButton.icon(              
              icon: Icon(Icons.map), 
              label: Text('Selecione no Mapa'),              
              onPressed: (){}, 
            ),
          ],
        )
      ],
    );
  }
}