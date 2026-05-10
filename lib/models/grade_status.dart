enum GradeStatus {
  noData('No data', 'ND'),
  a('Excellent (A)', 'A'),
  b('Good (B)', 'B'),
  c('Good (C)', 'C'),
  d('Satisfactory (D)', 'D'),
  e('Satisfactory (E)', 'E'),
  fx('Unsatisfactory (FX)', 'FX'),
  f('Unsatisfactory (F)', 'F');

  const GradeStatus(this.label, this.shortLabel);

  final String label;
  final String shortLabel;

  static const gradedValues = <GradeStatus>[
    a,
    b,
    c,
    d,
    e,
    fx,
    f,
  ];

  static GradeStatus fromScore(double score) => switch (score) {
    >= 91 => a,
    >= 83 => b,
    >= 76 => c,
    >= 68 => d,
    >= 61 => e,
    >= 20 => fx,
    _ => f,
  };
}
