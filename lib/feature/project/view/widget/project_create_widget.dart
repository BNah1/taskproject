import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';
import 'package:taskproject/feature/project/state/project_state.dart';

class ProjectCreateWidget extends StatefulWidget {
  const ProjectCreateWidget({super.key});

  @override
  State<ProjectCreateWidget> createState() => _ProjectCreateWidgetState();
}

class _ProjectCreateWidgetState extends State<ProjectCreateWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String? _selectedType;
  String? _selectedUrgency;
  DateTime? _deadline;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final user = context.read<AuthenticationCubit>().state.userModel!;

    if (!_formKey.currentState!.validate() || _deadline == null) return;

    final cubit = context.read<ProjectCubit>();

    await cubit.addProject(
      projectName: _nameCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      taskDeadLine: _deadline!,
      type: _selectedType!,
      urgent: _selectedUrgency!,
      typeProcess: 'TODO',
      taskCreatedBy: user,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.paddingDashBoard,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _input(_nameCtrl, 'Project name'),
            const SizedBox(height: 10),
            _input(_descCtrl, 'Description'),
            const SizedBox(height: 10),
            _dropdownField(
              label: 'Type',
              value: _selectedType,
              options: typeOptions,
              onChanged: (val) => setState(() => _selectedType = val),
            ),
            const SizedBox(height: 10),
            _dropdownField(
              label: 'Urgency',
              value: _selectedUrgency,
              options: urgencyOptions,
              onChanged: (val) => setState(() => _selectedUrgency = val),
            ),

            const SizedBox(height: 10),
            _datePicker(),
            const SizedBox(height: 10),
            InkWell(
              onTap: _onSubmit,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.paddingDashBoard,vertical: AppSize.paddingDashBoard
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.blue,
                ),
                child: Center(child: Text('Submit',style: AppTextStyle.textTitleTask(Colors.white),)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _input(TextEditingController ctrl, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.textTitleTask(Colors.black)),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingDashBoard,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.black12,
          ),
          child: TextFormField(
            controller: ctrl,
            decoration: const InputDecoration(
              icon: Icon(Icons.text_fields, color: Colors.grey),
            ),
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
          ),
        ),
      ],
    );
  }

  Widget _datePicker() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        _deadline != null
            ? 'Deadline: ${_deadline!.toLocal().toString().split(' ')[0]}'
            : 'Pick a deadline', style: AppTextStyle.textTitleTask(Colors.black),
      ),
      trailing: const Icon(Icons.date_range),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() => _deadline = picked);
        }
      },
    );
  }

  Widget _dropdownField({
    required String label,
    required String? value,
    required List<String> options,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.textTitleTask(Colors.black)),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingDashBoard,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.black12,
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              icon: Icon(Icons.text_fields, color: Colors.grey),
            ),
            items: options
                .map(
                  (option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
          ),
        ),
      ],
    );
  }
}
