import 'package:alisveris_uygulamasi/entity/sepet_yemekler.dart';
import 'package:alisveris_uygulamasi/repository/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{

  SepetSayfaCubit():super(<SepetYemekler>[]);

  var yRepo = YemeklerDaoRepository();

  Future<void> sepettekiYemekleriYukle(String kullanici_adi) async{
    var liste = await yRepo.sepettekiYemekleriGetir(kullanici_adi);
    emit(liste);
  }

  Future<void> yemekSil(int sepet_yemek_id, String kullanici_adi) async{
    await yRepo.sepettenYemekSil(sepet_yemek_id, kullanici_adi);
    await sepettekiYemekleriYukle(kullanici_adi);
  }

}