class CategoryModel {
  String? name;
  String? url;

  CategoryModel({this.name, this.url});
}

List<CategoryModel>? getData() {
  List<CategoryModel> categoryModel = [];

  CategoryModel category;

  category = CategoryModel();
  category.name = "Shower";
  category.url =
      "https://images.unsplash.com/photo-1561361398-d1f7b6cfee79?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80";
  categoryModel.add(category);

  category = CategoryModel();
  category.name = "ShowerTube";
  category.url =
      "https://images.unsplash.com/photo-1561361398-d1f7b6cfee79?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80";
  categoryModel.add(category);

  category = CategoryModel();
  category.name = "Health faceint";
  category.url =
      "https:images.unsplash.com/photo-1561361398-d1f7b6cfee79?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80";
  categoryModel.add(category);
  return categoryModel;
}
