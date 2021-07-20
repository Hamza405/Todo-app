import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_sqflite/modules/archive%20tasks/Archive_tasks_screen.dart';
import 'package:todo_sqflite/modules/done%20tasks/done_tasks_screen.dart';
import 'package:todo_sqflite/modules/new%20tasks/new_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite/shared/components/compnents.dart';
import 'package:todo_sqflite/shared/components/constance.dart';
import 'package:todo_sqflite/shared/cubit/cubit.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, AppState state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, AppState state) {
          AppCubit cubit = AppCubit.get(context);
          return state is! AppGetDatabaseLoadingState ? 
          Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabIcon),
              onPressed: () {
                if (cubit.isButtonShetShow) {
                  if (formKey.currentState!.validate()) {
                    cubit
                        .insertToDatabase(
                            title: titleController.text,
                            date: dateController.text,
                            time: timeController.text)
                    ;
                  } else {}
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                          (context) => Container(
                                color: Colors.grey[200],
                                padding: EdgeInsets.all(20),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defualtTextFormField(
                                        controller: titleController,
                                        type: TextInputType.text,
                                        validator: (String? value) {
                                          if (value!.isEmpty)
                                            return 'title must not be empty!';
                                          return null;
                                        },
                                        text: 'Task Title',
                                        prefix: Icons.title,
                                      ),
                                      SizedBox(height: 10),
                                      defualtTextFormField(
                                          controller: timeController,
                                          type: TextInputType.datetime,
                                          validator: (String? value) {
                                            if (value!.isEmpty)
                                              return 'time must not be empty!';
                                            return null;
                                          },
                                          text: 'Task time',
                                          prefix: Icons.watch_later_outlined,
                                          onTap: () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now())
                                                .then((value) =>
                                                    timeController.text = value!
                                                        .format(context)
                                                        .toString());
                                          }),
                                      SizedBox(height: 10),
                                      defualtTextFormField(
                                          controller: dateController,
                                          type: TextInputType.datetime,
                                          validator: (String? value) {
                                            if (value!.isEmpty)
                                              return 'date must not be empty!';
                                            return null;
                                          },
                                          text: 'Task date',
                                          prefix: Icons.calendar_today,
                                          onTap: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.parse(
                                                        '2021-12-12'))
                                                .then((value) =>
                                                    dateController.text =
                                                        DateFormat.yMMMd()
                                                            .format(value!));
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                          elevation: 15.0)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, iconData: Icons.edit);
                  });
                  cubit.changeBottomSheetState(
                      isShow: true, iconData: Icons.add);
                }
              },
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archive')
              ],
            ),
          ) 
          : Center(child:CircularProgressIndicator());
        },
      ),
    );
  }
}
