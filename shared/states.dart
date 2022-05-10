
abstract class NewsStates {}

class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}
class NewsLoadingState extends NewsStates{}

class NewsGetBusinessSucessState extends NewsStates{}
class NewsGetBusinessErrorState extends NewsStates{
  final String error;

  NewsGetBusinessErrorState(this.error);
}
class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetscienceSucessState extends NewsStates{}
class NewsGetscienceErrorState extends NewsStates{
   final String error;

  NewsGetscienceErrorState(this.error);
}
class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsSucessState extends NewsStates{}
class NewsGetSportsErrorState extends NewsStates{
   final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchSucessState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates{
   final String error;

  NewsGetSearchErrorState(this.error);
}


abstract class AppStates{}
class AppInitialState extends AppStates{}
class ChangeAppModeState extends AppStates{}