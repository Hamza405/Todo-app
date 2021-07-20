import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite/shared/components/compnents.dart';
import 'package:todo_sqflite/shared/components/constance.dart';
import 'package:todo_sqflite/shared/cubit/cubit.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var newTasks=AppCubit.get(context).newTasks;
        return newTasks.length==0? Center(child:Text('No tasks yet')) :ListView.separated(
            itemBuilder: (context, index) => buildTasksItem(newTasks[index],context),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey,
                ),
            itemCount: newTasks.length);
      },
    );
  }
}
