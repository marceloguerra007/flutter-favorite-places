import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_routes.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus lugares favoritos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<PlacesProvider>(context, listen: false).loadPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting 
            ? Center(child: CircularProgressIndicator(),)
            : Consumer<PlacesProvider>(          
                builder: (ctx, placeProvider, childConsumer) => placeProvider.itemsCount == 0 ? Text('Nenhum local cadastrado')
                  : ListView.builder(
                      itemCount: placeProvider.itemsCount,
                      itemBuilder: (ctx, i) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(placeProvider.itemByIndex(i).image
                          )
                        ),
                        title: Text(placeProvider.itemByIndex(i).title),
                        subtitle: Text(placeProvider.itemByIndex(i).location!.address!),
                        onTap: (){},
                      )
                    )
              ),
        ),
      ),
    );
  }
}
