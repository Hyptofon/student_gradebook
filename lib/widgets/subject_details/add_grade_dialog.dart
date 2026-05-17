import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';
import '../../models/grade_form_data.dart';
import '../../models/grade_type.dart';
import '../../services/date_formatter.dart';
import '../../utils/validators.dart';

class AddGradeDialog extends StatefulWidget {
  final String subjectName;

  const AddGradeDialog({super.key, required this.subjectName});

  @override
  State<AddGradeDialog> createState() => _AddGradeDialogState();
}

class _AddGradeDialogState extends State<AddGradeDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _scoreController;
  late final TextEditingController _descriptionController;
  late DateTime _selectedDate;
  GradeType _selectedType = GradeType.exam;

  @override
  void initState() {
    super.initState();
    _scoreController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted || date == null) {
      return;
    }

    setState(() {
      _selectedDate = date;
    });
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final score = Validators.tryParseGrade(_scoreController.text);
    if (score == null) {
      return;
    }

    final formData = (
      date: _selectedDate,
      description: _descriptionController.text.trim(),
      score: score,
      type: _selectedType,
    );
    Navigator.of(context).pop<GradeFormData>(formData);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.addGradeTo(widget.subjectName)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _scoreController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: AppStrings.gradeScore,
                ),
                textInputAction: TextInputAction.next,
                validator: Validators.grade,
              ),
              const SizedBox(height: AppDimensions.spacing16),
              DropdownButtonFormField<GradeType>(
                initialValue: _selectedType,
                decoration: const InputDecoration(
                  labelText: AppStrings.gradeType,
                ),
                items: GradeType.values
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Row(
                          children: [
                            Icon(type.icon),
                            const SizedBox(width: AppDimensions.spacing8),
                            Text(type.label),
                          ],
                        ),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedType = value;
                  });
                },
              ),
              const SizedBox(height: AppDimensions.spacing16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: AppStrings.description,
                ),
                textInputAction: TextInputAction.done,
                validator: (value) => Validators.required(
                  value,
                  fieldName: AppStrings.description,
                ),
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: AppDimensions.spacing16),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      AppStrings.dateValue(
                        DateFormatter.dayMonthYear(_selectedDate),
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _selectDate,
                    child: const Text(AppStrings.select),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(onPressed: _submit, child: const Text(AppStrings.add)),
      ],
    );
  }
}
