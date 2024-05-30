class GetAddProductModel {
  GetAddProductModel({
    required this.status,
    required this.message,
    required this.products,
  });

  final String? status;
  final String? message;
  final List<Product> products;

  factory GetAddProductModel.fromJson(Map<String, dynamic> json){
    return GetAddProductModel(
      status: json["status"],
      message: json["message"],
      products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );
  }

}

class Product {
  Product({
    required this.productId,
    required this.catId,
    required this.subcatId,
    required this.childCategory,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.proRatings,
    required this.roleId,
    required this.sellingPrice,
    required this.productCreateDate,
    required this.vendorId,
    required this.otherImage,
    required this.productStatus,
    required this.variantName,
    required this.productType,
    required this.tax,
    required this.unit,
    required this.unitType,
    required this.id,
    required this.cName,
    required this.cNameA,
    required this.icon,
    required this.subTitle,
    required this.description,
    required this.img,
    required this.otherImg,
    required this.type,
    required this.pId,
    required this.serviceType,
    required this.status,
    required this.productUnits,
  });

  final String? productId;
  final String? catId;
  final String? subcatId;
  final String? childCategory;
  final String? productName;
  final String? productDescription;
  final String? productPrice;
  final String? productImage;
  final String? proRatings;
  final String? roleId;
  final String? sellingPrice;
  final DateTime? productCreateDate;
  final String? vendorId;
  final List<String> otherImage;
  final String? productStatus;
  final String? variantName;
  final String? productType;
  final String? tax;
  final String? unit;
  final String? unitType;
  final dynamic id;
  final dynamic cName;
  final dynamic cNameA;
  final dynamic icon;
  final dynamic subTitle;
  final dynamic description;
  final dynamic img;
  final dynamic otherImg;
  final dynamic type;
  final dynamic pId;
  final dynamic serviceType;
  final dynamic status;
  final List<ProductUnit> productUnits;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      productId: json["product_id"],
      catId: json["cat_id"],
      subcatId: json["subcat_id"],
      childCategory: json["child_category"],
      productName: json["product_name"],
      productDescription: json["product_description"],
      productPrice: json["product_price"],
      productImage: json["product_image"],
      proRatings: json["pro_ratings"],
      roleId: json["role_id"],
      sellingPrice: json["selling_price"],
      productCreateDate: DateTime.tryParse(json["product_create_date"] ?? ""),
      vendorId: json["vendor_id"],
      otherImage: json["other_image"] == null ? [] : List<String>.from(json["other_image"]!.map((x) => x)),
      productStatus: json["product_status"],
      variantName: json["variant_name"],
      productType: json["product_type"],
      tax: json["tax"],
      unit: json["unit"],
      unitType: json["unit_type"],
      id: json["id"],
      cName: json["c_name"],
      cNameA: json["c_name_a"],
      icon: json["icon"],
      subTitle: json["sub_title"],
      description: json["description"],
      img: json["img"],
      otherImg: json["other_img"],
      type: json["type"],
      pId: json["p_id"],
      serviceType: json["service_type"],
      status: json["status"],
      productUnits: json["product_units"] == null ? [] : List<ProductUnit>.from(json["product_units"]!.map((x) => ProductUnit.fromJson(x))),
    );
  }

}

class ProductUnit {
  ProductUnit({
    required this.id,
    required this.productId,
    required this.unit,
    required this.type,
  });

  final String? id;
  final String? productId;
  final String? unit;
  final String? type;

  factory ProductUnit.fromJson(Map<String, dynamic> json){
    return ProductUnit(
      id: json["id"],
      productId: json["product_id"],
      unit: json["unit"],
      type: json["type"],
    );
  }

}
