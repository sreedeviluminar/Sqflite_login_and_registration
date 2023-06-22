import 'package:auth_sqlflite/db/SQLHelper.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  var data; ///for storing all the users from the db


  @override   ///when this page loads show all the registered users in the screen
  void initState() {
    Refresh();
    super.initState();
  }

  void Refresh() async{
    var mydata  = await SQLHelper.getAll(); /// function for fetching all the values from db
    setState(()   {
      data = mydata;
    });
  }

  void delet(int id)async {
   await SQLHelper.Deleteuser(id);
   Refresh();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel'),),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,int index){
        return Card(
          color: Colors.deepPurple[200],
          child: ListTile(
            title: Text('${data[index]['name']}'),
            trailing: IconButton(onPressed: (){
             delet(data[index]['id']);
            },icon: Icon(Icons.delete),),
          ),
        );
      }),
    );
  }
}
