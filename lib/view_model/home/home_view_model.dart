import 'package:assigment1/model/home_model/home_model.dart';
import 'package:flutter/material.dart';

import '../../res/strings/strings.dart';

class HomeViewModel with ChangeNotifier {
  TextEditingController totalNoOfBoxes = TextEditingController();
  TextEditingController maxNoOfTotalSelections = TextEditingController();
  TextEditingController maxNoOfTAlphabets = TextEditingController();
  TextEditingController maxNoOfNumbers = TextEditingController();

  List<HomeModel> alphabetList = [];
  List<HomeModel> numberList = [];

  String buttonText = Strings.pleaseEnterTotalNumberOfBoxes;

  int maxNumberOfBOxes = 11;

  resetAllValue() {
    totalNoOfBoxes.clear();
    maxNoOfTotalSelections.clear();
    maxNoOfTAlphabets.clear();
    maxNoOfNumbers.clear();
    alphabetList.clear();
    numberList.clear();
    buttonText = Strings.totalBoxesError;
    notifyListeners();
  }

  setButtonText(value) {
    buttonText = value;
    notifyListeners();
  }

  setNumberListCheckBoxValue(index, checkBoxValue) {
    numberList[index].checkBoxValue = checkBoxValue;
    setButtonText(Strings.success);
    notifyListeners();
  }

  setAlphabetListCheckBoxValue(index, checkBoxValue) {
    alphabetList[index].checkBoxValue = checkBoxValue;
    setButtonText(Strings.success);
    notifyListeners();
  }

  generateBoxes() {
    if (int.parse(totalNoOfBoxes.text.trim()) is num) {
      numberList.clear();
      alphabetList.clear();
      for (int i = 1; i <= int.parse(totalNoOfBoxes.text.trim()); i++) {
        numberList.add(
            HomeModel(alphaBetAndNumber: i.toString(), checkBoxValue: false));
      }
      for (int i = 65; i < 65 + (int.parse(totalNoOfBoxes.text.trim())); i++) {
        alphabetList.add(HomeModel(
            alphaBetAndNumber: String.fromCharCode(i), checkBoxValue: false));
      }
      notifyListeners();
    }
  }

  totalBoxValidation({Function? success}) {
    if (int.parse(totalNoOfBoxes.text.trim()) > 11) {
      buttonText = Strings.onlyMax11;
      notifyListeners();
      return;
    }
    buttonText = Strings.success;
    notifyListeners();
    success!();
  }

  totalSelectionValidation() {
    if (int.parse(maxNoOfTotalSelections.text.trim()) >
        int.parse(totalNoOfBoxes.text.trim()) * 2) {
      buttonText = Strings.maximumSelectionsInBoxError(
          int.parse(totalNoOfBoxes.text.trim()) * 2);
      notifyListeners();
      return;
    }
    buttonText = Strings.success;
    notifyListeners();
  }

  maxAlphabetsValidation() {
    if (int.parse(maxNoOfTAlphabets.text.trim()) >
        int.parse(totalNoOfBoxes.text.trim())) {
      buttonText = Strings.maximumAlphabetInBoxError(
          int.parse(totalNoOfBoxes.text.trim()));
      notifyListeners();
      return;
    }
    buttonText = Strings.success;
    notifyListeners();
  }

  maxNumberValidation() {
    if (int.parse(maxNoOfNumbers.text.trim()) >
        int.parse(totalNoOfBoxes.text.trim())) {
      buttonText = Strings.maximumNumberInBoxError(
          int.parse(totalNoOfBoxes.text.trim()));
      notifyListeners();
      return;
    }
    buttonText = Strings.success;
    notifyListeners();
  }

  checkBoxValidation(index, checkboxValue, isAlphabet) {
    int totalCheckBoxSelected = 0;
    int alphabetCheckBoxValue = 0;
    int numberCheckBoxSelected = 0;
    if (int.parse(totalNoOfBoxes.text.trim()) > 11) {
      buttonText = Strings.onlyMax11;
      notifyListeners();
      return;
    } else if (maxNoOfTotalSelections.text.trim().isNotEmpty) {
      if (int.parse(maxNoOfTotalSelections.text.trim()) >
          int.parse(totalNoOfBoxes.text.trim()) * 2) {
        buttonText = Strings.maximumSelectionsInBoxError(
            int.parse(totalNoOfBoxes.text.trim()) * 2);
        notifyListeners();
        return;
      }
    } else if (maxNoOfTAlphabets.text.trim().isNotEmpty) {
      if (int.parse(maxNoOfTAlphabets.text.trim()) >
          int.parse(totalNoOfBoxes.text.trim())) {
        buttonText = Strings.maximumAlphabetInBoxError(
            int.parse(totalNoOfBoxes.text.trim()));
        notifyListeners();
        return;
      }
    } else if (maxNoOfNumbers.text.trim().isNotEmpty) {
      if (int.parse(maxNoOfNumbers.text.trim()) >
          int.parse(totalNoOfBoxes.text.trim())) {
        buttonText = Strings.maximumNumberInBoxError(
            int.parse(totalNoOfBoxes.text.trim()));
        notifyListeners();
        return;
      }
    }

    for (int i = 0; i < alphabetList.length; i++) {
      if (alphabetList[i].checkBoxValue!) {
        totalCheckBoxSelected++;
        alphabetCheckBoxValue++;
      }
    }
    for (int i = 0; i < numberList.length; i++) {
      if (numberList[i].checkBoxValue!) {
        totalCheckBoxSelected++;
        numberCheckBoxSelected++;
      }
    }
    if (totalCheckBoxSelected >=
        int.parse(maxNoOfTotalSelections.text.trim())) {
      buttonText =
          Strings.unableTotSelectSelections(maxNoOfTotalSelections.text.trim());
      notifyListeners();
      return;
    } else if (alphabetCheckBoxValue >=
            int.parse(maxNoOfTAlphabets.text.trim()) &&
        isAlphabet) {
      buttonText =
          Strings.unableTotSelectAlphabet(maxNoOfTAlphabets.text.trim());
      notifyListeners();
      return;
    } else if (numberCheckBoxSelected >=
        int.parse(maxNoOfNumbers.text.trim())) {
      buttonText = Strings.unableTotSelectNumber(maxNoOfNumbers.text.trim());
      notifyListeners();
      return;
    } else if (alphabetCheckBoxValue <
            int.parse(maxNoOfTAlphabets.text.trim()) &&
        isAlphabet!) {
      setAlphabetListCheckBoxValue(index, checkboxValue);
    } else if (numberCheckBoxSelected < int.parse(maxNoOfNumbers.text.trim()) &&
        !isAlphabet) {
      setNumberListCheckBoxValue(index, checkboxValue);
    }
    buttonText = Strings.success;
    notifyListeners();
  }
}
