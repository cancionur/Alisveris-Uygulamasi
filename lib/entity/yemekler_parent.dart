import 'package:alisveris_uygulamasi/entity/yemekler.dart';

class YemeklerParent{
  List<Yemekler> yemekler;
  int success;

  YemeklerParent({required this.yemekler, required this.success});

factory YemeklerParent.fromJson(Map<String,dynamic> json){
  var jsonArray = json["yemekler"] as List;
  List<Yemekler> yemeklerListesi =
      jsonArray.map((nesne) => Yemekler.fromJson(nesne)).toList();

  return YemeklerParent(yemekler: yemeklerListesi, success: json["success"] as int);

}

}

