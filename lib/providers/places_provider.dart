import 'dart:io';
import 'dart:math';

import 'package:favorite_places/utils/db_util.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';

class PlacesProvider with ChangeNotifier{

  List<Place> _items = [];

  List<Place> get items{
    return [..._items];
  }

  Future<void> loadPlaces() async{
    final dataList = await DbUtil.getData('PLACES');

    _items = dataList.map(
      (item) => Place(
        id: item['id'],
        title: item['title'],
        image: File(item['image']),
        location: null
      )
    ).toList();

    notifyListeners();
  }

  int get itemsCount{
    return _items.length;
  }

  Place itemByIndex(int index){
    return _items[index];
  }

  void addPlace(String title, File image){
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: null,
      image: image
    );

    _items.add(newPlace);
    
    DbUtil.insert(
      'PLACES', 
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path
      }
    );
    
    notifyListeners();
  }
}