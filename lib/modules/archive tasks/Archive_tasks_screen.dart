import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite/shared/components/compnents.dart';
import 'package:todo_sqflite/shared/cubit/cubit.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';

class ArchiveTasksScreen extends StatelessWidget {
  const ArchiveTasksScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var arhciveTasks=AppCubit.get(context).archiveTasks;
        return arhciveTasks.length==0?Center(child:Text('Archive is empty')) : ListView.separated(
            itemBuilder: (context, index) => buildTasksItem(arhciveTasks[index],context),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey,
                ),
            itemCount: arhciveTasks.length);
      },
    );
  }
}