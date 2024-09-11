import 'package:flutter/material.dart';
import 'package:patient/Provider/SelectHeightProvider.dart';
import 'package:provider/provider.dart';
class SelectHeightScreenPage extends StatelessWidget {
   const SelectHeightScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(25,0,25,0),
      child: Consumer<HeightProvider>(
        builder: (context, heightProvider, child) {
          int heightType =heightProvider.selectedHeightType;
          int cm =heightProvider.selectedHeightCm;
          int ft =heightProvider.selectedFeet;
          int inch =heightProvider.selectedInches;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200,
                ),
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:heightType==0?primaryColor:Colors.grey.shade200,
                            ),
                            onPressed: (){
                              heightProvider.selectedHeightCollectType(0);

                            },
                            child: Text("Cm",
                              style: TextStyle(color: heightType==0?Colors.white:Colors.grey.shade500),)
                        )
                    ),
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:heightType==1?primaryColor:Colors.grey.shade200,
                            ),
                            onPressed: (){
                              heightProvider.selectedHeightCollectType(1);
                            },
                            child: Text("Ft-in",
                              style: TextStyle(color: heightType==1?Colors.white:Colors.grey.shade500),)
                        )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Image.asset("assets/hight.png")),
                      Visibility(
                        visible: heightType==0?true:false,
                        child: Flexible(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height*.4,
                            width: 150,
                            child: ListWheelScrollView.useDelegate(
                              controller: FixedExtentScrollController(initialItem: heightProvider.selectedHeightCm - 50),
                              itemExtent: 40,
                              physics: const FixedExtentScrollPhysics(),
                              onSelectedItemChanged: (index) {
                                heightProvider.selectedHeightInCm(index + 50);
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                builder: (context, index) {
                                  return Center(
                                    child: Text(
                                      '${index + 50} cm', // Display height from 50 to 250 cm
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  );
                                },
                                childCount: 201, // Allows for a range of 50 cm to 250 cm
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: heightType==1?true:false,
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Feet Picker
                              SizedBox(
                                width: 70,
                                height: MediaQuery.of(context).size.height*.4,
                                child: ListWheelScrollView.useDelegate(
                                  controller: FixedExtentScrollController(initialItem: ft - 1),
                                  itemExtent: 40,
                                  physics: const FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (index) {
                                    heightProvider.selectedHeightInFt(index+1);
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    builder: (context, index) {
                                      return Center(
                                        child: Text(
                                          '${index + 1} ft',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      );
                                    },
                                    childCount: 8, // Limits feet from 1 to 8 ft
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 70,
                                height: MediaQuery.of(context).size.height*.4,
                                child: ListWheelScrollView.useDelegate(
                                  controller: FixedExtentScrollController(initialItem: inch),
                                  itemExtent: 40,
                                  physics: const FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (index) {
                                    heightProvider.selectedHeightInIn(index);
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    builder: (context, index) {
                                      return Center(
                                        child: Text(
                                          '$index in',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      );
                                    },
                                    childCount: 12, // Inches from 0 to 11
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                  ),
              ),
              const SizedBox(height: 20,),
              RichText(
                text: TextSpan(
                  text: 'Selected Height : ', // The first part of the text
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: heightType==0?"$cm cm":"$ft ft $inch in",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
