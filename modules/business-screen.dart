

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/shared/cubit.dart';
import 'package:news_app/shared/states.dart';
import 'package:news_app/text-form-field.dart';

class BusinessScreen extends StatelessWidget {
   BusinessScreen({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {  
        var list = NewsCubit.get(context).business;
return articleBuilder(list,context);

      },);}}