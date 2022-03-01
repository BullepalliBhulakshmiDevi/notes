import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/Data_Models//Notes.dart';
import 'package:notes/Data_Models//NotesProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: camel_case_types
class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      appBar: AppBar(
          titleSpacing: 0.0,
          toolbarHeight: 200,
          title: Image.asset("notes1.jpg",fit: BoxFit.cover,)
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NotesProviders>(
          builder: (context,NotesProviders data,child){
            return data.getNotes.length !=0 ? ListView.builder(
              itemCount: data.getNotes.length,
              itemBuilder: (context,index){
                return CardList(data.getNotes[index],index);
              },
            ): GestureDetector(onTap: (){
              showAlertDialog(context);
            },child: Center(child: Text("ADD SOME NOTES NOW",style: TextStyle(color: Colors.white,),)));
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        showAlertDialog(context);
      },
        backgroundColor: Colors.white,
        child: Icon(Icons.add,color: Colors.black,),
      ),
    );

  }

}

// ignore: must_be_immutable
class CardList extends StatelessWidget {
  final Notes notes;
  int index;

  CardList(this.notes,this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child:Slidable(
        key: const ValueKey(0),

        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),

              )
          ),
          child: ListTile(
            leading: Icon(Icons.note),
            title: Text(notes.title),
            subtitle: Text(notes.description),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
          ),




        ),







        ),
    );
  }
}

showAlertDialog(BuildContext context) {

  TextEditingController _Title = TextEditingController();
  TextEditingController _Description = TextEditingController();
  // Create button
  Widget okButton = FlatButton(
    child: Text("ADD NOTE"),
    onPressed: () {
      Provider.of<NotesProviders>(context,listen: false).addNotes(_Title.text, _Description.text);
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("ADD A NEW NOTE "),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _Title,
          decoration: InputDecoration(hintText: "Enter Title"),
        ),
        TextField(
          controller: _Description,
          decoration: InputDecoration(hintText: "Enter Description"),
        ),
      ],
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}