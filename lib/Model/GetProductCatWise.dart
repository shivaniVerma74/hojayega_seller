/// status : "1"
/// message : "Products Found"
/// products : [{"product_id":"1","cat_id":"1","subcat_id":"2","child_category":"2","product_name":"Dawat Biryani","product_description":"Dawat Biryani","product_price":"500","product_image":"https://developmentalphawizz.com/hojayega/uploads/product_images//uploads/product_image/1703770613Rs__200_Off.jpg","pro_ratings":"0.0","role_id":"","selling_price":"100","product_create_date":"2023-12-28 19:06:53","vendor_id":"137","other_image":["https://developmentalphawizz.com/hojayega/uploads/product_images/"],"product_status":"1","variant_name":"","product_type":"","tax":"0","unit":"1kg","id":null,"c_name":null,"c_name_a":null,"icon":null,"sub_title":null,"description":null,"img":null,"other_img":null,"type":null,"p_id":null,"service_type":null},{"product_id":"2","cat_id":"1","subcat_id":"2","child_category":"2","product_name":"Dawat Biryani","product_description":"Dawat Biryani","product_price":"500","product_image":"https://developmentalphawizz.com/hojayega/uploads/product_images//uploads/product_image/1703770615Rs__200_Off.jpg","pro_ratings":"0.0","role_id":"","selling_price":"100","product_create_date":"2023-12-28 19:06:55","vendor_id":"137","other_image":["https://developmentalphawizz.com/hojayega/uploads/product_images/"],"product_status":"0","variant_name":"","product_type":"","tax":"0","unit":"1kg","id":null,"c_name":null,"c_name_a":null,"icon":null,"sub_title":null,"description":null,"img":null,"other_img":null,"type":null,"p_id":null,"service_type":null},{"product_id":"6","cat_id":"1","subcat_id":"2","child_category":"2","product_name":"New Food","product_description":"hcchchchhchchchchcch","product_price":"5000","product_image":"https://developmentalphawizz.com/hojayega/uploads/product_images//uploads/product_image/1703935081scaled_Screenshot_2023-11-20-13-18-15-219_com_antsnest_user1.jpg","pro_ratings":"0.0","role_id":"","selling_price":"1000","product_create_date":"2023-12-30 16:48:01","vendor_id":"137","other_image":["https://developmentalphawizz.com/hojayega/uploads/product_images/"],"product_status":"0","variant_name":"","product_type":"","tax":"0","unit":"kG1","id":null,"c_name":null,"c_name_a":null,"icon":null,"sub_title":null,"description":null,"img":null,"other_img":null,"type":null,"p_id":null,"service_type":null},{"product_id":"7","cat_id":"1","subcat_id":"2","child_category":"2","product_name":"Dawat Biryani","product_description":"Dawat Biryani","product_price":"500","product_image":"https://developmentalphawizz.com/hojayega/uploads/product_images/","pro_ratings":"0.0","role_id":"","selling_price":"100","product_create_date":"2023-12-30 17:31:07","vendor_id":"137","other_image":["https://developmentalphawizz.com/hojayega/uploads/product_images/"],"product_status":"0","variant_name":"","product_type":"","tax":"0","unit":"1kg","id":null,"c_name":null,"c_name_a":null,"icon":null,"sub_title":null,"description":null,"img":null,"other_img":null,"type":null,"p_id":null,"service_type":null}]

class GetProductCatWise {
  GetProductCatWise({
      String? status, 
      String? message, 
      List<ProductsData>? products,}){
    _status = status;
    _message = message;
    _products = products;
}

