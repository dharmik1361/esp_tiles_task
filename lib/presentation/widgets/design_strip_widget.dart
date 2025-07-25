import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class DesignStripWidget extends StatefulWidget {
  const DesignStripWidget({Key? key}) : super(key: key);

  @override
  State<DesignStripWidget> createState() => _DesignStripWidgetState();
}

class _DesignStripWidgetState extends State<DesignStripWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<TestParameter> _parameters = [
    TestParameter(
      name: 'Total Hardness',
      unit: 'ppm',
      colors: [
        const Color(0xFF1E3A8A), // Dark blue
        const Color(0xFF7C3AED), // Medium purple
        const Color(0xFF581C87), // Darker purple
        const Color(0xFF7F1D1D), // Dark maroon
        const Color(0xFF450A0A), // Very dark maroon
      ],
      values: [0, 110, 250, 500, 1000],
      selectedValue: 0,
    ),
    TestParameter(
      name: 'Total Chlorine',
      unit: 'ppm',
      colors: [
        const Color(0xFFFEF3C7), // Light yellow
        const Color(0xFFFDE68A), // Slightly darker yellow
        const Color(0xFF86EFAC), // Light green
        const Color(0xFF4ADE80), // Medium green
        const Color(0xFF16A34A), // Dark green
      ],
      values: [0, 1, 3, 5, 10],
      selectedValue: 0,
    ),
    TestParameter(
      name: 'Free Chlorine',
      unit: 'ppm',
      colors: [
        const Color(0xFFF5F5DC), // Light beige
        const Color(0xFFFEFEFE), // Off-white
        const Color(0xFFD8B4FE), // Light purple
        const Color(0xFFC084FC), // Medium purple
        const Color(0xFF7C3AED), // Dark purple
      ],
      values: [0, 1, 3, 5, 10],
      selectedValue: 0,
    ),
    TestParameter(
      name: 'pH',
      unit: 'ppm',
      colors: [
        const Color(0xFFEA580C), // Orange
        const Color(0xFFDC2626), // Slightly darker orange
        const Color(0xFFB91C1C), // Reddish-orange
        const Color(0xFF991B1B), // Dark reddish-orange
        const Color(0xFF7F1D1D), // Red
      ],
      values: [6.2, 6.8, 7.2, 7.8, 8.4],
      selectedValue: 6.2,
    ),
    TestParameter(
      name: 'Total Alkalinity',
      unit: 'ppm',
      colors: [
        const Color(0xFFD97706), // Light brown/gold
        const Color(0xFF65A30D), // Olive green
        const Color(0xFF15803D), // Dark green
        const Color(0xFF0F766E), // Dark teal
        const Color(0xFF134E4A), // Very dark teal
      ],
      values: [0, 40, 120, 180, 240],
      selectedValue: 0,
    ),
    TestParameter(
      name: 'Cyanuric Acid',
      unit: 'ppm',
      colors: [
        const Color(0xFF92400E), // Light brown
        const Color(0xFFA16207), // Medium brown
        const Color(0xFF7C2D12), // Dark brown
        const Color(0xFF991B1B), // Dark red
        const Color(0xFF581C87), // Dark purple
      ],
      values: [0, 50, 100, 150, 300],
      selectedValue: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.science, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'Test Strip',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E3A8A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFAFAFA), Colors.white],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Header section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3A8A).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF1E3A8A).withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: const Color(0xFF1E3A8A),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Select colors that match your water test strip results',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF1E3A8A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Parameters
                  ..._parameters.asMap().entries.map((entry) {
                    int index = entry.key;
                    TestParameter parameter = entry.value;
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300 + (index * 100)),
                      margin: const EdgeInsets.only(bottom: 24),
                      child: _buildParameterRow(parameter, index),
                    );
                  }).toList(),

                  const SizedBox(height: 32),

                  // Summary section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Test Summary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ..._parameters
                            .map(
                              (param) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      param.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF616161),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: param.colors[param.selectedIndex]
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: param
                                              .colors[param.selectedIndex]
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                      child: Text(
                                        '${param.selectedValue} ${param.unit}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              param.colors[param.selectedIndex],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParameterRow(TestParameter parameter, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Parameter name and unit
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: parameter.colors[parameter.selectedIndex],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${parameter.name} (${parameter.unit})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Main row with vertical bar, color strip, and input field
          Row(
            children: [
              // Left vertical color bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 24,
                height: 80,
                decoration: BoxDecoration(
                  color: parameter.colors[parameter.selectedIndex],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: parameter.colors[parameter.selectedIndex]
                          .withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),

              // Color strip with values
              Expanded(
                child: Column(
                  children: [
                    // Color rectangles
                    Row(
                      children: parameter.colors.asMap().entries.map((entry) {
                        int colorIndex = entry.key;
                        Color color = entry.value;
                        bool isSelected = colorIndex == parameter.selectedIndex;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                parameter.selectedIndex = colorIndex;
                                parameter.selectedValue =
                                    parameter.values[colorIndex];
                                parameter.inputController.text = parameter
                                    .selectedValue
                                    .toString();
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 40,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(8),
                                border: isSelected
                                    ? Border.all(color: Colors.white, width: 3)
                                    : null,
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: color.withOpacity(0.5),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),

                    // Values below color rectangles
                    Row(
                      children: parameter.values.map((value) {
                        return Expanded(
                          child: Text(
                            value.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF616161),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              // Input field
              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: parameter.colors[parameter.selectedIndex]
                        .withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: parameter.colors[parameter.selectedIndex]
                          .withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: parameter.inputController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: parameter.colors[parameter.selectedIndex],
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      double? numericValue = double.tryParse(value);
                      if (numericValue != null) {
                        // Find closest value in the parameter's value list
                        int closestIndex = 0;
                        double minDifference = double.infinity;

                        for (int i = 0; i < parameter.values.length; i++) {
                          double difference =
                              (numericValue - parameter.values[i]).abs();
                          if (difference < minDifference) {
                            minDifference = difference;
                            closestIndex = i;
                          }
                        }

                        setState(() {
                          parameter.selectedIndex = closestIndex;
                          parameter.selectedValue = numericValue;
                        });
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TestParameter {
  final String name;
  final String unit;
  final List<Color> colors;
  final List<double> values;
  double selectedValue;
  int selectedIndex;
  final TextEditingController inputController;

  TestParameter({
    required this.name,
    required this.unit,
    required this.colors,
    required this.values,
    required this.selectedValue,
  }) : selectedIndex = values.indexOf(selectedValue),
       inputController = TextEditingController(text: selectedValue.toString());
}
