import 'package:alisveris_uygulamasi/cubits/anasayfa_cubit.dart';
import 'package:alisveris_uygulamasi/cubits/sepetsayfa_cubit.dart';
import 'package:alisveris_uygulamasi/cubits/yemekdetaysayfa_cubit.dart';
import 'package:alisveris_uygulamasi/views/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => YemekDetaySayfaCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
        BlocProvider(create: (context) => AnasayfaCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}

