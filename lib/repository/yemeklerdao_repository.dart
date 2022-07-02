import 'dart:convert';

import 'package:alisveris_uygulamasi/entity/sepet_yemekler.dart';
import 'package:alisveris_uygulamasi/entity/sepet_yemekler_parent.dart';
import 'package:alisveris_uygulamasi/entity/yemekler.dart';
import 'package:alisveris_uygulamasi/entity/yemekler_parent.dart';
import 'package:http/http.dart' as http;

class YemeklerDaoRepository{

  List<Yemekler> parseYemekCevap(String cevap){
    return YemeklerParent.fromJson(json.decode(cevap)).yemekler;
  }

  List<SepetYemekler> parseSepetYemekCevap(String cevap){
    return SepetYemeklerParent.fromJson(json.decode(cevap)).sepet_yemekler;
  }
  
  Future<List<Yemekler>> tumYemekleriAl() async{
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await http.get(url);
    return parseYemekCevap(cevap.body);
  }

  Future<List<SepetYemekler>> sepettekiYemekleriGetir(String kullanici_adi) async{
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await http.post(url, body: veri);
    return parseSepetYemekCevap(cevap.body);
  }

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async{
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var eklemeVerisi = {
      "yemek_adi":yemek_adi,
      "yemek_resim_adi":yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat.toString(),
      "yemek_siparis_adet": yemek_siparis_adet.toString(),
      "kullanici_adi":kullanici_adi
    };

    var cevap = await http.post(url, body: eklemeVerisi);
  }

  Future<void> sepettenYemekSil(int sepet_yemek_id, String kullanici_adi) async{
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var silmeVerisi = {"sepet_yemek_id":sepet_yemek_id.toString(), "kullanici_adi":kullanici_adi };
    var cevap = await http.post(url, body: silmeVerisi);
  }
}