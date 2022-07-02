import 'package:alisveris_uygulamasi/entity/yemekler.dart';
import 'package:alisveris_uygulamasi/repository/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{

  AnasayfaCubit():super(<Yemekler>[]);

  var yRepo = YemeklerDaoRepository();

  Future<void> yemekleriYukle() async{
    var liste = await yRepo.tumYemekleriAl();
    emit(liste);
  }


}