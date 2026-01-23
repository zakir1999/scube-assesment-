import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/widgets/navigate_banner_button.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _selectedTabIndex = 0;
  bool _isSourceSelected = true;
  final ScrollController _listScrollController = ScrollController();
  final List<Map<String, dynamic>> _dataItems = [
    {
      'title': 'Data View',
      'active': true,
      'squareColor': AppColors.squareSolar,
      'icon': Icons.solar_power_outlined,
      'iconBg': const Color(0xFFE1F5FE),
      'iconColor': Colors.blueGrey,
      'isBattery': false,
    },
    {
      'title': 'Data Type 2',
      'active': true,
      'squareColor': AppColors.squareBattery,
      'icon': Icons.battery_charging_full,
      'iconBg': const Color(0xFF37474F),
      'iconColor': Colors.yellowAccent,
      'isBattery': true,
    },
    {
      'title': 'Data Type 3',
      'active': false,
      'squareColor': AppColors.squareGrid,
      'icon': Icons.electric_meter,
      'iconBg': const Color(0xFFE8F5E9),
      'iconColor': Colors.teal,
      'isBattery': false,
    },
    {
      'title': 'Data Type 4',
      'active': true,
      'squareColor': Colors.purpleAccent,
      'icon': Icons.electrical_services,
      'iconBg': const Color(0xFFF3E5F5),
      'iconColor': Colors.purple,
      'isBattery': false,
    },
    {
      'title': 'Data Type 5',
      'active': false,
      'squareColor': Colors.redAccent,
      'icon': Icons.wind_power,
      'iconBg': const Color(0xFFFFEBEE),
      'iconColor': Colors.red,
      'isBattery': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(title: "2nd Page"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 2, 16, 3),
        child: Column(
          children: [
            CustomNavigationBanner(
              text: "1st Page Navigate",
              isArrowLeft: false,
              onTap: () => context.pop(),
            ),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildCustomTabBar(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text(
                          "Electricity",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Divider(height: 1, color: Color(0xFFEEEEEE)),
                        const SizedBox(height: 10),
                        _buildCircularChart(),
                        const SizedBox(height: 10),

                        _buildToggleSwitch(),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 250,
                          child: RawScrollbar(
                            controller: _listScrollController,
                            thumbColor: AppColors.primaryBlue.withValues(
                              alpha: 0.5,
                            ),
                            radius: const Radius.circular(4),
                            thickness: 4,
                            thumbVisibility: true,
                            child: ListView.builder(
                              controller: _listScrollController,
                              padding: const EdgeInsets.only(right: 8),
                              itemCount: _dataItems.length,
                              itemBuilder: (context, index) {
                                final item = _dataItems[index];
                                return _buildListItem(
                                  title: item['title'],
                                  isActive: item['active'],
                                  squareColor: item['squareColor'],
                                  icon: item['icon'],
                                  iconBg: item['iconBg'],
                                  iconColor: item['iconColor'],
                                  isBattery: item['isBattery'],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            _buildBottomGridMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1.5),
        ),
      ),
      child: Row(
        children: [
          _buildTabBtn("Summary", 0, isLeft: true),
          Container(
            width: 1,
            height: 30,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          _buildTabBtn("SLD", 1),
          Container(
            width: 1,
            height: 30,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          _buildTabBtn("Data", 2, isRight: true),
        ],
      ),
    );
  }

  Widget _buildTabBtn(
    String label,
    int index, {
    bool isLeft = false,
    bool isRight = false,
  }) {
    final bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: isLeft ? const Radius.circular(16) : Radius.zero,
              topRight: isRight ? const Radius.circular(16) : Radius.zero,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularChart() {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: AppColors.primaryBlue,
                  value: 70,
                  radius: 28,
                  showTitle: false,
                ),
                PieChartSectionData(
                  color: const Color(0xFFE3F2FD),
                  value: 30,
                  radius: 28,
                  showTitle: false,
                ),
              ],
              startDegreeOffset: 270,
              sectionsSpace: 0,
              centerSpaceRadius: 65,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "Total Power",
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "5.53 kw",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSwitch() {
    return Container(
      width: 300,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isSourceSelected = true),
              child: Container(
                decoration: BoxDecoration(
                  color: _isSourceSelected
                      ? AppColors.primaryBlue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Source",
                  style: TextStyle(
                    color: _isSourceSelected ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isSourceSelected = false),
              child: Container(
                decoration: BoxDecoration(
                  color: !_isSourceSelected
                      ? AppColors.primaryBlue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Load",
                  style: TextStyle(
                    color: !_isSourceSelected ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required String title,
    required bool isActive,
    required Color squareColor,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    bool isBattery = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.listTileBg,
        // Uniform light blue bg as per image list style
        border: Border.all(color: AppColors.listBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isBattery ? iconBg : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: isBattery
                ? Icon(icon, color: iconColor, size: 28)
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: -0.2,
                        child: Container(
                          width: 30,
                          height: 30,
                          color: Colors.transparent,
                          child: Icon(
                            Icons.grid_3x3,
                            color: Colors.blueGrey.withValues(alpha: 0.2),
                            size: 36,
                          ),
                        ),
                      ),
                      Icon(icon, color: iconColor, size: 32),
                    ],
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: squareColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isActive ? "(Active)" : "(Inactive)",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isActive
                            ? AppColors.activeText
                            : AppColors.inactiveText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(55),
                    1: FixedColumnWidth(10),
                  },
                  children: const [
                    TableRow(
                      children: [
                        Text(
                          "Data 1",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textGrey,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          ":",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textGrey,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          "55505.63",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          "Data 2",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textGrey,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          ":",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textGrey,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          "58805.63",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        ],
      ),
    );
  }

  Widget _buildBottomGridMenu() {
    final menuItems = [
      {
        'title': 'Analysis Pro',
        'icon': Icons.pie_chart,
        'color': Colors.orangeAccent,
      },
      {
        'title': 'G. Generator',
        'icon': Icons.electrical_services,
        'color': Colors.brown,
      },
      {
        'title': 'Plant Summary',
        'icon': Icons.flash_on,
        'color': Colors.orange,
      },
      {
        'title': 'Natural Gas',
        'icon': Icons.local_fire_department,
        'color': Colors.deepOrange,
      },
      {
        'title': 'D. Generator',
        'icon': Icons.power,
        'color': Colors.amber.shade800,
      },
      {
        'title': 'Water Process',
        'icon': Icons.water_drop,
        'color': Colors.lightBlue,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(
                item['icon'] as IconData,
                color: item['color'] as Color,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF546E7A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
