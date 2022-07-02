import 'package:alisveris_uygulamasi/entity/sepet_yemekler.dart';

class SepetYemeklerParent{
  List<SepetYemekler> sepet_yemekler;
  int success;

  SepetYemeklerParent({required this.sepet_yemekler, required this.success});

  factory SepetYemeklerParent.fromJson(Map<String,dynamic> json){
    var jsonArray = json["sepet_yemekler"] as List;
    List<SepetYemekler> sepetYemekler = jsonArray.map((nesne) => SepetYemekler.fromJson(nesne)).toList();

    return SepetYemeklerParent(sepet_yemekler: sepetYemekler, success: json["success"] as int);

  }
}