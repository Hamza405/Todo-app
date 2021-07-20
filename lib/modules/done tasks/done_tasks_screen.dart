import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite/shared/components/compnents.dart';
import 'package:todo_sqflite/shared/cubit/cubit.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var doneTasks=AppCubit.get(context).doneTasks;
        return doneTasks.length==0? Center(child: Text('Done tasks is empty'),) :ListView.separated(
            itemBuilder: (context, index) => buildTasksItem(doneTasks[index],context),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey,
                ),
            itemCount: doneTasks.length);
      },
    );
  }
}