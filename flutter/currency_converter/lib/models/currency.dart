class Currency {
  String name; // Full name of the currency
  String shortname; // Abbreviation of the currency (e.g., USD)
  double _value; // Conversion rate

  Currency(this.name, this.shortname, this._value);

  // Getter for the conversion value
  double get value {
    return _value;
  }

  // Setter for the conversion value, ensures it's positive
  set value(double value) {
    if (value > 0) {
      _value = value;
    }
  }
}
