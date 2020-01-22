class Validator{

  String _errorText;

  Validator(){
    this._errorText = "";
  }

  ///validates if the day exists
  bool validateDay(int day, int month){
    if (day < 0){
      _errorText  = " Bitte gib einen korrekten Tag an";
      return false;
    } else if (month == 2 && day > 29) {
      _errorText = "Bitte gib einen korrekten Tag an";
      return false;
    } else if ((month%2) != 0 && day > 31){
      _errorText = "Bitte gib einen korrekten Tag an";
      return false;
    } else if ((month%2) == 0 && day > 30){
      _errorText = "Bitte gib einen korrekten Monat an";
      return false;
    }
    return true;
  }

  ///checks that the given int is a month starting with 1 for january
  bool validateMonth(int month){
    print("Monat :P");
    if (month < 1) {
      _errorText = "Bitte gib einen korrekten Monat an";
      return false;
    } else if (month > 12){
      _errorText = "Bitte gib einen korrekten Monat an";
      return false;
    }
    return true;
  }

  ///checks if the year is correct
  bool validateYear(int year){
    if (year < 1850){
      _errorText = "Bitte gib einen korrekten Monat an";
      return false;
    } else if (year > DateTime.now().year){
      _errorText = "Bitte gib ein korrektes Jahr an";
      return false;
    }
    return true;
  }

  ///validates an email
  bool validateMail(String mail){
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mail)){
      _errorText = "Bitte gib eine korrekte Email an";
      return false;
    }
    return true;
  }

  ///validates if the training days os over 7 days
  bool validateDaysPerWeek(int days){
    if (days < 0){
      _errorText = "Bitte gib einen Wert größer als 1 an.";
      return false;
    } else if (days > 7){
      _errorText = "Aus gesundheitlichen Gründen werden nicht mehr als 7 Trainingstage pro Woche unterstützt.";
      return false;
    }
    return true;
  }

  ///checks if the given weight can be correct
  bool validateWeight(double weight){
    print("weight $weight");
    if (weight < 30){
      _errorText = "Bitte gib für dein Gewicht einen Wert größer als 30 an.";
      return false;
    } else if (weight > 200){
      _errorText = "Bitte gib für dein Gewicht einen Wert kleiner als 200 an.";
      return false;
    }
    return true;
  }

  ///checks if the give size can be correct
  bool validateSize(int size){
    if (size < 30){
      _errorText = "Bitte gib für deine Größe mit einem Wert größer als 30 an.";
      return false;
    } else if (size > 300){
      _errorText = "Bitte gib für deine Größe einen Wert kleiner als 300 an.";
      return false;
    }
    return true;
  }

  ///checks if the birthday can be used for registration
  bool validateBirthday(DateTime birth){
    if (birth.isAfter(DateTime.now())){
      _errorText = "Bitte gib einen korrekten Wert an.";
      return false;
    }
    return true;
  }

  ///returns a string containing why one of the above methods returned false
  String getErrorText(){
    return _errorText;
  }
}