import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Classes/bloc_observer.dart';
import 'package:newsapp/Network/Local/Cach_Helper.dart';
import 'package:newsapp/Network/Remote/dio_Helper.dart';
import 'package:newsapp/Modules/News_App.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:hexcolor/hexcolor.dart';


main() async{

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();

  bool? isDark = false;

  if(CachHelper.getBoolean(key: 'isdarkmode')!= null)
  {
    isDark = CachHelper.getBoolean(key: 'isdarkmode');
  }

  runApp(HomeMainPage(isdarkk: isDark!,));
}

class HomeMainPage extends StatelessWidget {

  bool? isdark;

  HomeMainPage({required bool isdarkk})
  {
    this.isdark = isdarkk;
  }

  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..isdarkmode=isdark,
      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context , state){},
        builder: (context , state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            home: NewsApp(),

            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                //Control Status bar
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                  /////////////////////
                  titleSpacing: 20.0,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(color: Colors.black)),
              bottomNavigationBarTheme:const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  selectedLabelStyle:
                  TextStyle(color: Colors.orange, fontSize: 15.0),
                  elevation: 20.0),
              textTheme:const TextTheme(bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              )
              ),
            ),

            darkTheme: ThemeData(

              primarySwatch: Colors.deepOrange,

              appBarTheme: AppBarTheme(
                //Control Status bar
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('#333739'),
                      statusBarIconBrightness: Brightness.light),
                  /////////////////////
                  titleSpacing: 20.0,
                  backgroundColor: HexColor('#333739'),
                  elevation: 0.0,
                  titleTextStyle:const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme:const IconThemeData(color: Colors.white)),

              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                selectedLabelStyle: TextStyle(color: Colors.orange, fontSize: 15.0),
                elevation: 20.0,
                backgroundColor: HexColor('#333739'),

              ),

              scaffoldBackgroundColor: HexColor('#333739'),

              textTheme:const TextTheme(bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),
              ),
            ),

            themeMode:  NewsCubit.get(context).isdarkmode! ? ThemeMode.dark : ThemeMode.light,

          );
        },
      ),
    );
  }
}