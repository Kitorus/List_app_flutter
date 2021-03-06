import 'dart:convert';

import 'package:list_app/model/relation_str.dart';
import 'package:list_app/model/item.dart';
import 'package:list_app/model/item_tag.dart';


class AppData{
  static final AppData _appData = AppData._internal(); 
  final Set<Item> masterItemSet = {};
  final Set<ItemTag> masterItemTagSet = {};
  final Set<RelationStr> _masterRelationSet = {};
  final Map<ItemTag, List<Item>> masterRelationMap = {};

  static AppData get appData{return _appData;}

  //TODO: make asyng anc add loading screen
  AppData._internal() {
    String jsonStr = _getJsonString();

    Map<String, dynamic> decodedJson = jsonDecode(jsonStr);
    decodedJson['items'].forEach((i)=>masterItemSet.add(Item.fromJson(i)));
    decodedJson['tags'].forEach((t)=>masterItemTagSet.add(ItemTag.fromJson(t)));
    decodedJson['relations'].forEach((r)=>_masterRelationSet.add(RelationStr.fromJson(r)));

    _masterRelationSet.forEach((r){
      ItemTag k = masterItemTagSet.singleWhere((t)=>t.id == r.tag);
      Item v = masterItemSet.singleWhere((i)=>i.id == r.item);

      if (masterRelationMap.containsKey(k)){
        masterRelationMap[k].add(v);
      }else{
        masterRelationMap[k] = [v];
      }
    });

    masterItemTagSet.forEach((t)=>masterRelationMap.putIfAbsent(t, ()=>[]));

  }
  //TODO:replace with an api request
  String _getJsonString(){
    return ''' 
    
    {
    "items": [
        {
            "name": "Item number 0",
            "dateCreated": "2019-05-21T12:41:31.315638",
            "id": "Item number 02019-05-21 12:41:31.315638"
        },
        {
            "name": "Item number 1",
            "dateCreated": "2019-05-21T12:41:31.319628",
            "id": "Item number 12019-05-21 12:41:31.319628"
        },
        {
            "name": "Item number 2",
            "dateCreated": "2019-05-21T12:41:31.319628",
            "id": "Item number 22019-05-21 12:41:31.319628"
        }
    ],
    "tags": [
        {
            "dateCreated": "2019-05-21T12:41:31.319628",
            "dateLastEdited": "2019-05-21T12:41:31.319628",
            "name": "Tag number 0",
            "id": "Tag number 02019-05-21 12:41:31.319628"
        },
        {
            "dateCreated": "2019-05-21T12:41:31.319628",
            "dateLastEdited": "2019-05-21T12:41:31.319628",
            "name": "Tag number 1",
            "id": "Tag number 12019-05-21 12:41:31.319628"
        },
        {
            "dateCreated": "2019-05-21T12:41:31.319628",
            "dateLastEdited": "2019-05-21T12:41:31.319628",
            "name": "Tag number 2",
            "id": "Tag number 22019-05-21 12:41:31.319628"
        }
    ],
    "relations": [
        {
            "item": "Item number 02019-05-21 12:41:31.315638",
            "tag": "Tag number 02019-05-21 12:41:31.319628"
        },
        {
            "item": "Item number 12019-05-21 12:41:31.319628",
            "tag": "Tag number 02019-05-21 12:41:31.319628"
        },
        {
            "item": "Item number 22019-05-21 12:41:31.319628",
            "tag": "Tag number 02019-05-21 12:41:31.319628"
        },
        {
            "item": "Item number 02019-05-21 12:41:31.315638",
            "tag": "Tag number 12019-05-21 12:41:31.319628"
        },
        {
            "item": "Item number 22019-05-21 12:41:31.319628",
            "tag": "Tag number 12019-05-21 12:41:31.319628"
        }
    ]
}
    
    ''';
  }
}