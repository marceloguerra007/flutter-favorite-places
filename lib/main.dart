import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

import 'screens/place_form_screen.dart';
import 'screens/places_list_screen.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PlacesProvider(),
      child: MaterialApp(
          title: 'Lugares Favoritos',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: PlacesListScreen(),
          routes: {
            AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
    );
  }
}
