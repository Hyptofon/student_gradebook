import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';
import '../../constants/seed_constants.dart';
import '../../models/subject_form_data.dart';
import '../../utils/validators.dart';

class AddSubjectDialog extends StatefulWidget {
  const AddSubjectDialog({super.key});

  @override
  State<AddSubjectDialog> createState() => _AddSubjectDialogState();
}

class _AddSubjectDialogState extends State<AddSubjectDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _iconController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _iconController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final formData = (
      name: _nameController.text.trim(),
      icon: _iconController.text.trim(),
    );
    Navigator.of(context).pop<SubjectFormData>(formData);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.addSubject),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: AppStrings.subjectName,
              ),
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  Validators.required(value, fieldName: 'Name'),
            ),
            const SizedBox(height: AppDimensions.spacing16),
            TextFormField(
              controller: _iconController,
              decoration: const InputDecoration(
                labelText: AppStrings.iconEmoji,
                hintText: SeedConstants.defaultSubjectIcon,
              ),
              textInputAction: TextInputAction.done,
              validator: (value) =>
                  Validators.required(value, fieldName: 'Icon'),
              onFieldSubmitted: (_) => _submit(),
            ),
          ],
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
