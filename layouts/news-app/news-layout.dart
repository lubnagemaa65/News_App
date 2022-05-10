
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search-screen.dart';
import 'package:news_app/network/remout/dio-helper.dart';
import 'package:news_app/shared/cubit.dart';
import 'package:news_app/shared/states.dart';
import 'package:news_app/text-form-field.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener:(context ,state){},
        builder: (context,state){

        var cubit=NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            
            title: const Text('News app'),
            actions: [
              IconButton(onPressed: (){
               navigateTo(context,SearchScreen());
              }, 
              icon: const Icon(Icons.search)),
              IconButton(onPressed: (){
                AppCubit.get(context).changeAppMode();
              }, 
              icon: Icon(Icons.brightness_4_outlined),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItem,
            currentIndex:cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            ),
      
          
        );
        }),
    );
  }
}