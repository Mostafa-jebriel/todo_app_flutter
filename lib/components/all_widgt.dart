import 'package:flutter/material.dart';
import 'package:todo_app/cubit/cubit.dart';

Widget TextForm({
  required TextEditingController c,
  required TextInputType type,
  final Function? onsubmit,
  final Function? ontab,
  //required Function validate,
  required String lable,
  required IconData icon,
}) =>
    TextFormField(
      controller: c,
      //validator: ()=>validate(),
      onTap: () => ontab,
      // onFieldSubmitted: onsubmit!(),
      keyboardType: type,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );

Widget TaskItem(Map li,con) => Dismissible(
  key: Key(li['id'].toString()),
  child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text("${li['time']}"),
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
                      "${li['title']}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${li['date']}",
                      style: TextStyle(color: Colors.red),
                    ),
                  ]),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: Icon(Icons.check_box,
              color: Colors.greenAccent,),
              onPressed: () {
                AppCubit.get(con).updateDate(status: 'done', id:li['id']);
              },
            ),
            IconButton(
              icon: Icon(Icons.archive,
                color: Colors.black45),
              onPressed: () {
                AppCubit.get(con).updateDate(status: 'archive', id:li['id']);
              },
            ),
          ],
        ),
      ),
  onDismissed: (dir){
    AppCubit.get(con).deleteDate(id:li['id']);

  },
);

Widget DoneTaskItem(Map li,con) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40,
        child: Text("${li['time']}"),
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
                "${li['title']}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "${li['date']}",
                style: TextStyle(color: Colors.red),
              ),
            ]),
      ),
      SizedBox(
        width: 20,
      ),
      IconButton(
        icon: Icon(Icons.delete,
          color: Colors.red,),
        onPressed: () {
          AppCubit.get(con).deleteDate(id:li['id']);
        },
      ),
      IconButton(
        icon: Icon(Icons.archive,
            color: Colors.black45),
        onPressed: () {
          AppCubit.get(con).updateDate(status: 'archive', id:li['id']);
        },
      ),
    ],
  ),
);

Widget ArchiveTaskItem(Map li,con) => Dismissible(
  key: Key(li['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text("${li['time']}"),
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
                  "${li['title']}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${li['date']}",
                  style: TextStyle(color: Colors.red),
                ),
              ]),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
          icon: Icon(Icons.check_box,
            color: Colors.greenAccent,),
          onPressed: () {
            AppCubit.get(con).updateDate(status: 'done', id:li['id']);
          },
        ),
        IconButton(
          icon: Icon(Icons.delete,
            color: Colors.red,),
          onPressed: () {
            AppCubit.get(con).deleteDate(id:li['id']);
          },
        ),
      ],
    ),
  ),
  onDismissed: (dir){
    AppCubit.get(con).deleteDate(id:li['id']);

  },
);

Widget EmptyTask() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            child: Image.asset('images/listing.png'),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "The List Task is Empty",
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ]);
