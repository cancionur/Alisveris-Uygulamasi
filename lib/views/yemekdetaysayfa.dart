import 'package:alisveris_uygulamasi/cubits/sepetsayfa_cubit.dart';
import 'package:alisveris_uygulamasi/cubits/yemekdetaysayfa_cubit.dart';
import 'package:alisveris_uygulamasi/entity/sepet_yemekler.dart';
import 'package:alisveris_uygulamasi/entity/yemekler.dart';
import 'package:alisveris_uygulamasi/views/sepetsayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekDetaySayfa extends StatefulWidget {

  Yemekler yemek;
  YemekDetaySayfa({required this.yemek});

  @override
  State<YemekDetaySayfa> createState() => _YemekDetaySayfaState();
}

class _YemekDetaySayfaState extends State<YemekDetaySayfa> {


  void initState(){
    super.initState();
    context.read<SepetSayfaCubit>().sepettekiYemekleriYukle("OnurDeneme");
  }

  int yemek_siparis_adet = 1;
  var tiklama_hakki = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Yemek Detayı",style: TextStyle(fontFamily: 'PtBold',fontSize: 25),),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Container(height: 40,),
            Image.network(width: 200,height: 200, "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            Container(height: 40,),
            Text("${widget.yemek.yemek_adi}",style: TextStyle(fontSize: 35,fontFamily: 'PtBold',fontWeight: FontWeight.bold),),
            Container(height: 15,),
            Text("${widget.yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 20),),
            Container(height: 100,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                IconButton(iconSize:35,onPressed: (){
                  setState(() {
                    if(yemek_siparis_adet == 1){
                      return;
                    }
                    yemek_siparis_adet--;
                  });
                }, icon: Icon(Icons.remove_circle_outline)),

                Text("${yemek_siparis_adet}",style: TextStyle(fontSize: 25),),

                IconButton(iconSize:35,onPressed: (){
                  setState(() {
                    yemek_siparis_adet++;
                  });
                }, icon: Icon(Icons.add_circle_outline_outlined)),

              ],
            ),
          Container(height: 60,),

          BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
              builder: (context,yemeklerListesi){
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: Size(300, 40),primary: Colors.redAccent[400]),
                    onPressed: (){

                      for(var i = 0; i<yemeklerListesi.length;i++)
                  {
                    if(widget.yemek.yemek_adi == yemeklerListesi[i].yemek_adi){
                      tiklama_hakki = 0;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),
                        content: Text("Bu ürün çoktan sepete eklendi!"),
                      ));
                      return;
                    }
                  }

                  if(tiklama_hakki == 1){
                    context.read<YemekDetaySayfaCubit>().YemekEkle(
                        widget.yemek.yemek_adi,
                        widget.yemek.yemek_resim_adi,
                        int.parse(widget.yemek.yemek_fiyat),
                        yemek_siparis_adet,
                        "OnurDeneme");

                    tiklama_hakki--;

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 2),
                      content: Text("Ürünü başarıyla sepete eklediniz!\nSepete Gitmek ister misiniz?"),
                      action: SnackBarAction(
                        label: "Evet",
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa()));
                        },
                      ),
                    ));

                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),
                      content: Text("Bu ürün çoktan sepete eklendi!"),
                    ));
                  }
                }, child: Text("Sepete Ekle"));


              }),

          ],
        ),
      ),

    );
  }
}
