import 'package:ecommerce_arabic/models/product.dart';

List<Product> getProductByCategory(String catg, List<Product> allProducts) {
  List<Product> pd = [];
  for (var product in allProducts) {
    if (product.pCategory == catg) {
      pd.add(product);
    }
  }
  return pd;
}
