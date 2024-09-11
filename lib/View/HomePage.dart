import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient/Provider/HomeProvider.dart';
import 'package:patient/Provider/SelectHeightProvider.dart';
import 'package:provider/provider.dart';
import '../Provider/SelectGenderProvider.dart';
import '../Provider/SelectWeightProvider.dart';
import 'SelectGenderScreen.dart';
import 'SelectHeightPage.dart';
import 'SelectWeightPage.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  final List _totalPages = [
      const SelectGenderScreenPage(),
     const SelectWeightScreenPage(),
     const SelectHeightScreenPage(),
  ];
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {

    Color primaryColor = Theme.of(context).primaryColor;
    return WillPopScope(
    onWillPop: () async {
     return exitFunction();
    },
      child: SafeArea(
        child: Scaffold(
          body: Consumer<HomePageProvider>(
            builder: (context, homeProvider, child) {
              int activeIndex= homeProvider.currentStep;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (activeIndex > 0) {
                            homeProvider.setIndexVal(activeIndex-1);
                          }else{
                            exitFunction();
                          }
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Visibility(
                        visible:false,
                        child: TextButton(onPressed: (){
                          if (activeIndex != 1) {
                            homeProvider.setIndexVal(activeIndex++);
                          }
                        }, child: const Text("Skip")),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0,15,12,50),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              height: 4,
                              color: activeIndex >= 0?primaryColor:Colors.black12,
                            )
                        ),
                        const SizedBox(width: 5,),
                        Expanded(child: Container(height: 4,color: activeIndex >= 1?primaryColor:Colors.black12,)),
                        const SizedBox(width: 5,),
                        Expanded(child: Container(height: 4,color: activeIndex >= 2?primaryColor:Colors.black12,)),
                      ],
                    ),
                  ),

                  Text("Select your ${activeIndex==0?"Gender":activeIndex==1?"Weight":"height"}",
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  const Text("Help us to create your personalize plan",
                      style: TextStyle(color: Colors.black54,fontSize: 13,fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.6,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _totalPages.length,
                      physics: const NeverScrollableScrollPhysics(), // Disable horizontal scroll
                      itemBuilder: (context, index) {
                        return _totalPages[activeIndex];
                      },
                    ),
                  ),
                  nextButton(primaryColor),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

   nextButton(dynamic primaryColor) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryColor,width: 2)
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Material(
          shape: const CircleBorder(),
          color: primaryColor,
          child: IconButton(
            onPressed: _goToNextPage,
            icon: const Icon(Icons.arrow_forward,
              color: Colors.white,),
          ),
        ),
      ),
    );
  }

  void _goToNextPage() {
    final selectedHome = Provider.of<HomePageProvider>(context,listen: false);
    final selectedGen = Provider.of<SelectGenderProvider>(context,listen: false);
    final selectedWeight = Provider.of<WeightProvider>(context,listen: false);
    final selectedHeight = Provider.of<HeightProvider>(context,listen: false);

    if (selectedHome.currentStep<_totalPages.length-1) {
      if(selectedHome.currentStep==1 && selectedWeight.selectedWeightKg=="0"){
        Fluttertoast.showToast(msg: "Please Enter Weight",
        backgroundColor: Colors.yellowAccent,textColor: Colors.black);
      }else{
        selectedHome.setIndexVal(selectedHome.currentStep+1);
        _pageController.animateToPage(
          selectedHome.currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }else{
      // if height in fit
      /// selectedHeight.selectedHeightType==0?"${selectedHeight.selectedHeightCm}":"${selectedHeight.selectedFeet}""${selectedHeight.selectedInches}"
      // if height in fit Type
      /// selectedHeight.selectedHeightType==0?"Cm":"Ft-In"

      String gender =selectedGen.selectedOption==0?"Female":selectedGen.selectedOption==1?"Male":"Other";
      int height = selectedHeight.selectedHeightCm;
      String weightType = selectedWeight.selectedWeightType==0?"KG":"Lbs";
      String weight = selectedWeight.selectedWeightType==0?selectedWeight.selectedWeightKg:"${selectedWeight.selectedWeightLbs}";

      callApi(gender,height,weightType,weight,(int index){selectedHome.setIndexVal(0);});
    }
  }

  bool exitFunction() {
    final DateTime now = DateTime.now();
    final bool backButtonPressedTwice = lastPressed != null &&
        now.difference(lastPressed!) < const Duration(seconds: 2);

    if (backButtonPressedTwice) {
      return true; // Exit the app
    } else {
      lastPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false; // Prevent exit
    }
  }

  void callApi(Gender,height,weightType,weight,function) async{

    performTask(context);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVbWVzaCIsInJvbGVJZCI6MiwiZXhwIjoxNzU0NDU1MDY5LCJpYXQiOjE3MjI5MTkwNjl9.WwBZtiNMQAeerkqkQL2MQjNVyfAEn7gE8CzzU0XpCIE'
    };
    var request = http.Request('POST', Uri.parse('http://157.15.202.186:7002/patient/patient_info?patientId=73'));
    request.body = json.encode({
      "gender": Gender.toString(),
      "height": height,
      "heightType": "CM",
      "weight": double.parse(weight),
      "weightType": weightType.toString()
    });
   request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    Navigator.pop(context);

    if (response.statusCode == 200) {
     Fluttertoast.showToast(msg: "Data Successfully Submit.",
     backgroundColor: Colors.green,textColor: Colors.white);
     function(1);
    }
    else {
    print(response.reasonPhrase);
    }
  }


  Future<void> performTask(BuildContext context) async {
    // Show the loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(), // Loading spinner
              SizedBox(width: 20),
              Text('Loading...'), // Optional text
            ],
          ),
        );
      },
    );
  }

}