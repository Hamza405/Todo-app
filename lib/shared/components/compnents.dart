import 'package:flutter/material.dart';
import 'package:todo_sqflite/shared/cubit/cubit.dart';

Widget defaultButton(
        {double? width = double.infinity,
        Color? background = Colors.blue,
        @required Function? function,
        @required String? text,
        double radius = 10.0,
        bool isUpperCase = true}) =>
    Container(
      height: 50.0,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defualtTextFormField(
        {@required TextEditingController? controller,
        @required TextInputType? type,
        Function(String)? onSumbit,
        Function()? onTap,
        ValueChanged<String>? onChange,
        FormFieldValidator<String?>? validator,
        @required String? text,
        IconData? prefix,
        IconData? suffix,
        bool isClickable = true,
        bool isPassowrd=false,
        Function()? suffixPress}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassowrd,
      keyboardType: type,
      onFieldSubmitted: onSumbit,
      onChanged: onChange,
      validator: validator,
      enabled: isClickable,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(prefix),
        suffix: suffix!=null?IconButton(icon:Icon(suffix),onPressed: suffixPress,):null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTasksItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          
          children: [
            CircleAvatar(
              radius: 45,
              child:Text(model['time'])
            ),
            SizedBox(width: 20,),
            Expanded(
                        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(model['title'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text(model['date'],style: TextStyle(color: Colors.grey,fontSize: 20)),
                ],
              ),
            ),
             SizedBox(width: 20,),
             IconButton(onPressed: (){
               AppCubit.get(context).updateData(status: 'done', id: model['id']);
             }, icon: Icon(Icons.check,color: Colors.blue,)),
             IconButton(onPressed: (){
               AppCubit.get(context).updateData(status: 'archive', id: model['id']);
             }, icon: Icon(Icons.archive_rounded,color:Colors.black26))
          ],
        ),
      ),
      onDismissed: (d){
        AppCubit.get(context).deleteFromDataBase(model['id']);
      },
);