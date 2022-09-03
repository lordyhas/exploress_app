
import 'package:flutter/material.dart';

class CategoryProduct {
  final String title;
  final bool? value;
  final Function(bool value)? onCheckClick;

  CategoryProduct({required this.title, this.value, this.onCheckClick});

  set value(bool? v) => this.value = v;
}

class ChooseCatDialog extends StatefulWidget {
  final String title;
  final List<CategoryProduct> categories;
  final Function? onTapOk;
  final Function? onTapCancel;


  ChooseCatDialog({
    required this.title,
    required this.categories,
    this.onTapOk,
    this.onTapCancel});

  @override
  _ChooseCatDialogState createState() => _ChooseCatDialogState();
}

class _ChooseCatDialogState extends State<ChooseCatDialog> {
  List<CategoryProduct> catList = [];
  Map<String, bool>? cat;
  bool checkV = false;
  @override
  void initState() {
    //catList = widget.categories;
    super.initState();
  }

  /* widget.categories.map<CheckboxListTile>(
                  (e) {
                    checkV = e.value;
                    return CheckboxListTile(
                        checkColor: Theme.of(context).primaryColor,
                        value: e.value,
                        onChanged: (v) {
                          setState(() {
                            //e.value = !e.value;
                            //checkV = v;
                            //e.value(v);
                          });
                          //e.value();
                        },
                        title: Text(e.title, style: Theme.of(context).textTheme.bodyText2,),
                      );
                    }).toList() */


  @override
  Widget build(BuildContext context)  {
    //cat.keys.toList().addAll(catList);
    //cat.values.forEach((value) => value = false );
    //cat.forEach((key, value) { print('$key : $value');});
    catList = widget.categories;
    return AlertDialog(
      title: Text('${widget.title}',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            for (int i = 0; i < catList.length; i++)
              CheckboxListTile(
                checkColor: Theme.of(context).primaryColor,
                value: catList[i].value,
                onChanged: (v) {
                  catList[i].onCheckClick!(v!);

                  setState(() {
                    //e.value = !e.value;
                    //checkV = v;
                    //catList[i].value = v!;
                    //catList[i].onCheckClick!();
                  });
                  //e.value();
                },
                title: Text(catList[i].title,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
        ]
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: Navigator.of(context).pop,
        ),
        TextButton(
          child: Text('Change'),
          onPressed: () {
          },
        ),
      ],
    );
  }
}



Future<dynamic> alertDialog() async {
  return AlertDialog(
    title: Text('Rewind and remember'),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text('You will never be satisfied.'),
          Text("You’re like me. I’m never satisfied."),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: Text('Regret'),
        onPressed: () {
          //Navigator.of(context).pop();
        },
      ),
    ],
  );
}
//--------- AlertDialog --------
