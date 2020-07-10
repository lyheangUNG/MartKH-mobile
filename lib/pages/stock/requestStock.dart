import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:martkh/services/product-api.dart';
import 'package:martkh/models/products.dart';
import 'package:martkh/services/stock-api.dart';
import 'package:martkh/themes/theme.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StockRequest extends StatefulWidget {
  @override
  _StockRequestState createState() => _StockRequestState();
}

class _StockRequestState extends State<StockRequest> {
  static List<Product> products = List<Product>();
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Product>> key = new GlobalKey();
  bool _loading = true;
  bool _isSubmitting = false;
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    getProducts();
    super.initState();
  }
  
  getProducts() async {
    var result = await Products.fetchProductList();
    // print(result[0].name);
    // print(result.length);
    setState((){
      products = result;
      _loading = false;
    });
  }

  Widget row(Product product){
    return Row(
      children: <Widget>[
        Text(
          product.name,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
        // SizedBox(width:10),
      ],
    );
  }

  Widget _buildProductNameTF() {
    // print(products[0].name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          // 'Product Name',
          'productname'.tr().toString(),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: _loading? Center(child:CircularProgressIndicator()) : 
          searchTextField = AutoCompleteTextField<Product>(
            itemSubmitted: (item){
              setState(() {
                searchTextField.textField.controller.text = item.name;
              });
            }, 
            key: key, 
            clearOnSubmit: false,
            suggestions: products,  
            itemBuilder: (context,item){
              // print(item.name);
              return row(item);
            }, 
            itemSorter: (a,b){
              return a.name.compareTo(b.name);
            }, 
            itemFilter: (item,query){
              return item.name.toLowerCase().startsWith(query.toLowerCase());
            },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.local_mall,
                color: Colors.white,
              ),
              // hintText: 'Enter a Product Name',
              hintText: 'enterproductname'.tr().toString(),
              hintStyle: kHintTextStyle,
            ),
          ),
          // TextField(
          //   // controller: nameController,
          //   keyboardType: TextInputType.text,
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontFamily: 'OpenSans',
          //   ),
          //   decoration: InputDecoration(
          //     border: InputBorder.none,
          //     contentPadding: EdgeInsets.only(top: 14.0),
          //     prefixIcon: Icon(
          //       Icons.local_mall,
          //       color: Colors.white,
          //     ),
          //     hintText: 'Enter a Product Name',
          //     hintStyle: kHintTextStyle,
          //   ),
          // ),
        ),
      ],
    );
  }

  Widget _buildAmountTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          // 'Amount',
          'amount'.tr().toString(),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: amountController,
            // keyboardType: TextInputType.text,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.category,
                color: Colors.white,
              ),
              // hintText: 'Enter the amount',
              hintText: 'enteramount'.tr().toString(),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
          requestStock();
          // Phoenix.rebirth(context);       
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          // "request",
          _isSubmitting? 'request'.tr().toString()+"..." :'request'.tr().toString(),
          // _isLoading ? 'Saving...' : 'Save',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(products);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color(0xFF73AEF5),
                  //     Color(0xFF61A4F1),
                  //     Color(0xFF478DE0),
                  //     Color(0xFF398AE5),
                  //   ],
                  //   stops: [0.1, 0.4, 0.7, 0.9],
                  // ),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFFB6340),
                      Color(0xFFFBB140),
                    ],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 100.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            // color: Colors.black54,
                            // size: 15,
                            // padding: 12,
                            // isOutLine: true,
                            onTap: () {
                              Navigator.of(context).pop();
                              // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageCLickedEvent);
                            },
                          ),
                          // SizedBox(width: MediaQuery.of(context).size.width/5),
                        ],
                      ),
                      Text(
                        // 'Request Stock',
                        'requeststock'.tr().toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildProductNameTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildAmountTF(),
                      // _buildPasswordTF(),
                      // _buildForgotPasswordBtn(),
                      // _buildRememberMeCheckbox(),
                      _buildRequestBtn(),
                      // _buildSignInWithText(),
                      // _buildSocialBtnRow(),
                      // _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  void requestStock() async{
    setState(() {
      _isSubmitting = true;
    });
    var franchiseId = await StockApi().getData('franchiseStockId/?uid=');

    var data = {
      'product_name': searchTextField.textField.controller.text,
      'amount': amountController.text,
      'franchise_id' : franchiseId,
    };
    // print(data);
    var res = await StockApi().postData(data, 'requestStock');
    var body = json.decode(res.body);
    print(body);
    // // print(body['message']);
    // // _showMsg(body['messsage']);
    if (body['success']) {
      Navigator.pop(context);
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Request Failed",
        desc: body['message'],
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }

    setState(() {
      _isSubmitting = false;
    });
  }
}