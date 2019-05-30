import 'package:Plinkd/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Plinkd/assets.dart';

class BaseModel {
  Map<String, Object> items = new Map();
  Map<String, Object> itemUpdate = new Map();
  Map<String, Map> itemUpdateList = new Map();

  BaseModel({Map items, DocumentSnapshot doc}) {
    if (items != null) {
      Map<String, Object> theItems = Map.from(items);
      this.items = theItems;
    }
    if (doc != null && doc.exists) {
      this.items = doc.data;
      this.items[OBJECT_ID] = doc.documentID;
    }
  }

  void put(String key, Object value) {
    items[key] = value;
    itemUpdate[key] = value;
  }

  void putInList(String key, Object value, bool add) {
    List itemsInList = items[key] == null ? List() : List.from(items[key]);
    if (add) {
      if (!itemsInList.contains(value)) itemsInList.add(value);
    } else {
      itemsInList.removeWhere((E) => E == value);
    }
    items[key] = itemsInList;

    Map update = Map();
    update[ADD] = add;
    update[VALUE] = value;

    itemUpdateList[key] = update;
  }

  void remove(String key) {
    items.remove(key);
    itemUpdate[key] = null;
  }

  String getObjectId() {
    Object value = items[OBJECT_ID];
    return value == null || !(value is String) ? "" : value.toString();
  }

  List getList(String key) {
    Object value = items[key];
    return value == null || !(value is List) ? new List() : List.from(value);
  }

  List<Object> addToList(String key, Object value, bool add) {
    List<Object> list = items[key];
    list = list == null ? new List<Object>() : list;
    if (add) {
      if (!list.contains(value)) list.add(value);
    } else {
      list.remove(value);
    }
    put(key, list);
    return list;
  }

  /* List<Map<String, Object>> addOnceToMap(
      String mapName, BaseModel bm, bool add) {
    List<Map<String, Object>> maps = items[mapName];
    maps = maps == null ? new List<Map<String, Object>>() : maps;
    bool canAdd = true;
    for (Map<String, Object> theMap in maps) {
      BaseModel model = new BaseModel(items: theMap);
      if (model.getString(OBJECT_ID) == (bm.getString(OBJECT_ID))) {
        canAdd = false;
        if (!add) maps.remove(theMap);
        break;
      }
    }
    if (canAdd && add) {
      maps.add(bm.items);
    }

    put(mapName, maps);
    return maps;
  }

  bool hasMap(String mapName, BaseModel bm) {
    List<Map<String, Object>> maps = items[mapName];
    maps = maps == null ? new List<Map<String, Object>>() : maps;
    for (Map<String, Object> theMap in maps) {
      BaseModel model = new BaseModel(items: theMap);
      if (model.getString(OBJECT_ID) == (bm.getString(OBJECT_ID))) {
        return true;
      }
    }
    return false;
  }*/

  Map getMap(String key) {
    Object value = items[key];
    return value == null || !(value is Map)
        ? new Map<String, String>()
        : Map.from(value);
  }

  Object get(String key) {
    return items[key];
  }

  String getString(String key) {
    Object value = items[key];

    return value == null || !(value is String) ? "" : value.toString();
  }

  double getDouble(String key) {
    Object value = items[key];
    return value == null || !(value is double) ? 0 : value;
  }

  bool getBoolean(String key) {
    Object value = items[key];
    return value == null || !(value is bool) ? false : value;
  }

  void justUpdate({onComplete, bool updateTime = true}) {
    String dName = items[DATABASE_NAME];
    //if(dName==null ||dName.isEmpty())return;

    String id = items[OBJECT_ID];

    if (updateTime) {
      items[UPDATED_AT] = FieldValue.serverTimestamp();
      items[TIME_UPDATED] = DateTime.now().millisecondsSinceEpoch;
    }

    Firestore db = Firestore.instance;
    db.collection(dName).document(id).setData(items).whenComplete(onComplete);
  }

  void updateItems({bool updateTime = true}) async {
    Future.delayed(Duration(seconds: 1), () async {
      String dName = items[DATABASE_NAME];
      String id = items[OBJECT_ID];

      DocumentSnapshot doc =
          await Firestore.instance.collection(dName).document(id).get();

      Map data = doc.data;
      for (String k in itemUpdate.keys) {
        data[k] = itemUpdate[k];
      }
      for (String k in itemUpdateList.keys) {
        Map update = itemUpdateList[k];
        bool add = update[ADD];
        var value = update[VALUE];

        List dataList = data[k] == null ? List() : List.from(data[k]);
        if (add) {
          if (!dataList.contains(value)) dataList.add(value);
        } else {
          dataList.removeWhere((E) => E == value);
        }
        data[k] = dataList;
      }

      if (updateTime) {
        data[UPDATED_AT] = FieldValue.serverTimestamp();
        data[TIME_UPDATED] = DateTime.now().millisecondsSinceEpoch;
      }

      doc.reference.setData(data);
    });
  }

