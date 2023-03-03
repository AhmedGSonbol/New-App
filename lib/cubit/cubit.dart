import 'package:bloc/bloc.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Modules/business_Screen.dart';
import 'package:newsapp/Modules/science_Screen.dart';
import 'package:newsapp/Modules/sports_Screen.dart';
import 'package:newsapp/Network/Local/Cach_Helper.dart';
import 'package:newsapp/Network/Remote/dio_Helper.dart';
import 'package:newsapp/cubit/states.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  bool? isdarkmode = false;

  List<BottomNavigationBarItem> bottomItems = 
  [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science'
    ),
  ];

  List<Widget> screens =
  [
    Business_Screen(),
    Sports_Screen(),
    Science_Screen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];


  ////////////////////////////////////////////////////////////////

  void changeBottomNavBar(int index)
  {

    currentIndex = index;
    if(index == 1)
      getSports();
    else if(index == 2)
      getScience();
    else
      getBusiness();
  }

  void getBusiness()
  {
    if(business.length == 0)
    {
      emit(NewsGetBusinessLoadingState());

      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'business',
            'apikey':'fc62847ef52c4002922b6f80c8f20a4e'
          }//['articles'][0]['source']['name']
      )?.then((value) {
        //print(value.data['articles'][0]['title'].toString());
        business = value.data['articles'];
        print(business[0]['title']);

        emit(NewsGetBusinessSuccessState());

      }).catchError((err){
        print(err.toString());
        emit(NewsGetBusinessErrorState(err.toString()));

      });
    }else
    {
      emit(NewsGetBusinessSuccessState());
    }

  }

  void getSports()
  {
    if(sports.length == 0)
    {
      emit(NewsGetSportsLoadingState());

      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apikey':'fc62847ef52c4002922b6f80c8f20a4e'
          }//['articles'][0]['source']['name']
      )?.then((value) {
        //print(value.data['articles'][0]['title'].toString());
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());

      }).catchError((err){
        print(err.toString());
        emit(NewsGetSportsErrorState(err.toString()));

      });
    }else
    {
      emit(NewsGetSportsSuccessState());

    }
  }

  void getScience()
  {

    if(science.length == 0)
    {
      emit(NewsGetScienceLoadingState());

      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country':'eg',
            'category':'science',
            'apikey':'fc62847ef52c4002922b6f80c8f20a4e'
          }//['articles'][0]['source']['name']
      )?.then((value) {
        //print(value.data['articles'][0]['title'].toString());
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());

      }).catchError((err){
        print(err.toString());
        emit(NewsGetScienceErrorState(err.toString()));

      });
    }else
    {
      emit(NewsGetScienceSuccessState());

    }
  }

  void changeDarkMode()
  {

    isdarkmode = !isdarkmode!;
    CachHelper.putBoolean(key: 'isdarkmode', value: isdarkmode!).then((value)
    {
      emit(NewsDarkModeChange());

    });
  }

  void getSearch(String? val)
  {


      //emit(NewsGetSearchLoadingState());
      search = [];
      DioHelper.getData(
          url: 'v2/everything',
          query:
          {
            'q':'$val',
            'apikey':'fc62847ef52c4002922b6f80c8f20a4e'
          }//['articles'][0]['source']['name']
      )?.then((value) {
        //print(value.data['articles'][0]['title'].toString());
        search = value.data['articles'];
        print(search[0]['title']);

        emit(NewsGetSearchSuccessState());

      }).catchError((err){
        print(err.toString());
        emit(NewsGetSearchErrorState(err.toString()));

      });

  }

}