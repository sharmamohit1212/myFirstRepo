import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:patient/Provider/SelectWeightProvider.dart';
import 'package:provider/provider.dart';
class SelectWeightScreenPage extends StatefulWidget {
  const SelectWeightScreenPage({super.key});

  @override
  State<SelectWeightScreenPage> createState() => _SelectWeightScreenPageState();
}

class _SelectWeightScreenPageState extends State<SelectWeightScreenPage> {
  final double min = 0;
  final double max = 100;
  final List<int> weights = List.generate(301, (index) => index + 50);
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(25,0,25,0),
        child: Consumer<WeightProvider>(
          builder: (context, weightProvider, child){
            int weightType =weightProvider.selectedWeightType;
            return  Column(
              mainAxisSize: MainAxisSize.min,
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
                                backgroundColor:weightType==0?primaryColor:Colors.grey.shade200,
                              ),
                              onPressed: (){
                                weightProvider.selectedWeightCollectType(0);
                              },
                              child: Text("Kg",
                                style: TextStyle(color: weightType==0?Colors.white:Colors.grey.shade500),)
                          )
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:weightType==1?primaryColor:Colors.grey.shade200,
                              ),
                              onPressed: (){
                                weightProvider.selectedWeightCollectType(1);
                              },
                              child: Text("lbs",
                                style: TextStyle(color: weightType==1?Colors.white:Colors.grey.shade500),)
                          )
                      ),
                    ],
                  ),
                ),

                /// Weight in Kg  ......
                Visibility(
                  visible: weightType==0?true:false,
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height*.4,
                    child: AnimatedWeightPicker(
                      min: 0,
                      max: 100,
                      showSelectedValue: true,
                      selectedValueColor: primaryColor,
                      dialColor: primaryColor,
                      suffixTextColor: primaryColor,
                      onChange: (newValue) {
                        weightProvider.selectedWeightInKG(newValue);
                      },
                    ),
                  ),
                ),

                /// Weight in LBS  ......
                Visibility(
                  visible: weightType==1?true:false,
                  child: Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height*.4,
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListWheelScrollView.useDelegate(
                              controller: FixedExtentScrollController(initialItem: weightProvider.selectedWeightLbs - 50),
                              itemExtent: 50,
                              physics: const FixedExtentScrollPhysics(),
                              onSelectedItemChanged: (index) {
                                weightProvider.selectedWeightInLbs(weights[index]);
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                builder: (context, index) {
                                  return AnimatedBuilder(
                                    animation: Listenable.merge([FixedExtentScrollController()]),
                                    builder: (context, child) {
                                      return AnimatedOpacity(
                                        opacity: 1.0, // Keep this constant or adjust as needed for animation effect
                                        duration: const Duration(milliseconds: 300),
                                        child: Center(
                                          child: Text(
                                            '${weights[index]} lbs',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                childCount: weights.length,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: RichText(
                              text: TextSpan(
                                text: 'Selected Weight : ', // The first part of the text
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${weightProvider.selectedWeightLbs} lbs',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        )
    );
  }
}

