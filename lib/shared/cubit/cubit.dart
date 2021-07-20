import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite/modules/archive%20tasks/Archive_tasks_screen.dart';
import 'package:todo_sqflite/modules/done%20tasks/done_tasks_screen.dart';
import 'package:todo_sqflite/modules/new%20tasks/new_tasks_screen.dart';
import 'package:todo_sqflite/shared/cubit/states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  IconData fabIcon = Icons.edit;
  bool isButtonShetShow = false;
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen()
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archive Tasks'];

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  changeBottomSheetState(
      {@required bool? isShow, @required IconData? iconData}) {
    isButtonShetShow = isShow!;
    fabIcon = iconData!;
    emit(AppChangeBottomSheetState());
  }

  void createDatabase() async {
    openDatabase('todo.db', version: 1, onCreate: (database, version) async {
      await database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        emit(AppCreateDatabaseState());
        print('create database');
      }).catchError((e) {
        print((e.toString()));
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
    });
  }

  insertToDatabase(
      {@required String? title,
      @required String? time,
      @required String? date}) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status)VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value insert success');
        emit(AppInsertDatabaseState());
      }).catchError((error) {
        print(error.toString());
      });
      getDataFromDatabase(database);
    });
  }

  void updateData({@required String? status, @required int? id}) async {
    return database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      emit(AppUpdateDatabaseState());
      getDataFromDatabase(database);
    });
  }

  void getDataFromDatabase(database) {
    emit(AppGetDatabaseLoadingState());
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    database!.rawQuery('SELECT *FROM tasks').then((value) {
      value.forEach((e){
        if(e['status'] == 'new'){
          newTasks.add(e);
        }
         else if(e['status'] == 'done'){
          doneTasks.add(e);
        }
         else {
          archiveTasks.add(e);
        }
      });
      emit(AppGetDatabaseState());
      print('get database');
    });
  }

  void deleteFromDataBase(@required int id){
    database!.rawDelete('DELETE FROM tasks WHERE id = ?',[id]).then((value) {
      emit(AppDeleteDatabaseState());
      getDataFromDatabase(database);
    });
  }
}
