import 'package:flutter/foundation.dart';
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
  String _familyHeadGenderController = '';
  String _familyHeadEducationLevelController = '';
  String _familyHeadOccupationTypeController = '';
  bool _isFamilyHeadRecievedAidController = true;
  final _familyHeadRecievedAIdDescriptionController = TextEditingController();

  final _idMemberController = TextEditingController();
  final _nameMemberController = TextEditingController();
  final _ageMemberController = TextEditingController();
  final _occupationMemberController = TextEditingController();
  final _grossMonthlyIncomeMemberController = TextEditingController();
  final _mobileNumberMemberController = TextEditingController();
  final _genderMemberController = TextEditingController();
  final _educationLevelMemberController = TextEditingController();
  final _occupationTypeMemberController = TextEditingController();
  final _isMemberRecievedAidController = TextEditingController();
  final _recievedAIdDescriptionMemberController = TextEditingController();

  String _familyHeadGender = '';
  String _familyHeadEducationLevel = '';
  final List<String> _familyHeadEducationLevels = [
    'No Schooling',
    'Grade 1-5',
    'Passed Grade 5',
    'Grade 6-11',
    'O/L',
    'Passed O/L',
    'A/L',
    'Passed A/L',
    'Undergraduate',
    'Graduated',
  ];
  String _occupationType =
      'Unemployed'; // Add a state variable to hold the selected occupation type

  // List of occupation types
  final List<String> _familyHeadOccupationTypes = [
    'Unemployed',
    'Self-employed',
    'Government',
    'Private',
    'Semi-Government',
    'Corperations',
    'Retired',
  ];

  String _genderMember = '';
  String _educationLevelMember = '';

  // List of education levels
  final List<String> _educationLevelsMember = [
    'No Schooling',
    'Grade 1-5',
    'Passed Grade 5',
    'Grade 6-11',
    'O/L',
    'Passed O/L',
    'A/L',
    'Passed A/L',
    'Undergraduate',
    'Graduated',
  ];

  String _occupationTypeMember = 'Unemployed';

  final List<String> _occupationTypesMember = [
    'Unemployed',
    'Self-employed',
    'Government',
    'Private',
    'Semi-Government',
    'Corperations',
    'Retired',
  ];

  bool _isRecievedAidFamilyHead =
      true; // Add a state variable to track the aid checkbox
  String _recievedAidDescriptionFamilyHead =
      ''; // Add a state variable to hold the aid description

  bool _isRecievedAidMember = false;
  String _recievedAidDescriptionMember = '';

  List<Map<String, dynamic>> _familyMembers =
      []; // List to store family member details

  int _memberCount = 0; // Track the number of family members

  @override
  void initState() {
    super.initState();
    _loadFamilyData();
  }

  void _handleGenderChangeFamilyHead(String? value) {
    setState(() {
      _familyHeadGender = value!;
    });
  }

  void _handleGenderChangeMember(String? value) {
    setState(() {
      _genderMember = value!;
    });
  }

  Future<void> _loadFamilyData() async {
    final data = await _databaseHelper.getFamiliesWithMembers();
    setState(() {
      _familyData = data;
    });

    for (var family in data) {
      if (kDebugMode) {
        print('Family Data: $family');
      }
      if (kDebugMode) {
        print('Members: ${family['members']}');
      }
    }

    if (_familyData.isNotEmpty) {
      final family = _familyData[1]; // Example: using the first family
      _isRecievedAidFamilyHead = family['is_family_head_recieved_aid'] == 1;
    }
  }

  void _startEditing(Map<String, dynamic> family) {
    setState(() {
      _isEditing = true;
      _editingFamilyId = family['id'];

      _nameController.text = family['name'] ?? '';
      _relationController.text = family['relation'] ?? '';

      _familyHeadIDController.text = family['head_id'] ?? '';
      _familyHeadNameController.text = family['head_name'] ?? '';
      _familyHeadAgeController.text = family['head_age'].toString();
      _familyHeadOccupationController.text = family['head_occupation'] ?? '';
      _familyHeadGrossMonthlyIncomeController.text =
          family['head_gross_monthly_income'].toString();
      _familyHeadMobileNumberController.text =
          family['head_mobile_number'] ?? '';
      _familyHeadGenderController = family['head_gender'] ?? '';
      _familyHeadEducationLevelController =
          family['head_education_level'] ?? '';
      _familyHeadOccupationTypeController =
          family['head_occupation_type'] ?? '';
      _isFamilyHeadRecievedAidController =
          family['is_family_head_recieved_aid'] = true;
      _familyHeadRecievedAIdDescriptionController.text =
          family['head_recieved_aid_description'] ?? '';

      /*_idMemberController.text = family['idMember'];
      _nameMemberController.text = family['nameMember'];
      _ageMemberController.text = family['ageMember'].toString();
      _occupationMemberController.text = family['occupationMember'];
      _grossMonthlyIncomeMemberController.text =
          family['grossMonthlyIncomeMember'].toString();
      _mobileNumberMemberController.text = family['mobileNumberMember'];
      _genderMemberController.text = family['genderMember'];
      _educationLevelMemberController.text = family['educationLevelMember'];
      _occupationTypeMemberController.text = family['occupationTypeMember'];
      _isMemberRecievedAidController.text =
          family['isMemberRecievedAid'].toString();
      _recievedAIdDescriptionMemberController.text =
          family['recievedAIdDescriptionMember'];*/
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
        'head_gender': _familyHeadGenderController,
        'head_education_level': _familyHeadEducationLevelController,
        'head_occupation_type': _familyHeadOccupationTypeController,
        'is_family_head_recieved_aid': _isRecievedAidFamilyHead ? true : false,
        'head_recieved_aid_description': _isRecievedAidFamilyHead
            ? _familyHeadRecievedAIdDescriptionController.text
            : '-', // Only save if receiving aid,
        /*'idMember': _idMemberController.text,
        'nameMember': _nameMemberController.text,
        'ageMember': _ageMemberController.text,
        'occupationMember': _occupationMemberController.text,
        'grossMonthlyIncomeMember': _grossMonthlyIncomeMemberController.text,
        'mobileNumberMember': _mobileNumberMemberController.text,
        'genderMember': _genderMemberController.text,
        'educationLevelMember': _educationLevelMemberController.text,
        'occupationTypeMember': _occupationTypeMemberController.text,
        'isMemberRecievedAid': _isMemberRecievedAidController.text,
        'recievedAIdDescriptionMember':
            _recievedAIdDescriptionMemberController.text,*/
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
        _familyHeadGenderController;
        _familyHeadEducationLevelController;
        _familyHeadOccupationTypeController;

        _familyHeadRecievedAIdDescriptionController.clear();

        /*_idMemberController.clear();
        _nameMemberController.clear();
        _ageMemberController.clear();
        _occupationMemberController.clear();
        _grossMonthlyIncomeMemberController.clear();
        _mobileNumberMemberController.clear();
        _genderMemberController.clear();
        _educationLevelMemberController.clear();
        _occupationTypeMemberController.clear();
        _isMemberRecievedAidController.clear();
        _recievedAIdDescriptionMemberController.clear();*/
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
        title: const Text('Family Data', style: TextStyle(fontSize: 22.0)),
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
                              const SizedBox(height: 32.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Family Head Gender',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Row(
                                    children: [
                                      Radio<String>(
                                          value: 'Male',
                                          groupValue:
                                              _familyHeadGenderController,
                                          onChanged: (value) {
                                            setState(() {
                                              _familyHeadGenderController =
                                                  value!;
                                            });
                                          }),
                                      const Text('Male'),
                                      Radio<String>(
                                          value: 'Female',
                                          groupValue:
                                              _familyHeadGenderController,
                                          onChanged: (value) {
                                            setState(() {
                                              _familyHeadGenderController =
                                                  value!;
                                            });
                                          }),
                                      const Text(
                                        'Female',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _familyHeadAgeController,
                                decoration: const InputDecoration(
                                  labelText: 'Family Head Age',
                                ),
                              ),
                              const SizedBox(
                                height: 32.0,
                              ),
                              const Text(
                                'Family Head Education Level',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey,
                                    fontWeight: FontWeight
                                        .bold // Change this to your desired color
                                    ),
                              ),
                              Column(
                                children:
                                    _familyHeadEducationLevels.map((level) {
                                  return RadioListTile(
                                    title: Text(
                                      level,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    value: level,
                                    groupValue:
                                        _familyHeadEducationLevelController,
                                    onChanged: (value) {
                                      setState(() {
                                        _familyHeadEducationLevelController =
                                            value as String;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const Text(
                                'Family Head Occupation Types',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey,
                                    fontWeight: FontWeight
                                        .bold // Change this to your desired color
                                    ),
                              ),
                              Column(
                                children:
                                    _familyHeadOccupationTypes.map((level) {
                                  return RadioListTile(
                                    title: Text(
                                      level,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    value: level,
                                    groupValue:
                                        _familyHeadOccupationTypeController,
                                    onChanged: (value) {
                                      setState(() {
                                        _familyHeadOccupationTypeController =
                                            value as String;
                                      });
                                    },
                                  );
                                }).toList(),
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
                              const SizedBox(height: 18.0),
                              CheckboxListTile(
                                title: const Text(
                                  'Is receiving any Aid?',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                value: _isRecievedAidFamilyHead,
                                onChanged: (value) {
                                  setState(() {
                                    _isRecievedAidFamilyHead = value!;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                              TextField(
                                controller:
                                    _familyHeadRecievedAIdDescriptionController,
                                decoration: const InputDecoration(
                                  labelText:
                                      'Family Head Recieved Aid Description',
                                ),
                              ),
                              const SizedBox(height: 32.0),
                              /*
                              Text("Family Member"),
                              const SizedBox(height: 16.0),
                              if (_familyMembers.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    _memberCount,
                                    (index) => _buildMemberCard(index),
                                  ),
                                ),
                              TextField(
                                controller: _idMemberController,
                                decoration: const InputDecoration(
                                  labelText: 'Member ID',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _nameMemberController,
                                decoration: const InputDecoration(
                                  labelText: 'Member Name',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Gender',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Male',
                                        groupValue: _genderMember,
                                        onChanged: _handleGenderChangeMember,
                                      ),
                                      const Text('Male'),
                                      Radio<String>(
                                        value: 'Female',
                                        groupValue: _genderMember,
                                        onChanged: _handleGenderChangeMember,
                                      ),
                                      const Text(
                                        'Female',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _ageMemberController,
                                decoration: const InputDecoration(
                                  labelText: 'Member Age',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _relationController,
                                decoration: const InputDecoration(
                                  labelText: 'Member Relation',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Text(
                                'Education Level',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors
                                      .grey, // Change this to your desired color
                                ),
                              ),
                              Column(
                                children: _educationLevelsMember.map((level) {
                                  return RadioListTile(
                                    title: Text(
                                      level,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    value: level,
                                    groupValue: _educationLevelMember,
                                    onChanged: (value) {
                                      setState(() {
                                        _educationLevelMember = value as String;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16.0),
                              const Text(
                                'Occupation Type',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors
                                      .grey, // Change this to your desired color
                                ),
                              ),
                              Column(
                                children: _occupationTypesMember.map((level) {
                                  return RadioListTile(
                                    title: Text(
                                      level,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    value: level,
                                    groupValue: _occupationTypeMember,
                                    onChanged: (value) {
                                      setState(() {
                                        _occupationTypeMember = value as String;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _occupationMemberController,
                                decoration: const InputDecoration(
                                  labelText: 'Member Occupation',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _grossMonthlyIncomeMemberController,
                                decoration: const InputDecoration(
                                  labelText: 'Member Gross Monthly Income',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: _mobileNumberMemberController,
                                decoration: const InputDecoration(
                                  labelText: 'Member Mobile Number',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              CheckboxListTile(
                                title: const Text(
                                  'Is receiving any Aid?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.grey),
                                ),
                                value: _isRecievedAidMember,
                                onChanged: (value) {
                                  setState(() {
                                    _isRecievedAidMember = value!;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                              if (_isRecievedAidMember)
                                TextField(
                                  controller: _isMemberRecievedAidController,
                                  decoration: const InputDecoration(
                                    labelText:
                                        'Member Recieved Aid Description',
                                  ),
                                ),*/
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
                              _buildTextRow(
                                  'Family Head Gender:', family['head_gender']),
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
                              const SizedBox(height: 32.0),
                              /*_buildTextRow('Member ID:', family['idMember']),
                              const SizedBox(height: 16.0),
                              _buildTextRow(
                                  'Member Name:', family['nameMember']),
                              const SizedBox(height: 16.0),
                              _buildTextRow(
                                  'Member Gender:', family['genderMember']),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Member Age:',
                                  family['ageMember'].toString()),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Member Education Level:',
                                  family['educationLevelMember']),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Member Occupation Type:',
                                  family['occupationTypeMember']),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Member Occupation:',
                                  family['occupationMember']),
                              const SizedBox(height: 16.0),
                              _buildTextRow(
                                  'Member Gross Monthly Income:',
                                  family['grossMonthlyIncomeMember']
                                      .toString()),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Member Mobile Number:',
                                  family['mobileNumberMember']),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Is Member Recieved Any Aid?:',
                                  family['isMemberRecievedAid'].toString()),
                              const SizedBox(height: 16.0),
                              _buildTextRow('Member Recieved Aid Description:',
                                  family['memberRecievedAidDescription']),*/
                              const SizedBox(height: 32.0),
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

  Widget _buildMemberCard(int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Family Member ${index + 2}',
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 48.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ID',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the ID!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['idMember'] = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the name!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['nameMember'] = value;
              },
            ),
            const SizedBox(height: 48.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: _genderMember,
                      onChanged: _handleGenderChangeMember,
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _genderMember,
                      onChanged: _handleGenderChangeMember,
                    ),
                    const Text(
                      'Female',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Age',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the age!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['ageMember'] = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Relationship',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the relationship!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['relationshipMember'] = value;
              },
            ),
            const SizedBox(height: 48.0),
            const Text(
              'Education Level',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black, // Change this to your desired color
              ),
            ),
            Column(
              children: _educationLevelsMember.map((level) {
                return RadioListTile(
                  title: Text(
                    level,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: level,
                  groupValue: _educationLevelMember,
                  onChanged: (value) {
                    setState(() {
                      _educationLevelMember = value as String;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32.0),
            const Text(
              'Occupation Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black, // Change this to your desired color
              ),
            ),
            Column(
              children: _occupationTypesMember.map((level) {
                return RadioListTile(
                  title: Text(
                    level,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: level,
                  groupValue: _occupationTypeMember,
                  onChanged: (value) {
                    setState(() {
                      _occupationTypeMember = value as String;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Occupation',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the occupation!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['occupationMember'] = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Gross Monthly Income',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the gross monthly income!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['grossMonthlyIncomeMember'] = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                errorStyle: TextStyle(
                  color: Colors.red, // Set your desired color here
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the mobile number!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['mobileNumberMember'] = value;
              },
            ),
            const SizedBox(height: 32.0),
            CheckboxListTile(
              title: const Text(
                'Is receiving any Aid?',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              value: _isRecievedAidMember,
              onChanged: (value) {
                setState(() {
                  _isRecievedAidMember = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            if (_isRecievedAidMember)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description of Aid',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  errorStyle: TextStyle(
                    color: Colors.red, // Set your desired color here
                  ),
                ),
                onChanged: (value) {
                  _familyMembers[index]['recievedAidDescriptionMember'] = value;
                },
              ),
            const SizedBox(height: 2.0),
          ],
        ),
      ),
    );
  }
}
