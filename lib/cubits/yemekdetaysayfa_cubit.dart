import 'package:alisveris_uygulamasi/repository/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekDetaySayfaCubit extends Cubit<void>{

  YemekDetaySayfaCubit():super(0);

  var yRepo = YemeklerDaoRepository();

  Future<void> YemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async{
    await yRepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }


}