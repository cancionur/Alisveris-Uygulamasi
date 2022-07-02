import 'dart:async';

import 'package:alisveris_uygulamasi/cubits/anasayfa_cubit.dart';
import 'package:alisveris_uygulamasi/entity/yemekler.dart';
import 'package:alisveris_uygulamasi/views/sepetsayfa.dart';
import 'package:alisveris_uygulamasi/views/yemekdetaysayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {


  void initState(){
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bazaar",style: TextStyle(fontFamily: 'PtBold',fontSize: 40),),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          Row(
            children: [
              TextButton.icon(     // <-- TextButton
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa()));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 20.0,
                ),
                label: Text("Sepete Git",style: TextStyle(fontFamily: 'PtBold',fontSize: 12,color: Colors.white)),
              ),
            ],
          )

        ],
      ),
      body: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
          builder: (context,yemeklerListesi){
            if(yemeklerListesi.isNotEmpty){
              return ListView.builder(
                itemCount: yemeklerListesi.length, // 012 indis üreticek
                itemBuilder: (context, indeks){
                  var yemek = yemeklerListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => YemekDetaySayfa(yemek: yemek)))
                          .then((value) {context.read<AnasayfaCubit>().yemekleriYukle();} );
                    },
                    child: Card(
                      child: Row(
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                              backgroundColor: Colors.redAccent[400],//second Color

                            ),
                          ),
                          Container(width: 30,),
                          Text("${yemek.yemek_adi}   -   ${yemek.yemek_fiyat} TL",style: TextStyle(fontFamily: 'PtRegular',fontSize: 22),),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(Icons.arrow_forward_ios,size: 15),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sayfa Yükleniyor"),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          }
      ),
    );
  }
}
