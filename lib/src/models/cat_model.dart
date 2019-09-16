import 'package:cat_test_application/src/models/cat_fact_model.dart';
import 'package:cat_test_application/src/models/cat_image_model.dart';

class CatModel {
  CatImageModel image;
  CatFactModel fact;

  CatModel(this.image, this.fact);
}