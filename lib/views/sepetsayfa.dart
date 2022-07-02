import 'package:alisveris_uygulamasi/cubits/sepetsayfa_cubit.dart';
import 'package:alisveris_uygulamasi/entity/sepet_yemekler.dart';
import 'package:alisveris_uygulamasi/views/anasayfa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var sepetimBosMu ;
var sepetToplami ;

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({Key? key}) : super(key: key);

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  void initState(){
    super.initState();
    context.read<SepetSayfaCubit>().sepettekiYemekleriYukle("OnurDeneme");
    sepetToplami = 0;
    sepetimBosMu = false;
  }

  @override
  Widget build(BuildContext context) {
    return !sepetimBosMu ? Scaffold(
      appBar: AppBar(
        title: Text("Sepetiniz",style: TextStyle(fontFamily: 'PtBold',fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        leading: IconButton(onPressed: (){
        Navigator.of(context).popUntil((route) => route.isFirst);
      }, icon: Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
          builder: (context,yemeklerListesi){

            sepetToplami = 0;
            for(var i = 0 ; i<yemeklerListesi.length;i++){
              sepetToplami += int.parse(yemeklerListesi[i].yemek_fiyat) * int.parse(yemeklerListesi[i].yemek_siparis_adet);
            }


            if(yemeklerListesi.isNotEmpty){
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: yemeklerListesi.length, // 012 indis üreticek
                      itemBuilder: (context, indeks){
                        var yemek = yemeklerListesi[indeks];

                        return Card(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                  backgroundColor: Colors.red[100],//second Color

                                ),
                              ),
                              Container(width: 30,),
                              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(

                                    children: [
                                      Text("${yemek.yemek_siparis_adet} Adet ${yemek.yemek_adi}"),
                                    ],
                                  ),
                                  Container(height: 40,),
                                  Text("Toplam Fiyat : ${int.parse(yemek.yemek_fiyat) * int.parse(yemek.yemek_siparis_adet)} ₺"),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.redAccent[200]),onPressed: (){

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Seçilen ürünü silmek istediğinize emin misiniz?"),
                                    action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: (){

                                        context.read<SepetSayfaCubit>().yemekSil(int.parse(yemek.sepet_yemek_id), "OnurDeneme");

                                        if(yemeklerListesi.length  == 1){
                                          setState((){
                                            sepetimBosMu =true;
                                            yemeklerListesi.clear();
                                          });
                                        }

                                      },
                                    ),
                                  ));

                                }, child: Text("Sil")),
                              ),
                            ],
                          ),
                        );
                      },

                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 15),
                    child: Container(width:300,height:50,color: Colors.transparent,
                        child: Text("Sepet Toplamı : ${sepetToplami} ₺",style: TextStyle(fontSize: 30),)),
                  ),



                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(minimumSize: Size(300, 40),primary: Colors.redAccent[400]),
                        onPressed: (){

                          for(var i = 0 ; i<yemeklerListesi.length;i++){
                            context.read<SepetSayfaCubit>().yemekSil(int.parse(yemeklerListesi[i].sepet_yemek_id), "OnurDeneme");
                          }
                          setState(()
                              {
                                sepetimBosMu = true;
                                yemeklerListesi.clear();
                              }
                          );

                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("Sepetiniz Onaylandı Tebrikler"),
                                  content: Text("Sepet toplamınız : ${sepetToplami} ₺"),
                                  actions:  [
                                    TextButton(child: Text("Tamam"),onPressed: (){
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                    }),
                                  ],);
                              }

                              );



                        }, child: Text("Sepeti Onayla")),
                  ),

                ],

              );

            }else {
              return Center(
                child:Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sepetiniz boş"),
                    Container(height: 50,),
                    Icon(Icons.local_mall,size: 100),
                  ],
                ),
              );
            }
          }
      ),

    ) :
    Scaffold(
      appBar: AppBar(
        title: Text("Sepetiniz",style: TextStyle(fontFamily: 'PtBold',fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        leading: IconButton(onPressed: (){
        Navigator.of(context).popUntil((route) => route.isFirst);
      }, icon: Icon(Icons.arrow_back)),),
      body: Center(
        child:Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sepetiniz boş"),
            Container(height: 50,),
            Icon(Icons.local_mall,size: 100),
          ],
        ),
      ),
    );

  }
}
