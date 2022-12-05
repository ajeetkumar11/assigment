import 'package:assigment1/res/colors/colors.dart';
import 'package:assigment1/view_model/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../res/strings/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(builder: (context, viewModel, _) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: blackColor, width: 6),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myTextView(
                        Strings.totalNumberOfBoxes,
                        14,
                      ),
                      myTextFiled(viewModel.totalNoOfBoxes, (value) {
                        if (value.length != 0) {
                          viewModel.totalBoxValidation(success: () {
                            viewModel.generateBoxes();
                          });
                        }
                      }),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 4,
                  color: blackColor,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myTextView(
                        Strings.maxNoOfTotalSelections,
                        14,
                      ),
                      myTextFiled(viewModel.maxNoOfTotalSelections, (value) {
                        if (value.length != 0) {
                          viewModel.totalSelectionValidation();
                        }
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myTextView(
                        Strings.maxNoOfTAlphabets,
                        14,
                      ),
                      myTextFiled(viewModel.maxNoOfTAlphabets, (value) {
                        if (value.length != 0) {
                          viewModel.maxAlphabetsValidation();
                        }
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myTextView(
                        Strings.maxNoOfNumbers,
                        14,
                      ),
                      myTextFiled(viewModel.maxNoOfNumbers, (value) {
                        if (value.length != 0) {
                          viewModel.maxNumberValidation();
                        }
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: blackColor),
                          ),
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: viewModel.alphabetList.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                        value: viewModel
                                            .alphabetList[index].checkBoxValue,
                                        activeColor: blueColor,
                                        onChanged: (bool? checkBoxValue) {
                                          if (!checkBoxValue!) {
                                            viewModel
                                                .setAlphabetListCheckBoxValue(
                                                    index, checkBoxValue);
                                          } else {
                                            viewModel.checkBoxValidation(
                                                index, checkBoxValue, true);
                                          }
                                        }),
                                  ),
                                  myTextView(
                                      viewModel.alphabetList[index]
                                          .alphaBetAndNumber!,
                                      16,
                                      blackColor),
                                ],
                              );
                            }),
                      )),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 1.0, color: blackColor),
                            top: BorderSide(width: 1.0, color: blackColor),
                          ),
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: viewModel.numberList.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Transform.scale(
                                      scale: 1.4,
                                      child: Checkbox(
                                          value: viewModel
                                              .numberList[index].checkBoxValue,
                                          activeColor: blueColor,
                                          onChanged: (bool? checkBoxValue) {
                                            if (!checkBoxValue!) {
                                              viewModel
                                                  .setNumberListCheckBoxValue(
                                                      index, checkBoxValue);
                                            } else {
                                              viewModel.checkBoxValidation(
                                                  index, checkBoxValue, false);
                                            }
                                          }),
                                    ),
                                  ),
                                  myTextView(
                                      viewModel
                                          .numberList[index].alphaBetAndNumber!,
                                      16,
                                      blueColor),
                                ],
                              );
                            }),
                      )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.resetAllValue();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .1,
                        width: MediaQuery.of(context).size.width * .28,
                        color: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.only(left: 4),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            Strings.reset,
                            maxLines: 3,
                            style: const TextStyle(
                                fontSize: 14,
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                            textAlign: TextAlign.center,
                          ),
                        )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .1,
                        color: viewModel.buttonText == Strings.success
                            ? greenColor
                            : redColor,
                        padding: const EdgeInsets.only(left: 4),
                        child: Center(
                            child: Text(
                          viewModel.buttonText,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: viewModel.buttonText == Strings.success
                                  ? 26
                                  : 16,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget myTextView(String text,
      [double? fontSize, Color? color, TextAlign? textAlign]) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: Text(
          text,
          maxLines: 3,
          style: TextStyle(
              fontSize: 16,
              color: color ?? blackColor,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
          textAlign: textAlign ?? TextAlign.end,
        ),
      ),
    );
  }

  Widget myTextFiled([
    controller,
    onChangedFunction,
  ]) {
    return SizedBox(
        height: 30,
        width: 50,
        child: Center(
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: onChangedFunction,
            inputFormatters: [
              LengthLimitingTextInputFormatter(2),
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
          ),
        ));
  }
}