  /*void updateItemxx(String key, value, {bool updateTime = true}) async {
    Future.delayed(Duration(seconds: 1), () async {
      String dName = items[DATABASE_NAME];
      String id = items[OBJECT_ID];

      DocumentSnapshot doc =
          await Firestore.instance.collection(dName).document(id).get();

      Map data = doc.data;
      data[key] = value;

      if (updateTime) {
        data[UPDATED_AT] = FieldValue.serverTimestamp();
        data[TIME_UPDATED] = DateTime.now().millisecondsSinceEpoch;
      }

      doc.reference.setData(data);
    });
  }



  void updateListNormallyx(String key, value, bool add,
      {bool updateTime = true}) async {
    Future.delayed(Duration(seconds: 1), () async {
      String dName = items[DATABASE_NAME];
      String id = items[OBJECT_ID];

      DocumentSnapshot doc =
          await Firestore.instance.collection(dName).document(id).get();
      Map data = doc.data;
      List list = data[key] == null ? List() : List.from(data[key]);
      if (add) {
        if (!list.contains(value)) list.add(value);
      } else {
        list.removeWhere((E) => E == value);
      }

      data[key] = list;

      if (updateTime) {
        data[UPDATED_AT] = FieldValue.serverTimestamp();
        data[TIME_UPDATED] = DateTime.now().millisecondsSinceEpoch;
      }

      doc.reference.setData(data);
    });
  }

  void updateListWithMyIdx(String key, bool add,
      {bool updateTime = true}) async {
    Future.delayed(Duration(seconds: 1), () async {
      String dName = items[DATABASE_NAME];
      String id = items[OBJECT_ID];

      DocumentSnapshot doc =
          await Firestore.instance.collection(dName).document(id).get();
      Map data = doc.data;
      List list = data[key] == null ? List() : List.from(data[key]);
      if (add) {
        if (!list.contains(userModel.getObjectId()))
          list.add(userModel.getObjectId());
      } else {
        list.removeWhere((E) => E == userModel.getObjectId());
      }

      data[key] = list;

      if (updateTime) {
        data[UPDATED_AT] = FieldValue.serverTimestamp();
        data[TIME_UPDATED] = DateTime.now().millisecondsSinceEpoch;
      }

      doc.reference.setData(data);
    });
  }*/

  void updateCountItem(String key, bool increase,
      {bool updateTime = true}) async {
    Future.delayed(Duration(seconds: 1), () async {
      String dName = items[DATABASE_NAME];
      String id = items[OBJECT_ID];

      DocumentSnapshot doc =
          await Firestore.instance.collection(dName).document(id).get();
      Map data = doc.data;
      var item = data[key] ?? 0;
      if (increase) {
        item = item + 1;
      } else {
        item = item - 1;
      }
      data[key] = item;

      if (updateTime) {
        data[UPDATED_AT] = FieldValue.serverTimestamp();
        data[TIME_UPDATED] = DateTime.now().millisecondsSinceEpoch;
      }

      doc.reference.setData(data);
    });
  }

  void deleteItem() {
    String dName = items[DATABASE_NAME];
    String id = items[OBJECT_ID];

    Firestore db = Firestore.instance;
    db.collection(dName).document(id).delete();
  }

  processSave(String name, bool addMyInfo) {
    items[DATABASE_NAME] = name;
    items[UPDATED_AT] = FieldValue.serverTimestamp();
    items[CREATED_AT] = FieldValue.serverTimestamp();
    items[TIME] = DateTime.now().millisecondsSinceEpoch;
    items[TIME_UPDATED] = DateTime.now().millisecondsSinceEpoch;
    if (name != (USER_BASE)) {
      if (addMyInfo) addMyDetails();
    }
  }

  void addMyDetails() {
    /*items[USER_ID] = userModel.getUserId();
    items[USER_IMAGE] = userModel.getString(USER_IMAGE);
    items[USERNAME] = userModel.getUserName();*/
  }

  void saveItem(String name, bool addMyInfo, {document, onComplete}) {
    processSave(name, addMyInfo);
    if (document == null) {
      Firestore.instance
              .collection(name)
              .add(items) /*.whenComplete((){
        onComplete();
      })*/
          ;
    } else {
      items[OBJECT_ID] = document;
      Firestore.instance
          .collection(name)
          .document(document)
          .setData(items)
          .whenComplete(() {
        onComplete();
      });
    }
  }

  void saveItemManually(String name, String document, bool addMyInfo,
      onComplete, bool isUpdating) {
    if (!isUpdating) {
      processSave(name, addMyInfo);
    } else {
      items[UPDATED_AT] = FieldValue.serverTimestamp();
      items[TIME_UPDATED] = DateTime.now().millisecondsSinceEpoch;
    }

    bool hasError = false;

    Firestore.instance
        .collection(name)
        .document(document)
        .setData(items)
        .timeout(Duration(seconds: 15), onTimeout: () {
      onComplete(null, "Error, Timeout");
      hasError = true;
    }).then((void _) {
      if (!hasError) onComplete(_, null);
    }, onError: (error) {
      onComplete(null, error);
    });
  }
}
