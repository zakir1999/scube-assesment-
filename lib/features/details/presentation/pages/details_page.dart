import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text("2nd Page"),
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
            _buildTabBar(),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text("Electricity", style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const Divider(),
                  const SizedBox(height: 20),
                  _buildCircularChart(),
                  const SizedBox(height: 30),
                  _buildToggleSwitch(),
                  const SizedBox(height: 20),
                  _buildDataItem("Data View", "55505.63", "58805.63", isActive: true, color: Colors.blue),
                  _buildDataItem("Data Type 2", "55505.63", "58805.63", isActive: true, color: Colors.orange),
                  _buildDataItem("Data Type 3", "55505.63", "58805.63", isActive: false, color: Colors.lightBlueAccent),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildBottomGridMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationBanner(BuildContext context) {
    return InkWell(
      onTap: () => context.pop(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: const Color(0xFF4FC3F7), borderRadius: BorderRadius.circular(8)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back_ios, color: Colors.white, size: 16),
            SizedBox(width: 8),
            Text("1st Page Navigate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        indicator: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(6)),
        indicatorPadding: const EdgeInsets.all(4),
        tabs: const [
          Tab(text: "Summary"),
          Tab(text: "SLD"),
          Tab(text: "Data"),
        ],
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
                PieChartSectionData(color: Colors.blueAccent, value: 75, radius: 25, showTitle: false),
                PieChartSectionData(color: Colors.blue.withOpacity(0.1), value: 25, radius: 25, showTitle: false),
              ],
              startDegreeOffset: 270,
              sectionsSpace: 0,
              centerSpaceRadius: 70,
            ),
          ),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Total Power", style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text("5.53 kw", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildToggleSwitch() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(20)),
              child: const Center(child: Text("Source", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            ),
          ),
          Expanded(
            child: Center(child: Text("Load", style: TextStyle(color: Colors.grey.shade600))),
          ),
        ],
      ),
    );
  }

  Widget _buildDataItem(String title, String d1, String d2, {required bool isActive, required Color color}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(width: 40, height: 40, color: color.withOpacity(0.2), child: Icon(Icons.electric_bolt, color: color)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 8, height: 8, color: color),
                    const SizedBox(width: 5),
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    Text(isActive ? "(Active)" : "(Inactive)", style: TextStyle(fontSize: 10, color: isActive ? Colors.blue : Colors.red)),
                  ],
                ),
                Text("Data 1 : $d1", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text("Data 2 : $d2", style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildBottomGridMenu() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3.5,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildMenuButton("Analysis Pro", Icons.analytics),
        _buildMenuButton("G. Generator", Icons.generating_tokens_outlined),
        _buildMenuButton("Plant Summary", Icons.summarize),
        _buildMenuButton("Natural Gas", Icons.local_fire_department),
        _buildMenuButton("D. Generator", Icons.power_settings_new),
        _buildMenuButton("Water Process", Icons.water_drop),
      ],
    );
  }

  Widget _buildMenuButton(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.orange, size: 20),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }
}

