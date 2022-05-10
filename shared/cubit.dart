
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business-screen.dart';
import 'package:news_app/modules/science.dart';
import 'package:news_app/modules/sports.dart';
import 'package:news_app/network/remout/cash-helper.dart';
import 'package:news_app/network/remout/dio-helper.dart';
import 'package:news_app/shared/states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'settings',
    )
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    
  ];
 List<dynamic> search = [];
  void getsearch(String value) {
   
      emit(NewsGetSearchLoadingState());
      search=[];
      DioHelper.getData(url: 'v2/everything', 
      query: {
        'q':'$value',
         
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
       }).then((value) {
      search=value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSucessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error));
      print(error.toString());
    });
      }
  
  

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<Map> business = [];
  void getBusiness() {

    emit(NewsLoadingState());
    Dio dio = Dio();
    dio.options.baseUrl='http://newsapi.org/';
    DioHelper.getData(url: 'v2/everything/',
     query: {
      'country': 'eg',
          'category': 'business',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
       }).then((value) {
      print(value.data['articles']);
      business = value.data['business']['title'];

      emit(NewsGetBusinessSucessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error));
      print(error.toString());
    });
  }

  List<Map> sports = [];
  void getSports() {
    if (sports.length == 0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(url: 'v2/everything/', query: {
        'q': 'tesla',
        'from': '2022-04-06',
        'sortBy': 'publishedAt',
        'author': 'Al Root',
        'apiKey': '97787a8537c14f35af14c6c64973d094',
      }).then((value) {
        print(value.data['articles']);
        business = value.data['sports']['title'];

        emit(NewsGetSportsSucessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error));
        print(error.toString());
      });
    } else {
      emit(NewsGetSportsSucessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    if (science.length == 0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: 'v2/everything/', query: {
        'q': 'tesla',
        'from': '2022-04-06',
        'sortBy': 'publishedAt',
        'author': 'Al Root',
        'apiKey': '97787a8537c14f35af14c6c64973d094',
      }).then((value) {
        print(value.data['articles']);
        business = value.data['business']['title'];

        emit(NewsGetscienceSucessState());
      }).catchError((error) {
        emit(NewsGetscienceErrorState(error));
        print(error.toString());
      });
    } else {
      emit(NewsGetscienceSucessState());
    }
  }
}
class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState() );

static AppCubit get(context) => BlocProvider.of(context);


bool isDark=false;
  void changeAppMode(){
        isDark=!isDark;

    CashHelper.putData(key: 'isDark', value: isDark).then((value) {

    emit(ChangeAppModeState ());

    });
  }
  
}
 