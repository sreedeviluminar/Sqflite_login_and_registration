// import 'package:flutter/material.dart';
//
// class Home extends StatelessWidget {
//   final data;
//   const Home({Key? key,required this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var name  = data[0]['name'];
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text("Welcome $name"),
//       ),
//       body: Center(
//
//         child: Text('Success'),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../db/SQLHelper.dart';
class Home extends StatefulWidget {
  var data;

  Home({super.key, required this.data});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var cemail = TextEditingController();
  var cname = TextEditingController();
  var name, email;

  @override
  void initState() {
    name = widget.data[0]['name'];
    email = widget.data[0]['email'];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    void editData() {
      setState(() {
        cname.text= name;
        cemail.text=email;
      });
      /// to show a dialogBox
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Edit Data",
                style: TextStyle(fontSize: 25),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: cname,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Edit Name"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: cemail,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Edit Email"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          name = cname.text;
                          email= cemail.text;
                        });
                        updateUser();

                        Navigator.of(context).pop();
                        cname.text="";
                        cemail.text="";
                      },
                      child: Text("Update Data"))
                ],
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title:  Text("Welcome $name"),
          elevation: 5,
        ),
        body: Card(
          child: ListTile(
            leading: const Icon(Icons.person_outline_outlined),
            title: Text('$name',
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              '$email',
              style: const TextStyle(fontSize: 15),
            ),
            trailing: IconButton(
                onPressed: () {
                  editData();
                },
                icon: Icon(Icons.edit)),
          ),
        ));
  }

  void updateUser() async {
    SQLHelper.update(widget.data[0]['id'], name, email);
  }
}
