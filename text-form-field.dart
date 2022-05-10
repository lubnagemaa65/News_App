import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/webview-screen.dart';
import 'package:news_app/shared/states.dart';



Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit as void Function(String)?,
      onChanged: onChange as void Function(String)?,
      onTap: onTap as void Function()?,
      validator: validate as String? Function(String?)?,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed as void Function()?,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
      //  NewsCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: () {
                 // AppCubit.get(context).updateData(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
              onPressed: () {
               // AppCubit.get(context).updateData(status: 'archive', id: model['id']);
              },
              icon: Icon(Icons.archive),
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );

Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
  
        padding: const EdgeInsets.all(20.0),
  
        child: Row(
  
          children: [
  
            Container(width: 120.0,height: 120.0,
  
            decoration: BoxDecoration
  
            (borderRadius: BorderRadius.circular(10.0),
  
            image: DecorationImage(
  
             image: NetworkImage('${article['urlToImage']}'),
  
            )),
  
        ),
  
        SizedBox(width: 20.0,)  ,
  
        Expanded(
  
          child: Container(
  
            height: 120.0,
  
            child: Column(
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children: [
  
              Expanded(
  
                child: Text('${article['title']}',
  
                style: Theme.of(context).textTheme.bodyText1,
  
                maxLines: 4,
  
                overflow: TextOverflow.ellipsis,),
  
             
  
              ),Text('${article['publishedAt']}',
  
                style: TextStyle(
  
                  fontSize: 18.0,
  
                  fontWeight: FontWeight.w600,
  
                ),
  
                maxLines: 4,
  
                overflow: TextOverflow.ellipsis,)
  
            ],),
  
          ),
  
        )      
  
            
  
          ],
  
        ),
  
      ),
);
  Widget myDividor(context)=>Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(width: 120.0,height: 120.0,
          decoration: BoxDecoration
          (borderRadius: BorderRadius.circular(10.0),
          image:const DecorationImage(
           image: NetworkImage('https://media.gemini.media/img/large/2017/8/20/2017_8_20_14_33_28_721.jpg'),
          )),
      ),
      SizedBox(width: 20.0,)  ,
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Expanded(
              child: Text('title',
              style: Theme.of(context).textTheme.bodyText1,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,),
           
            )
          ],),
        ),
      )      
          
        ],
      ),
    );

Widget articleBuilder(list, BuildContext context,{isSearch=false})=>ConditionalBuilder(
        condition: State is !NewsLoadingState,
         builder: (context)=>ListView.separated
         (
           physics: BouncingScrollPhysics(),
           itemBuilder: (context,index)=>buildArticleItem(list[index],context),
            separatorBuilder: (context,index)=>myDividor(context),
             itemCount: 10),
         fallback: (context)=>isSearch?Container(): Center(child: CircularProgressIndicator()),
        );
    
void navigateTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>widget,
  )
);
Widget tasksBuilder(List<Map> tasks) => ConditionalBuilder(

      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
        itemCount: tasks.length,
      ),
      condition: tasks.length > 0,
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );