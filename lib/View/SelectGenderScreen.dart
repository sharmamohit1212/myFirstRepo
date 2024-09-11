import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/SelectGenderProvider.dart';
class SelectGenderScreenPage extends StatelessWidget {
  const SelectGenderScreenPage({super.key});


  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(25,0,25,0),
        child: Consumer<SelectGenderProvider>(
          builder: (context, radioButtonProvider, child){
            int selectGen =radioButtonProvider.selectedOption;
            return  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topRight,
                      children: [
                        InkWell(
                            onTap: () {
                              radioButtonProvider.setSelectedOption(0);
                            },
                            child: Image.asset("assets/gender_female.png")
                        ),
                        Visibility(
                          visible: selectGen!=0?false:true,
                          child: Positioned(
                            right: -20,
                            top: -20,
                            child: Radio(
                              value: 0,
                              activeColor: primaryColor,
                              groupValue: selectGen,
                              onChanged: (value) {
                                selectGen = value!;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topRight,
                      children: [
                        InkWell(
                            onTap: () {
                              radioButtonProvider.setSelectedOption(1);
                            },
                            child: Image.asset("assets/gender_male.png")),
                        Visibility(
                          visible: selectGen!=1?false:true,
                          child: Positioned(
                            right: -20,
                            top: -20,
                            child: Radio(
                              value: 1,
                              groupValue: selectGen,
                              activeColor: primaryColor,
                              onChanged: (value) {
                                selectGen = value!;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: InkWell(
                    onTap: () {
                      radioButtonProvider.setSelectedOption(2);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                      decoration: BoxDecoration(
                        boxShadow: ([
                          BoxShadow(
                            color: Colors.grey.shade50,
                            blurRadius: 2,
                            spreadRadius: 2,
                          )
                        ]),
                        color: selectGen==2?primaryColor:Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child:  Text("Other",
                        style: TextStyle(fontWeight: FontWeight.bold,
                          color: selectGen==2?Colors.white:Colors.black,),),),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200,
                  ),
                  height: 40,
                  child: Row(
                    children: [
                      genderElevatedButton(context,0,"Female",selectGen,(int index){
                        radioButtonProvider.setSelectedOption(0);
                      }),
                      genderElevatedButton(context,1,"Male",selectGen,(int index){
                        radioButtonProvider.setSelectedOption(1);
                      }),
                      genderElevatedButton(context,2,"Others",selectGen,(int index){
                        radioButtonProvider.setSelectedOption(2);
                      }),
                    ],
                  ),
                )
              ],
            );
          },
        )
    );
  }

  genderElevatedButton(context,index,txt,selectGen,function) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color btnColor = selectGen==index?primaryColor:Colors.grey.shade200;
    Color txtColor = selectGen==index?Colors.white:Colors.grey.shade500;

    return Expanded(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor:btnColor,
            ),
            onPressed: (){
              function(1);
            },
            child: Text(txt,
              style: TextStyle(color: txtColor),)
        )
    );
  }
}
