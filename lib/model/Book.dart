class Book {
  final String code;
  final String libelle;
  final String type;

  Book(
      {required this.code, required this.libelle, required this.type});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      code: json["code"],

      libelle: json["libelle"],
      type: json["type"],
    );
  }

  static List<Book> fromJsonList(List list) {
    return list.map((item) => Book.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.code} ${this.libelle} ${this.type}';
  }


  ///custom comparing function to check if two users are equal
  bool isEqual(Book model) {
    return this.code == model.code;
  }

  @override
  String toString() => libelle;
}
