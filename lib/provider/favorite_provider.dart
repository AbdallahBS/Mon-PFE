import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import '../model/data_intership_model.dart';

class FavoriteProvider extends ChangeNotifier{
  List<DataIntershipModel> interships =[];
  final Box<DataIntershipModel> _box = Hive.box<DataIntershipModel>('favoritesBox');

  List<DataIntershipModel> get favorites => interships;
  FavoriteProvider() {
    _loadFavorites();
  }
  void _loadFavorites() {
    interships = _box.values.toList();
    notifyListeners();
  }
  void toggleFavorite(DataIntershipModel data){
    if(interships.contains(data)){
      _box.delete(data.name);
      interships.remove(data);
    }else{
      _box.put(data.name, data);
      interships.add(data);
    }
    notifyListeners();
    print(interships.length);
  }
  bool isExist(DataIntershipModel data){
    final isExist = interships.contains(data);
    return isExist;
  }
  static FavoriteProvider of(BuildContext context , {bool listen = true}){
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}