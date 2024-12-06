import 'package:fahrtenbuch/entities/ride.dart';
import 'package:hive/hive.dart';

class Database {
  List rideList = [];

  final myBox = Hive.box('myBox');

  void loadData(){
    rideList = myBox.get('RIDELIST');
  }

  void updateData(){
    myBox.put('RIDELIST', rideList);
  }
}