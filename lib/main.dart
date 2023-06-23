import 'package:admin_panel/helpers/firebase_options/firebase_options.dart';
import 'package:admin_panel/provider/provider.dart';
import 'package:admin_panel/provider1/provider.dart';
import 'package:admin_panel/screens/homepage/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await  Firebase.initializeApp(options:DefaultFirebaseConfig.platformOptions);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProviderr>(
      create: (context)=>AppProviderr(),
        //..getUserListFun()
      //  ..getCategoriesListFun(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Panel',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}