  GetProductCatWise.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(ProductsData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<ProductsData>? _products;
GetProductCatWise copyWith({  String? status,
  String? message,
  List<ProductsData>? products,
}) => GetProductCatWise(  status: status ?? _status,
  message: message ?? _message,
  products: products ?? _products,
);
  String? get status => _status;
  String? get message => _message;
  List<ProductsData>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_id : "1"
/// cat_id : "1"
/// subcat_id : "2"
/// child_category : "2"
/// product_name : "Dawat Biryani"
/// product_description : "Dawat Biryani"
/// product_price : "500"
/// product_image : "https://developmentalphawizz.com/hojayega/uploads/product_images//uploads/product_image/1703770613Rs__200_Off.jpg"
/// pro_ratings : "0.0"
/// role_id : ""
/// selling_price : "100"
/// product_create_date : "2023-12-28 19:06:53"
/// vendor_id : "137"
/// other_image : ["https://developmentalphawizz.com/hojayega/uploads/product_images/"]
/// product_status : "1"
/// variant_name : ""
/// product_type : ""
/// tax : "0"
/// unit : "1kg"
/// id : null
/// c_name : null
/// c_name_a : null
/// icon : null
/// sub_title : null
/// description : null
/// img : null
/// other_img : null
/// type : null
/// p_id : null
/// service_type : null

class ProductsData {
  ProductsData({
      String? productId, 
      String? catId, 
      String? subcatId, 
      String? childCategory, 
      String? productName, 
      String? productDescription, 
      String? productPrice, 
      String? productImage, 
      String? proRatings, 
      String? roleId, 
      String? sellingPrice, 
      String? productCreateDate, 
      String? vendorId, 
      List<dynamic>? otherImage,
      String? productStatus, 
      String? variantName, 
      String? productType, 
      String? tax, 
      String? unit, 
      dynamic id, 
      dynamic cName, 
      dynamic cNameA, 
      dynamic icon, 
      dynamic subTitle, 
      dynamic description, 
      dynamic img, 
      List<dynamic>? otherImg,
      dynamic type, 
      dynamic pId, 
      dynamic serviceType,}){
    _productId = productId;
    _catId = catId;
    _subcatId = subcatId;
    _childCategory = childCategory;
    _productName = productName;
    _productDescription = productDescription;
    _productPrice = productPrice;
    _productImage = productImage;
    _proRatings = proRatings;
    _roleId = roleId;
    _sellingPrice = sellingPrice;
    _productCreateDate = productCreateDate;
    _vendorId = vendorId;
    _otherImage = otherImage;
    _productStatus = productStatus;
    _variantName = variantName;
    _productType = productType;
    _tax = tax;
    _unit = unit;
    _id = id;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _otherImg = otherImg;
    _type = type;
    _pId = pId;
    _serviceType = serviceType;
}

  ProductsData.fromJson(dynamic json) {
    _productId = json['product_id'];
    _catId = json['cat_id'];
    _subcatId = json['subcat_id'];
    _childCategory = json['child_category'];
    _productName = json['product_name'];
    _productDescription = json['product_description'];
    _productPrice = json['product_price'];
    _productImage = json['product_image'];
    _proRatings = json['pro_ratings'];
    _roleId = json['role_id'];
    _sellingPrice = json['selling_price'];
    _productCreateDate = json['product_create_date'];
    _vendorId = json['vendor_id'];
    _otherImage = json['other_image'] != null ? json['other_image'].cast<String>() : [];
    _productStatus = json['product_status'];
    _variantName = json['variant_name'];
    _productType = json['product_type'];
    _tax = json['tax'];
    _unit = json['unit'];
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['product_image'];
    _otherImg = json['other_image'];
    _type = json['type'];
    _pId = json['p_id'];
    _serviceType = json['service_type'];
  }
  String? _productId;
  String? _catId;
  String? _subcatId;
  String? _childCategory;
  String? _productName;
  String? _productDescription;
  String? _productPrice;
  String? _productImage;
  String? _proRatings;
  String? _roleId;
  String? _sellingPrice;
  String? _productCreateDate;
  String? _vendorId;
  List<dynamic>? _otherImage;
  String? _productStatus;
  String? _variantName;
  String? _productType;
  String? _tax;
  String? _unit;
  dynamic _id;
  dynamic _cName;
  dynamic _cNameA;
  dynamic _icon;
  dynamic _subTitle;
  dynamic _description;
  dynamic _img;
  List<dynamic>? _otherImg;
  dynamic _type;
  dynamic _pId;
  dynamic _serviceType;
  ProductsData copyWith({  String? productId,
  String? catId,
  String? subcatId,
  String? childCategory,
  String? productName,
  String? productDescription,
  String? productPrice,
  String? productImage,
  String? proRatings,
  String? roleId,
  String? sellingPrice,
  String? productCreateDate,
  String? vendorId,
  List<String>? otherImage,
  String? productStatus,
  String? variantName,
  String? productType,
  String? tax,
  String? unit,
  dynamic id,
  dynamic cName,
  dynamic cNameA,
  dynamic icon,
  dynamic subTitle,
  dynamic description,
  dynamic img,
  List<dynamic>? otherImg,
  dynamic type,
  dynamic pId,
  dynamic serviceType,
}) => ProductsData(  productId: productId ?? _productId,
  catId: catId ?? _catId,
  subcatId: subcatId ?? _subcatId,
  childCategory: childCategory ?? _childCategory,
  productName: productName ?? _productName,
  productDescription: productDescription ?? _productDescription,
  productPrice: productPrice ?? _productPrice,
  productImage: productImage ?? _productImage,
  proRatings: proRatings ?? _proRatings,
  roleId: roleId ?? _roleId,
  sellingPrice: sellingPrice ?? _sellingPrice,
  productCreateDate: productCreateDate ?? _productCreateDate,
  vendorId: vendorId ?? _vendorId,
  otherImage: otherImage ?? _otherImage,
  productStatus: productStatus ?? _productStatus,
  variantName: variantName ?? _variantName,
  productType: productType ?? _productType,
  tax: tax ?? _tax,
  unit: unit ?? _unit,
  id: id ?? _id,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  otherImg: otherImg ?? _otherImg,
  type: type ?? _type,
  pId: pId ?? _pId,
  serviceType: serviceType ?? _serviceType,
);
  String? get productId => _productId;
  String? get catId => _catId;
  String? get subcatId => _subcatId;
  String? get childCategory => _childCategory;
  String? get productName => _productName;
  String? get productDescription => _productDescription;
  String? get productPrice => _productPrice;
  String? get productImage => _productImage;
  String? get proRatings => _proRatings;
  String? get roleId => _roleId;
  String? get sellingPrice => _sellingPrice;
  String? get productCreateDate => _productCreateDate;
  String? get vendorId => _vendorId;
  List<dynamic>? get otherImage => _otherImage;
  String? get productStatus => _productStatus;
  String? get variantName => _variantName;
  String? get productType => _productType;
  String? get tax => _tax;
  String? get unit => _unit;
  dynamic get id => _id;
  dynamic get cName => _cName;
  dynamic get cNameA => _cNameA;
  dynamic get icon => _icon;
  dynamic get subTitle => _subTitle;
  dynamic get description => _description;
  dynamic get img => _img;
  dynamic get otherImg => _otherImg;
  dynamic get type => _type;
  dynamic get pId => _pId;
  dynamic get serviceType => _serviceType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['cat_id'] = _catId;
    map['subcat_id'] = _subcatId;
    map['child_category'] = _childCategory;
    map['product_name'] = _productName;
    map['product_description'] = _productDescription;
    map['product_price'] = _productPrice;
    map['product_image'] = _productImage;
    map['pro_ratings'] = _proRatings;
    map['role_id'] = _roleId;
    map['selling_price'] = _sellingPrice;
    map['product_create_date'] = _productCreateDate;
    map['vendor_id'] = _vendorId;
    map['other_image'] = _otherImage;
    map['product_status'] = _productStatus;
    map['variant_name'] = _variantName;
    map['product_type'] = _productType;
    map['tax'] = _tax;
    map['unit'] = _unit;
    map['id'] = _id;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['product_image'] = _img;
    map['other_image'] = _otherImg;
    map['type'] = _type;
    map['p_id'] = _pId;
    map['service_type'] = _serviceType;
    return map;
  }

}