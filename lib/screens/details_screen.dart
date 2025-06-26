import 'package:flutter/material.dart';
import 'order_screen.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? gender;
  double? weight;
  double? height;
  int? age;
  double? caloriesNeeded;

  void calculateCalories() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        caloriesNeeded = gender == 'Male'
            ? 666.47 + (13.75 * weight!) + (5 * height!) - (6.75 * age!)
            : 655.1 + (9.56 * weight!) + (1.85 * height!) - (4.67 * age!);
      });
    }
  }

  bool get isFormValid {
    return gender != null && weight != null && height != null && age != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'Enter your details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: gender,
                            hint: Text(
                              'Choose your gender',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 16),
                            ),
                            dropdownColor: Colors.white,
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              border: InputBorder.none,
                            ),
                            icon: Icon(Icons.keyboard_arrow_down,
                                color: Colors.grey[600]),
                            items: ['Male', 'Female'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => gender = value),
                            validator: (value) =>
                                value == null ? 'Please select gender' : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weight',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter your weight',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 16),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              border: InputBorder.none,
                              suffixText: 'Kg',
                              suffixStyle: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                            ),
                            keyboardType: TextInputType.number,
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                            onSaved: (value) =>
                                weight = double.tryParse(value ?? ''),
                            onChanged: (value) =>
                                setState(() => weight = double.tryParse(value)),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter weight'
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Height',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter your height',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 16),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              border: InputBorder.none,
                              suffixText: 'Cm',
                              suffixStyle: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                            ),
                            keyboardType: TextInputType.number,
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                            onSaved: (value) =>
                                height = double.tryParse(value ?? ''),
                            onChanged: (value) =>
                                setState(() => height = double.tryParse(value)),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter height'
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Age',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter your age in years',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 16),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                            onSaved: (value) => age = int.tryParse(value ?? ''),
                            onChanged: (value) =>
                                setState(() => age = int.tryParse(value)),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter age'
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 80, top: 10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isFormValid
                        ? () {
                            calculateCalories();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderScreen(
                                  caloriesNeeded: caloriesNeeded,
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isFormValid ? Colors.orange : Colors.grey[300],
                      disabledBackgroundColor: Colors.grey[300],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        color: isFormValid ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 