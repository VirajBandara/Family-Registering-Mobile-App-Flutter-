import 'package:flutter/material.dart';
import 'package:family_reg/database_helper.dart';

class FamilyDataScreen extends StatefulWidget {
  const FamilyDataScreen({super.key});

  @override
  _FamilyDataScreenState createState() => _FamilyDataScreenState();
}

class _FamilyDataScreenState extends State<FamilyDataScreen> {
  final _databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> _familyData = [];

  bool _isEditing = false;
  int? _editingFamilyId;

  final _nameController = TextEditingController();
  final _relationController = TextEditingController();
  final _familyHeadIDController = TextEditingController();
  final _familyHeadNameController = TextEditingController();
  final _familyHeadAgeController = TextEditingController();
  final _familyHeadOccupationController = TextEditingController();
  final _familyHeadGrossMonthlyIncomeController = TextEditingController();
  final _familyHeadMobileNumberController = TextEditingController();

  final _familyHeadGenderController = TextEditingController();
  final _familyHeadEducationLevelController = TextEditingController();
  final _familyHeadOccupationTypeController = TextEditingController();
  final _isFamilyHeadRecievedAidController = TextEditingController();
  final _familyHeadRecievedAIdDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFamilyData();
  }

  Future<void> _loadFamilyData() async {
    final data = await _databaseHelper.getFamilies();
    setState(() {
      _familyData = data;
    });
  }

  void _startEditing(Map<String, dynamic> family) {
    setState(() {
      _isEditing = true;
      _editingFamilyId = family['id'];

      _nameController.text = family['name'];
      _relationController.text = family['relation'];
      _familyHeadIDController.text = family['head_id'];
      _familyHeadNameController.text = family['head_name'];
      _familyHeadAgeController.text = family['head_age'].toString();
      _familyHeadOccupationController.text = family['head_occupation'];
      _familyHeadGrossMonthlyIncomeController.text =
          family['head_gross_monthly_income'].toString();
      _familyHeadMobileNumberController.text = family['head_mobile_number'];

      _familyHeadGenderController.text = family['head_gender'];
      _familyHeadEducationLevelController.text = family['head_education_level'];
      _familyHeadOccupationTypeController.text = family['head_occupation_type'];
      _isFamilyHeadRecievedAidController.text =
          family['is_family_head_recieved_aid'].toString();
      _familyHeadRecievedAIdDescriptionController.text =
          family['head_recieved_aid_description'];
    });
  }

  Future<void> _submitUpdate() async {
    if (_editingFamilyId != null) {
      final updatedData = {
        'name': _nameController.text,
        'relation': _relationController.text,
        'head_id': _familyHeadIDController.text,
        'head_name': _familyHeadNameController.text,
        'head_age': _familyHeadAgeController.text,
        'head_occupation': _familyHeadOccupationController.text,
        'head_gross_monthly_income':
            _familyHeadGrossMonthlyIncomeController.text,
        'head_mobile_number': _familyHeadMobileNumberController.text,
        'head_gender': _familyHeadGenderController.text,
        'head_education_level': _familyHeadEducationLevelController.text,
        'head_occupation_type': _familyHeadOccupationTypeController.text,
        'is_family_head_recieved_aid': _isFamilyHeadRecievedAidController.text,
        'head_recieved_aid_description':
            _familyHeadRecievedAIdDescriptionController.text,
      };
      await _databaseHelper.updateFamily(_editingFamilyId!, updatedData);
      _loadFamilyData();
      setState(() {
        _isEditing = false;
        _editingFamilyId = null;
        _nameController.clear();
        _relationController.clear();
        _familyHeadIDController.clear();
        _familyHeadNameController.clear();
        _familyHeadAgeController.clear();
        _familyHeadOccupationController.clear();
        _familyHeadGrossMonthlyIncomeController.clear();
        _familyHeadMobileNumberController.clear();

        _familyHeadGenderController.clear();
        _familyHeadEducationLevelController.clear();
        _familyHeadOccupationTypeController.clear();
        _isFamilyHeadRecievedAidController.clear();
        _familyHeadRecievedAIdDescriptionController.clear();
      });
    }
  }

  Future<void> _deleteFamily(int id) async {
    await _databaseHelper.deleteFamily(id);
    _loadFamilyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Data'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/family-registering');
          },
        ),
      ),
      body: _familyData.isEmpty
          ? const Center(child: Text('No family data available'))
          : ListView.builder(
              itemCount: _familyData.length,
              itemBuilder: (context, index) {
                final family = _familyData[index];
                final isEditingThisFamily =
                    _isEditing && _editingFamilyId == family['id'];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isEditingThisFamily)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Household Number',
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              TextField(
                                controller: _relationController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Address',
                                ),
                              ),
                              const SizedBox(height: 32.0),
                              TextField(
                                controller: _familyHeadIDController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Head ID',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _familyHeadNameController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Head Name',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _familyHeadGenderController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Head Gender',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _familyHeadAgeController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Head Age',
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TextField(
                                controller: _familyHeadEducationLevelController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Head Education Level',
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TextField(
                                controller: _familyHeadOccupationTypeController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Head Occupation Type',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _familyHeadOccupationController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Head Occupation',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller:
                                    _familyHeadGrossMonthlyIncomeController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Head Gross Monthly Income',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _familyHeadMobileNumberController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Head Mobile Number',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _isFamilyHeadRecievedAidController,
                                decoration: const InputDecoration(
                                  labelText: 'Is Family Head Recieved Any Aid?',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller:
                                    _familyHeadRecievedAIdDescriptionController,
                                decoration: const InputDecoration(
                                  labelText:
                                      'Family Head Recieved Aid Description',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: _submitUpdate,
                                    child: const Text('Submit'),
                                  ),
                                ],
                              ),
                            ],
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildTextRow(
                                  'Family Household Number:', family['name']),
                              const SizedBox(height: 16.0),
                              _buildTextRow(
                                  'Family Address:', family['relation']),
                              const SizedBox(height: 16.0),
                              _buildTextRow(
                                  'Family Head ID:', family['head_id']),
                              const SizedBox(height: 16.0),
                              _buildTextRow(
                                  'Family Head Name:', family['head_name']),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Family Head Age:',
                                  family['head_age'].toString()),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Family Head Occupation:',
                                  family['head_occupation']),
                              const SizedBox(height: 16.0),
                              _buildTextRow(
                                  'Family Head Gross Monthly Income:',
                                  family['head_gross_monthly_income']
                                      .toString()),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Family Head Mobile Number:',
                                  family['head_mobile_number']),
                              const SizedBox(height: 16.0),
                              _buildTextRow(
                                  'Family Head Gender:', family['head_gender']),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Family Head Education Level:',
                                  family['head_education_level']),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Family Head Occupation Type:',
                                  family['head_occupation_type']),
                              const SizedBox(height: 16.0),
                              _buildTextRow(
                                  'Is Family Head Recieved Any Aid?:',
                                  family['is_family_head_recieved_aid']
                                      .toString()),
                              const SizedBox(height: 16.0),
                              _buildTextRow(
                                  'Family Head Recieved Aid Description:',
                                  family['head_recieved_aid_description']),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _startEditing(family);
                                    },
                                    child: const Text('Update'),
                                  ),
                                  const SizedBox(width: 8.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      _deleteFamily(family['id']);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildTextRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
