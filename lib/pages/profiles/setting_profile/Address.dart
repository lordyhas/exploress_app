part of '../../profiles.dart';

class AddressScreenContainer extends Container{
  AddressScreenContainer(): super(
    child: _addressScreen
  );


  static var _addressScreen = Column(
    children: [
      Card(
        borderOnForeground: true,
        child: Container(
          child: Column(
            children: [
              Text("Hassan Kajila", style: TextStyle(fontWeight: FontWeight.bold),),
              Text("8976, Av Lualaba, Q. Latin, Kzi, Manika,"*10),
              Text("PO.BOX: 07562")
            ],
          ),
        ),
      ),
      Card(
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
    ],
  );
}