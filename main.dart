// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layouts/news-app/news-layout.dart';
import 'package:news_app/network/remout/cash-helper.dart';
import 'package:news_app/network/remout/dio-helper.dart';
import 'package:news_app/shared/bloc-observer.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:news_app/shared/cubit.dart';
import 'package:news_app/shared/states.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark= CashHelper.getData(key: 'isDark');
  runApp( MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
   MyApp(this. isDark, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>NewsCubit()..getBusiness()..getScience()..getSports()),
       BlocProvider( create: (BuildContext context) => AppCubit()..changeAppMode(),

       )],
      
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, Object? state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    primarySwatch: Colors.orange,
                    appBarTheme: AppBarTheme(
                      titleSpacing: 20.0,
                        backgroundColor: Colors.white,
                        backwardsCompatibility: false,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: HexColor('333739'),
                          statusBarBrightness: Brightness.light,
                        ),
                        titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                        iconTheme: IconThemeData(color: Colors.white)),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.orange,
                      unselectedItemColor: Colors.grey,
                      elevation: 20.0,
                      backgroundColor: HexColor('333739'),
                    ),
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ))),
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor('333739'),
                    primarySwatch: Colors.orange,
                    appBarTheme: AppBarTheme(
                      titleSpacing: 20.0,
                        backgroundColor: Colors.white,
                        backwardsCompatibility: false,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: HexColor('333739'),
                          statusBarBrightness: Brightness.light,
                        ),
                        titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                        iconTheme: IconThemeData(color: Colors.white)),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.orange,
                      unselectedItemColor: Colors.grey,
                      elevation: 20.0,
                      backgroundColor: HexColor('333739'),
                    ),
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ))),
                  
                themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
                home: Directionality(
                    textDirection: TextDirection.ltr, child: NewsLayout()),
              );
            }));
    
  }
}
