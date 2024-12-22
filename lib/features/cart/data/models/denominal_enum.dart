enum DenominalEnum {
  uangPas(
    label: 'Uang Pas',
    value: 0,
  ),
  fiftyThousands(
    label: 'Rp 50.000',
    value: 50000,
  ),
  oneHundredThousands(
    label: 'Rp 100.000',
    value: 100000,
  ),
  twoHundredThousands(
    label: 'Rp 200.000',
    value: 200000,
  ),
  threeHundredThousands(
    label: 'Rp 300.000',
    value: 300000,
  ),
  fiveHundredThousands(
    label: 'Rp 500.000',
    value: 500000,
  ),
  ;

  final String label;
  final num value;

  const DenominalEnum({
    required this.label,
    required this.value,
  });
}
