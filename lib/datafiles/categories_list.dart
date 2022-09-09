class CategoriesModel {
  String bookName;
  bool isChecked;

  CategoriesModel({required this.bookName, required this.isChecked});
}

List<CategoriesModel> categories = [
  CategoriesModel(bookName: "Islamic", isChecked: false),
  CategoriesModel(bookName: "History", isChecked: false),
  CategoriesModel(bookName: "Manga", isChecked: false),
  CategoriesModel(bookName: "Children", isChecked: false),
  CategoriesModel(bookName: "Science", isChecked: false),
  CategoriesModel(bookName: "CookBook", isChecked: false),
  CategoriesModel(bookName: "Philosophy", isChecked: false),
  CategoriesModel(bookName: "Sports", isChecked: false),
  CategoriesModel(bookName: "Art", isChecked: false),
  CategoriesModel(bookName: "Crime", isChecked: false),
  CategoriesModel(bookName: "Horror", isChecked: false),
  CategoriesModel(bookName: "Poetry", isChecked: false),
  CategoriesModel(bookName: "Biography", isChecked: false),
  CategoriesModel(bookName: "Psychology", isChecked: false),
  CategoriesModel(bookName: "Developpement", isChecked: false),
  CategoriesModel(bookName: "Business", isChecked: false),
  CategoriesModel(bookName: "Fantasy", isChecked: false),
  CategoriesModel(bookName: "Adventure", isChecked: false),
  CategoriesModel(bookName: "Fiction", isChecked: false),
  CategoriesModel(bookName: "Romance", isChecked: false),
  CategoriesModel(bookName: "Education", isChecked: false),
  CategoriesModel(bookName: "Law", isChecked: false),
  CategoriesModel(bookName: "Thriller", isChecked: false),
];

List<String> selectedCategories = [];
