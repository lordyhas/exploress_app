import 'package:exploress/data/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddressCard extends StatelessWidget {
  final AddressData address;
  AddressCard(this.address);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        borderOnForeground: true,
        child: Container(
          child: Column(
            children: [
              Text("Harvey Kajila", style: TextStyle(fontWeight: FontWeight.bold),),
              Text("75446, Av Compton, Q. LDK, MTL du bled, Laval Loréale,"*10),
              Text("PO.BOX: 07562")
            ],
          ),
        ),
      ),
    );
  }
}
