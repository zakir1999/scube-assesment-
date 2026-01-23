import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/widgets/navigate_banner_button.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}
class _DashboardPageState extends State<DashboardPage> {
  late Timer _timer;
  int _currentIndex = 0;
  final List<Map<String, dynamic>> _weatherStates = [
    {
      'temp': 17.0,
      'color': AppColors.thermoBlue,
      'icon': Icons.wb_cloudy_outlined,
      'iconColor': Colors.yellowAccent,
      'isNight': false,
    },
    {
      'temp': 30.0,
      'color': AppColors.thermoRed,
      'icon': Icons.wb_sunny,
      'iconColor': Colors.orangeAccent,
      'isNight': false,
    },
    {
      'temp': 19.0,
      'color': Color(0xFF455A64),
      'icon': Icons.nightlight_round,
      'iconColor': Colors.white70,
      'isNight': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _weatherStates.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentState = _weatherStates[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "1st Page",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Column(
          children: [
            CustomNavigationBanner(
              text: "2nd Page Navigate",
              isArrowLeft: false,
              onTap: () => context.push('/details'),
            )     ,
            const SizedBox(height: 10),
            _buildTopStatsGrid(),
            const SizedBox(height: 5),
            WeatherCard(
              temperature: currentState['temp'],
              thermoColor: currentState['color'],
              weatherIcon: currentState['icon'],
              iconColor: currentState['iconColor'],
            ),
            const SizedBox(height: 5),
            _buildDataComparisonTable(),
            const SizedBox(height: 5),
            _buildInfoBanner(),
            const SizedBox(height: 5),
            _buildTechSpecsGrid(),
            const SizedBox(height: 5),
            _buildUnitDetailCard("LT_01"),
            const SizedBox(height: 5),
            _buildUnitDetailCard("LT_02"),

          ],
        ),
      ),
    );
  }



  Widget _buildTopStatsGrid() {
    final stats = [
      {'val': '10000 kW', 'label': 'Live AC Power', 'icon': Icons.bolt, 'color': Colors.green},
      {'val': '82.58 %', 'label': 'Plant Generation', 'icon': Icons.settings_input_component, 'color': Colors.teal},
      {'val': '85.61 %', 'label': 'Live PR', 'icon': Icons.speed, 'color': Colors.indigo},
      {'val': '27.58 %', 'label': 'Cumulative PR', 'icon': Icons.pie_chart, 'color': Colors.blue},
      {'val': '10000 ৳', 'label': 'Return PV(Till Today)', 'icon': Icons.monetization_on_outlined, 'color': Colors.orange},
      {'val': '10000 kWh', 'label': 'Total Energy', 'icon': Icons.all_inclusive, 'color': Colors.purple},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final item = stats[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 5)],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 20),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item['val'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(item['label'] as String, style: const TextStyle(fontSize: 10, color: AppColors.secondaryText), overflow: TextOverflow.ellipsis),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildDataComparisonTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5)],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Expanded(child: SizedBox()),
                Expanded(child: Text("Yesterday's Data", textAlign: TextAlign.center, style: TextStyle(color: AppColors.secondaryText, fontSize: 12))),
                Expanded(child: Text("Today's Data", textAlign: TextAlign.center, style: TextStyle(color: AppColors.secondaryText, fontSize: 12))),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildTableRow("AC Max Power", "1636.50 kW", "2121.88 kW", isEven: true),
          _buildTableRow("Net Energy", "6439.16 kWh", "4875.77 kWh", isEven: false),
          _buildTableRow("Specific Yield", "1.25 kWh/kWp", "0.94 kWh/kWp", isEven: true),
          _buildTableRow("Net Energy", "6439.16 kWh", "4875.77 kWh", isEven: false), // Repeated in image
          _buildTableRow("Specific Yield", "1.25 kWh/kWp", "0.94 kWh/kWp", isEven: true),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildTableRow(String label, String v1, String v2, {required bool isEven}) {
    return Container(
      color: isEven ? Colors.grey.withValues(alpha: 0.2) : Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.secondaryText, fontSize: 13, fontWeight: FontWeight.w500))),
          Expanded(child: Text(v1, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
          Expanded(child: Text(v2, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
            child: const Icon(Icons.grid_view, color: Colors.blue, size: 18),
          ),
          const SizedBox(width: 10),
          const Expanded(
              child: Text(
                  "Total Num of PV Module  :  6372 pcs. (585 Wp each)",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.primaryText)
              )
          ),
        ],
      ),
    );
  }

  Widget _buildTechSpecsGrid() {
    final specs = [
      {'title': 'Total AC Capacity', 'val': '3000 KW', 'icon': Icons.memory},
      {'title': 'Total DC Capacity', 'val': '3.727 MWp', 'icon': Icons.storage},
      {'title': 'Date of Commissioning', 'val': '17/07/2024', 'icon': Icons.calendar_today},
      {'title': 'Number of Inverter', 'val': '30', 'icon': Icons.dns},
      {'title': 'Total AC Capacity', 'val': '3000 KW', 'icon': Icons.memory},
      {'title': 'Total DC Capacity', 'val': '3.727 MWp', 'icon': Icons.storage},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: specs.length,
      itemBuilder: (context, index) {
        final item = specs[index];
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Icon(item['icon'] as IconData, size: 16, color: Colors.blueAccent),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item['title'] as String, style: const TextStyle(fontSize: 9, color: AppColors.secondaryText)),
                    Text(item['val'] as String, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildUnitDetailCard(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5)],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Row(
                  children: [
                    Icon(Icons.bolt, color: Colors.blue, size: 16),
                    SizedBox(width: 4),
                    Text("495.505 kWp / 440 kW", style: TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildUnitMetric(Icons.flash_on, "Lifetime Energy", "352.96 MWh", const Color(0xFFE1F5FE), Colors.lightBlue)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildUnitMetric(Icons.hourglass_empty, "Today Energy", "273.69 kWh", const Color(0xFFFFF3E0), Colors.orange)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildUnitMetric(Icons.history, "Prev. Meter Energy", "0.00 MWh", const Color(0xFFFFF8E1), Colors.amber)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildUnitMetric(Icons.electric_meter, "Live Power", "352.96 MWh", const Color(0xFFF3E5F5), Colors.purple)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitMetric(IconData icon, String label, String val, Color bg, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: AppColors.secondaryText)),
            Text(val, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
          ],
        )
      ],
    );
  }
}

