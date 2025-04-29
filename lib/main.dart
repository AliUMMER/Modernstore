import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/bloc/login/bloc/login_bloc.dart';
import 'package:modern_grocery/ui/splash_screen.dart';

String basePath = "http://192.168.171.42:4055/api";
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 917),
      minTextAdapt: true, 
      builder: (context, child) {
        return BlocProvider(
          create: (context) => LoginBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false, 
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
