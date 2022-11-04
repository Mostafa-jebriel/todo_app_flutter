import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/state.dart';

import 'Layout/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (c,s){},
        builder: (c,s){
          var cubit = AppCubit.get(c);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                /// NAME         SIZE  WEIGHT  SPACING
                /// headline1    96.0  light   -1.5
                /// headline2    60.0  light   -0.5
                /// headline3    48.0  regular  0.0
                /// headline4    34.0  regular  0.25
                /// headline5    24.0  regular  0.0
                /// headline6    20.0  medium   0.15
                /// subtitle1    16.0  regular  0.15
                /// subtitle2    14.0  medium   0.1
                /// body1        16.0  regular  0.5   (bodyText1)
                /// body2        14.0  regular  0.25  (bodyText2)
                /// button       14.0  medium   1.25
                /// caption      12.0  regular  0.4
                /// overline     10.0  regular  1.5
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  )
              ),
              appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  elevation: 0.0,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  )),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.greenAccent,
                  backgroundColor: Colors.white,
                  elevation: 30.0),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('2b2b2b'),
              textTheme: TextTheme(
                /// NAME         SIZE  WEIGHT  SPACING
                /// headline1    96.0  light   -1.5
                /// headline2    60.0  light   -0.5
                /// headline3    48.0  regular  0.0
                /// headline4    34.0  regular  0.25
                /// headline5    24.0  regular  0.0
                /// headline6    20.0  medium   0.15
                /// subtitle1    16.0  regular  0.15
                /// subtitle2    14.0  medium   0.1
                /// body1        16.0  regular  0.5   (bodyText1)
                /// body2        14.0  regular  0.25  (bodyText2)
                /// button       14.0  medium   1.25
                /// caption      12.0  regular  0.4
                /// overline     10.0  regular  1.5
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  )
              ),
              appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('2b2b2b'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: HexColor('2b2b2b'),
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  elevation: 0.0,
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  )),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('2b2b2b'),
                  elevation: 30.0),
            ),
            themeMode: cubit.Mode ? ThemeMode.dark : ThemeMode.light,
            home: Home(),
          );
        },
      ),
    );
  }
}
