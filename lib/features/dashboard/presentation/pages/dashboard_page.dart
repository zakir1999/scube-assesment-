import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/info_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("1st Page"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_active, color: AppColors.errorRed))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildNavigationBanner(context),
            const SizedBox(height: 16),
            _buildTopStatsGrid(),
            const SizedBox(height: 16),
            _buildWeatherCard(),
            const SizedBox(height: 16),
            _buildDataComparisonTable(),
            const SizedBox(height: 16),
            _buildInfoBanner(),
            const SizedBox(height: 16),
            _buildTechSpecsGrid(),
            const SizedBox(height: 16),
            _buildUnitDetailCard(),
            const SizedBox(height: 16),
            _buildUnitDetailCard(), // Duplicated for scrolling effect
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationBanner(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/details'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF4FC3F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("2nd Page Navigate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16)
          ],
        ),
      ),
    );
  }

  Widget _buildTopStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: const [
        InfoCard(title: "Live AC Power", value: "10000 kW", icon: Icons.bolt, iconColor: Colors.green),
        InfoCard(title: "Plant Generation", value: "82.58 %", icon: Icons.solar_power, iconColor: Colors.teal),
        InfoCard(title: "Cumulative PR", value: "27.58 %", icon: Icons.percent, iconColor: Colors.blue),
        InfoCard(title: "Return PV(Till Today)", value: "10000 ৳", icon: Icons.monetization_on, iconColor: Colors.orange, subtitle: "Total Energy: 10000 kWh"),
      ],
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.weatherGradientStart, AppColors.weatherGradientEnd]),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("17°C", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              const Text("Module\nTemperature", style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          const SizedBox(
            height: 60,
            child: VerticalDivider(color: Colors.white24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(4)),
                child: const Text("26 MPH / NW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const Text("Wind Speed & Direction", style: TextStyle(color: Colors.white70, fontSize: 10)),
              const SizedBox(height: 5),
              const Text("15.20 w/m²", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const Text("Effective Irradiation", style: TextStyle(color: Colors.white70, fontSize: 10)),
            ],
          ),
          const Icon(Icons.wb_sunny, size: 50, color: Colors.yellowAccent),
        ],
      ),
    );
  }

  Widget _buildDataComparisonTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _buildTableRow("Yesterday's Data", "Today's Data", isHeader: true),
          const Divider(),
          _buildTableRow("1636.50 kW", "2121.88 kW", label: "AC Max Power"),
          _buildTableRow("6439.16 kWh", "4875.77 kWh", label: "Net Energy"),
          _buildTableRow("1.25 kWh/kWp", "0.94 kWh/kWp", label: "Specific Yield"),
        ],
      ),
    );
  }

  Widget _buildTableRow(String v1, String v2, {String? label, bool isHeader = false}) {
    TextStyle style = TextStyle(
        fontWeight: isHeader ? FontWeight.normal : FontWeight.bold,
        color: isHeader ? AppColors.textGrey : AppColors.textDark,
        fontSize: isHeader ? 12 : 14);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(label != null) Expanded(flex: 2, child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textGrey))),
          Expanded(flex: 2, child: Text(v1, style: style, textAlign: TextAlign.right)),
          const SizedBox(width: 10),
          Expanded(flex: 2, child: Text(v2, style: style, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: const Row(
        children: [
          Icon(Icons.grid_view, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(child: Text("Total Num of PV Module : 6372 pcs. (585 Wp each)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildTechSpecsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildMiniSpec("Total AC Capacity", "3000 KW", Icons.settings_input_component),
        _buildMiniSpec("Total DC Capacity", "3.727 MWp", Icons.power),
        _buildMiniSpec("Date of Commissioning", "17/07/2024", Icons.calendar_today),
        _buildMiniSpec("Number of Inverter", "30", Icons.storage),
      ],
    );
  }

  Widget _buildMiniSpec(String title, String val, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 9, color: Colors.grey)),
                Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUnitDetailCard() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue.withOpacity(0.2))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.05)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("LT_01", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("495.505 kWp / 440 kW", style: TextStyle(color: Colors.blue, fontSize: 12)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: _buildUnitMetric(Icons.bolt, "Lifetime Energy", "352.96 MWh")),
                Expanded(child: _buildUnitMetric(Icons.hourglass_bottom, "Today Energy", "273.69 kWh", color: Colors.orange)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                Expanded(child: _buildUnitMetric(Icons.history, "Prev. Meter Energy", "0.00 MWh", color: Colors.orangeAccent)),
                Expanded(child: _buildUnitMetric(Icons.electric_meter, "Live Power", "352.96 MWh", color: Colors.purple)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitMetric(IconData icon, String label, String val, {Color color = Colors.blue}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
            Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}