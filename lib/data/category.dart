
//enum CategoryType {electronic,  }


enum CategoryType{electronicDevice, clothes, furniture, cuisine}
enum ProductSubCategory {x}


class Category {
  final CategoryType type;
  Category(this.type);

  Map<CategoryType, String> _define = {
    CategoryType.clothes: "clothes",
    CategoryType.electronicDevice: "electronic_device",
    CategoryType.furniture: "furniture",
    CategoryType.cuisine: "cuisine",
  };

  String get string => _define[type] as String;
  @override
  String toString() =>  _define[type] as String;
}
