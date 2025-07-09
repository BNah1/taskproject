import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';
import 'package:taskproject/feature/task/state/task_state.dart';
import 'package:taskproject/model/project_model.dart';

class TaskCreateWidget extends StatefulWidget {
  const TaskCreateWidget({super.key});

  @override
  State<TaskCreateWidget> createState() => _TaskCreateWidgetState();
}

class _TaskCreateWidgetState extends State<TaskCreateWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String? _selectedType;
  String? _selectedUrgency;
  DateTime? _deadlineMin;
  DateTime? _deadlineMax;
  final List<ProjectModel> listProject = MockData.listProjectMock;
  String? _selectedProjectId;
  final double sizeHeight = 50;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final user = context.read<AuthenticationCubit>().state.userModel!;

    if (!_formKey.currentState!.validate() ||
        _deadlineMin == null ||
        _deadlineMax == null ||
        _selectedProjectId == null) {
      return;
    }

    final cubit = context.read<TaskCubit>();

    await cubit.addTask(
      taskName: _nameCtrl.text.trim(),
      taskDeadLineMin: _deadlineMin!,
      taskDeadLineMax: _deadlineMax!,
      taskCreatedBy: user,
      descriptions: _descCtrl.text.trim(),
      urgent: _selectedUrgency ?? '',
      projectId: _selectedProjectId!,
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
            _input(_nameCtrl, 'Task name'),
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
            _projectDropdown(),
            const SizedBox(height: 10),
            _timePicker(
              label: 'Deadline Min',
              current: _deadlineMin,
              onPick: (dt) => setState(() => _deadlineMin = dt),
            ),
            _timePicker(
              label: 'Deadline Max',
              current: _deadlineMax,
              onPick: (dt) => setState(() => _deadlineMax = dt),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: _onSubmit,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSize.paddingDashBoard),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: AppTextStyle.textTitleTask(Colors.white),
                  ),
                ),
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
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingDashBoard,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.black12,
          ),
          child: SizedBox(
            height: sizeHeight,
            child: TextFormField(
              style: AppTextStyle.textTitleTask(Colors.black),
              controller: ctrl,
              decoration: const InputDecoration(
                icon: Icon(Icons.text_fields, color: Colors.grey),
                border: InputBorder.none,
              ),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Required' : null,
            ),
          ),
        ),
      ],
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
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingDashBoard,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.black12,
          ),
          child: SizedBox(
            height: sizeHeight,
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: const InputDecoration(
                icon: Icon(Icons.text_fields, color: Colors.grey),
                border: InputBorder.none,
              ),
              icon: const SizedBox.shrink(),
              items: options
                  .map(
                    (option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
              validator: (val) =>
                  val == null || val.isEmpty ? 'Required' : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _projectDropdown() {
    return _dropdownField(
      label: 'Project',
      value: _selectedProjectId,
      options: listProject.map((p) => p.projectId).toList(),
      onChanged: (val) => setState(() => _selectedProjectId = val),
    );
  }

  Widget _timePicker({
    required String label,
    required DateTime? current,
    required void Function(DateTime) onPick,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project deadline',
          style: AppTextStyle.textTitleTask(Colors.black),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingDashBoard,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.black12,
          ),
          child: InkWell(
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                if (mounted) {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                  );
                  if (pickedTime != null) {
                    final fullDateTime = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                    onPick(fullDateTime);
                  }
                }
              }
            },
            child: SizedBox(
              height: sizeHeight,
              child: Row(
                children: [
                  const Icon(Icons.date_range, color: Colors.grey),
                  const SizedBox(width: 15),
                  current != null
                      ? Text(
                          current.toLocal().toString().split(' ')[0],
                          style: AppTextStyle.textTitleTask(Colors.black),
                        )
                      : Text(
                          'Pick a deadline please',
                          style: AppTextStyle.textTitleTask(Colors.brown),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
