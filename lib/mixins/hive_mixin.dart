import 'package:hive_ce/hive.dart';

mixin HiveMixin<T> {
  Future<Box<T>?> openBox(String boxName) async {
    try {
      return await Hive.openBox<T>(boxName);
    } catch (error) {
      return null;
    }
  }
}
