import 'package:cat_test_application/src/models/cat_fact_model.dart';
import 'package:cat_test_application/src/models/cat_image_model.dart';
import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CatRepository {
  static const _apiKey = '155de652-fcd9-4019-8cba-149f1b5c370a';
  static const pageItemLimit = 20;

  Future<List<CatImageModel>> images(int page) async{
    var response = await http.get(
      'https://api.thecatapi.com/v1/images/search?size=med&limit=$pageItemLimit&page=$page',
      headers: { 'x-api-key': _apiKey }
    );
    dynamic json = convert.jsonDecode(response.body);
    var list = <CatImageModel>[];
    for (var item in json) {
      list.add(CatImageModel.fromJson(item));
    }
    return list;
  }

  Future<List<CatFactModel>> facts(int page) async{
    var response = await http.get(
      'https://catfact.ninja/facts?limit=$pageItemLimit&page=$page',
      headers: { 'Accept': 'application/json' }
    );
    dynamic json = convert.jsonDecode(response.body);
    var list = <CatFactModel>[];
    for (var item in json['data']) {
      list.add(CatFactModel.fromJson(item));
    }
    return list;
  }

  Future<List<CatModel>> cats(int page) async{
    var imgs = await images(page);
    var fcts = await facts(page);
    var list = <CatModel>[];
    for (var i = 0; i < pageItemLimit; i++) {
      list.add(CatModel(imgs[i], fcts[i]));
    }
    return list;
  }
}

final catRepository = CatRepository();