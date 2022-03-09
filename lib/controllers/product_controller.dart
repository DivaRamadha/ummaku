import 'package:get/state_manager.dart';
import 'package:ummaku/model/product_model.dart';

class ProductController extends GetxController {
  var index = 0;
  List<Product>? dataProduk;

  int get ind => index;
  List<Product> get data => dataProduk!;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() {
    dataProduk = listProduct;
    update();
  }

  likeProduct(int index) {
    dataProduk![index].isLike = !dataProduk![index].isLike!;

    update();
  }
}