class WeatherCard extends StatelessWidget {
  final double temperature;
  final Color thermoColor;
  final IconData weatherIcon;
  final Color iconColor;

  const WeatherCard({
    super.key,
    required this.temperature,
    required this.thermoColor,
    required this.weatherIcon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4)
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: thermoColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                            child: Text("${temperature.toStringAsFixed(0)}°C"),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Module\nTemperature",
                            style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 11,
                                height: 1.2
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: temperature),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return CustomPaint(
                            size: const Size(22, 70),
                            painter: ThermometerPainter(
                              temperature: value,
                              color: thermoColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 6,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.weatherPurpleStart, AppColors.weatherPurpleEnd],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("26 MPH / NW",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                        Text("Wind Speed & Direction",
                            style: TextStyle(color: Colors.white70, fontSize: 10)),
                        SizedBox(height: 8),
                        Text("15.20 w/m²",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                        Text("Effective Irradiation",
                            style: TextStyle(color: Colors.white70, fontSize: 10)),
                      ],
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                          weatherIcon,
                          key: ValueKey<IconData>(weatherIcon),
                          size: 42,
                          color: iconColor
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThermometerPainter extends CustomPainter {
  final double temperature;
  final Color color;

  ThermometerPainter({required this.temperature, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint outlinePaint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;
    final double bulbRadius = width / 1.6;
    final double stemWidth = width / 2.8;

    final Path outlinePath = Path();
    outlinePath.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: Offset(width / 2, height / 2 - bulbRadius / 2),
          width: stemWidth,
          height: height - bulbRadius
      ),
      Radius.circular(stemWidth),
    ));
    outlinePath.addOval(Rect.fromCircle(
        center: Offset(width / 2, height - bulbRadius),
        radius: bulbRadius
    ));
    double t = temperature.clamp(0.0, 50.0);
    double fillPercentage = t / 50.0;
    double totalStemHeight = (height - bulbRadius * 2);
    double currentFillHeight = totalStemHeight * fillPercentage;
    canvas.drawCircle(Offset(width / 2, height - bulbRadius), bulbRadius - 1.5, fillPaint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            (width - stemWidth) / 2 + 2,
            (height - bulbRadius * 2) - currentFillHeight + 2,
            stemWidth - 4,
            currentFillHeight + bulbRadius
        ),
        Radius.circular(stemWidth),
      ),
      fillPaint,
    );

    canvas.drawPath(outlinePath, outlinePaint);

    final Paint tickPaint = Paint()..color = Colors.black54..strokeWidth = 1;
    final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < 4; i++) {
      double y = (height - bulbRadius * 2.5) * (i / 3) + 5;

      canvas.drawLine(Offset(0, y), Offset(4, y), tickPaint);

      tp.text = TextSpan(
          text: "${45 - i * 15}",
          style: const TextStyle(color: Colors.black54, fontSize: 7, fontWeight: FontWeight.bold)
      );
      tp.layout();
      tp.paint(canvas, Offset(-10, y - 3));
    }
  }

  @override
  bool shouldRepaint(covariant ThermometerPainter oldDelegate) {
    return oldDelegate.temperature != temperature || oldDelegate.color != color;
  }
}