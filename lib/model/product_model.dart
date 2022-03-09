class Product {
  String? name;
  String? description;
  String? location;
  double? lat;
  double? lng;
  Developer? dev;
  String? tipe;
  int? price;
  int? lt;
  int? lb;
  int? lantai;
  int? totalUnit;
  bool? isLike;
  List<String>? img;
  int? condition;

  Product({
    this.name,
    this.description,
    this.location,
    this.condition,
    this.lat,
    this.lng,
    this.dev,
    this.tipe,
    this.price,
    this.lt,
    this.lb,
    this.lantai,
    this.img,
    this.isLike,
    this.totalUnit,
  });
}

class Developer {
  String? name;
  String? status;

  Developer({this.name, this.status});
}

List<Product> listProduct = [
  Product(
    name: 'Rumah Keren Minimalis',
    description: '',
    lantai: 1,
    lt: 60,
    lb: 48,
    location: 'Setia Budi, Jakarta',
    price: 400000000,
    tipe: 'A',
    totalUnit: 2,
    condition: 0,
    isLike: false,
    lat: -6.213519,
    lng: 106.822366,
    dev: Developer(name: 'PT. Bikin Rumah', status: ''),
    img: [
      //set your image url
    ],
  ),
  Product(
    name: 'FrontEnd Residence',
    description: '',
    lantai: 2,
    condition: 0,
    lt: 90,
    lb: 78,
    location: 'Setia Budi, Jakarta',
    price: 760000000,
    tipe: 'A',
    totalUnit: 2,
    isLike: false,
    lat: -6.212519,
    lng: 106.842266,
    dev: Developer(name: 'PT. Mencari Rumah Sejati', status: ''),
    img: [
      //set your image url
    ],
  ),
  Product(
    name: 'Title Residence',
    description: '',
    lantai: 1,
    condition: 0,
    lt: 78,
    lb: 68,
    location: 'Setia Budi, Jakarta',
    price: 680000000,
    tipe: 'A',
    totalUnit: 2,
    isLike: false,
    lat: -6.212419,
    lng: 106.833266,
    dev: Developer(name: 'PT. Rumah Abadi', status: ''),
    img: [
      //set your image url
    ],
  ),
  Product(
    name: 'Dijual Rumah Daerah Jaksel',
    description: '',
    lantai: 1,
    lt: 60,
    lb: 48,
    location: 'Setia Budi, Jakarta',
    price: 400000000,
    tipe: 'A',
    totalUnit: 2,
    isLike: false,
    condition: 1,
    lat: -6.212519,
    lng: 106.829166,
    dev: Developer(name: 'PT. Bikin Rumah', status: ''),
    img: [
      //set your image url
    ],
  ),
  Product(
    name: 'Rumah Desain Ala Eropa',
    description: '',
    lantai: 1,
    lt: 60,
    lb: 48,
    location: 'Setia Budi, Jakarta',
    price: 400000000,
    tipe: 'A',
    totalUnit: 2,
    isLike: false,
    condition: 1,
    lat: -6.213519,
    lng: 106.932266,
    dev: Developer(name: 'PT. Bikin Rumah', status: ''),
    img: [
      //set your image url
    ],
  )
];
