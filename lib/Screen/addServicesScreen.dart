

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:hojayega_seller/Model/CategoryModel.dart';
import 'package:hojayega_seller/Model/GetVendorServicesModel.dart';

import 'package:http/http.dart'as http;

import 'package:hojayega_seller/Helper/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddServicesScreen extends StatefulWidget {
  final String categoryId;
  Service? service;
  String? name;
  final bool isUpdate;
   AddServicesScreen({Key? key,required this.isUpdate, required this.categoryId, this.service,this.name,}) : super(key: key);

  @override
  State<AddServicesScreen> createState() => _AddServicesScreenState();
}

class _AddServicesScreenState extends State<AddServicesScreen> {

  final TextEditingController headingController = TextEditingController();
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController servicePriceController = TextEditingController();
  final TextEditingController serviceSpecialPriceController = TextEditingController();
  List<DynamicTextFieldsCardWidget> listDynamicTextFieldsCard = [];
       List<Widget> services = [];
  List<Map<String,String>> serviceData = [];
  // List<String> headings =[];
  List<String> serviceNames =[];
  List<String> prices =[];
  List<String> specialPrices =[];
  List formKeys =[GlobalKey<FormState>()];
  final headingFormKey = GlobalKey<FormState>();

  String? vendorId;
  int index = 1;
  addServicesVendor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=2af0bd20724524e1ebfba0e830885dbff718f536'
    };
    var data =<String,String> {
      'name':headingController.text,
      'category_id':widget.categoryId,
      'service_name':serviceNames.join(','),
      'mrp_price':prices.join(','),
      'special_price':specialPrices.join(','),
      'vendor_id':vendorId.toString(),
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiServicves.addServicesVendor));
    request.fields.addAll(data);
    debugPrint("=========add Services fieldsss======${request.fields}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var finalResult = jsonDecode(finalResponse);
      debugPrint("addd service  responsee $finalResult");
      debugPrint("add service responsee $finalResponse");
      Fluttertoast.showToast(msg: "${finalResult['message']}, Please activate this service ");
      Navigator.pop(context);

    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  updateServicesVendor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=2af0bd20724524e1ebfba0e830885dbff718f536'
    };
    var data =<String,String> {
      'name':headingController.text,
      'category_id':widget.categoryId,
      'service_name':serviceNameController.text,
      'service_id':widget.service!.id.toString(),
      'mrp_price':servicePriceController.text,
      'special_price':serviceSpecialPriceController.text,
      'vendor_id':vendorId.toString(),
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiServicves.updateServicesVendor));
    request.fields.addAll(data);
    debugPrint("=========update Services fieldsss======${request.fields}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var finalResult = jsonDecode(finalResponse);
      debugPrint("update service  responsee $finalResult");
      debugPrint("update service responsee $finalResponse");
      Fluttertoast.showToast(msg: finalResult['message']);
      Navigator.pop(context);

    } else {
      debugPrint(response.reasonPhrase);
    }
  }
  

    addDynamicTextFieldsCard() {
    formKeys.add(GlobalKey<FormState>());
    listDynamicTextFieldsCard.add( DynamicTextFieldsCardWidget(formKey: formKeys[index],));
    setState(() {
      index++;
    });
  }

  submitServiceData(){
     for(DynamicTextFieldsCardWidget widget in listDynamicTextFieldsCard){
       serviceNames.add(widget.serviceNameController.text);
       prices.add(widget.servicePriceController.text);
       specialPrices.add(widget.serviceSpecialPriceController.text);
       serviceData.add({
         "heading" : headingController.text,
         "service_name" : widget.serviceNameController.text,
         "service_price" : widget.servicePriceController.text,
         "service_special_price" : widget.serviceSpecialPriceController.text,
       });
     }

       debugPrint("service data $serviceData, heading${headingController.text}, serviceNames$serviceNames  prices$prices special prices $specialPrices");


    // listDynamicTextFieldsCard.forEach((widget) => serviceData.add({
    //   "heading" : widget.headingController.text,
    //   "service_name" : widget.serviceNameController.text,
    //   "service_price" : widget.servicePriceController.text,
    // }));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listDynamicTextFieldsCard.add( DynamicTextFieldsCardWidget(formKey: formKeys.first,));
    if(widget.isUpdate){
      headingController.text = widget.name.toString();
      serviceNameController.text = widget.service!.serviceName.toString();
      servicePriceController.text =widget.service!.mrpPrice.toString();
      serviceSpecialPriceController.text = widget.service!.specialPrice.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.all(8),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: colors.primary,)),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        title: const Text('Add Services'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 6,
                  // borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                          color: colors.primary
                      )
                  ),
                  child:Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Form(
                      key: headingFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Heading :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          const SizedBox(height: 4,),
                          TextFormField(
                            controller: headingController ,
                            decoration: const InputDecoration(
                                border:OutlineInputBorder(),
                                isDense: true
                            ),
                            validator: (val){
                              if(val ==null || val.isEmpty || val ==""){
                                return "required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8,),
                          widget.isUpdate?Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Service Name : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(height: 4,),
                                TextFormField(
                                  controller: serviceNameController ,
                                  decoration: const InputDecoration(
                                      border:OutlineInputBorder(),
                                      isDense: true
                                  ),
                                  validator: (val){
                                    if(val ==null || val.isEmpty || val ==""){
                                      return "required";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 4,),
                                const Text("Price :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(height: 4,),
                                TextFormField(
                                  controller: servicePriceController ,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border:OutlineInputBorder(),
                                      isDense: true
                                  ),
                                  validator: (val){
                                    if(val ==null || val.isEmpty || val ==""){
                                      return "required";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 4,),
                                const Text("Special Price :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(height: 4,),
                                TextFormField(
                                  controller: serviceSpecialPriceController ,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border:OutlineInputBorder(),
                                      isDense: true
                                  ),
                                  validator: (val){
                                    if(val ==null || val.isEmpty || val ==""){
                                      return "required";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 4,),
                              ]

                          ):const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ) ,
                ),

                const SizedBox(height: 4,),
               widget.isUpdate? const SizedBox.shrink(): ListView.builder(
                   itemCount: listDynamicTextFieldsCard.length,
                   physics: const NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   itemBuilder: (_,index){
                     return listDynamicTextFieldsCard[index];
                   }
               ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: widget.isUpdate?const SizedBox.shrink():FloatingActionButton(
        onPressed: addDynamicTextFieldsCard,
        tooltip: "Add More",
        backgroundColor: colors.primary,
        child: const Icon(Icons.add),

      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize:  const Size(150, 32),
              backgroundColor: colors.primary,
            ),
              onPressed: (){
                if(widget.isUpdate && headingFormKey.currentState!.validate()){
                  updateServicesVendor();
                }else{
                  if(validateForms() && headingFormKey.currentState!.validate()){
                    submitServiceData();
                    addServicesVendor();
                  }
                  else{
                    Fluttertoast.showToast(msg: "All fields are required ");
                  }
                }
              },
              child:  Text(widget.isUpdate?"Update":"Submit")),
        ],
      ),
    );
  }
  bool validateForms(){
    List isValidateForms =[];
    for(var formKey in formKeys){
      if(formKey.currentState!.validate()){
        isValidateForms.add(true);
      }
      else{
        isValidateForms.add(false);
      }
    }
    bool validate = !isValidateForms.contains(false);
    return validate;
  }
}



class DynamicTextFieldsCardWidget extends StatelessWidget {
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController servicePriceController = TextEditingController();
  final TextEditingController serviceSpecialPriceController = TextEditingController();
 final formKey;
  DynamicTextFieldsCardWidget({super.key, required this.formKey});
  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 6,
      // borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: colors.primary
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        child: Form(
          key: formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Service Name : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                const SizedBox(height: 4,),
                TextFormField(
                  controller: serviceNameController ,
                  decoration: const InputDecoration(
                      border:OutlineInputBorder(),
                      isDense: true
                  ),
                  validator: (val){
                  if(val ==null || val.isEmpty || val ==""){
                    return "required";
                  }
                  return null;
                },
                ),
                const SizedBox(height: 4,),
                const Text("Price :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                const SizedBox(height: 4,),
                TextFormField(
                  controller: servicePriceController ,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border:OutlineInputBorder(),
                      isDense: true
                  ),
                  validator: (val){
                    if(val ==null || val.isEmpty || val ==""){
                      return "required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 4,),
                const Text("Special Price :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                const SizedBox(height: 4,),
                TextFormField(
                  controller: serviceSpecialPriceController ,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border:OutlineInputBorder(),
                      isDense: true
                  ),
                  validator: (val){
                    if(val ==null || val.isEmpty || val ==""){
                      return "required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 4,),
              ]

          ),
        ),
      ),
    );
  }
}
