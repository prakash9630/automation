import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/project_model.dart';

class ProjectController extends GetxController {
  final List<ProjectModel> allProjects = <ProjectModel>[].obs;
  final RxList<ProjectModel> filteredProjects = <ProjectModel>[].obs;
  
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
    // Initially display all projects
    filteredProjects.assignAll(allProjects);
  }

  void _loadDummyData() {
    allProjects.addAll([
      ProjectModel(
        id: '1',
        name: 'Demo',
        company: 'Insource Inc Pvt Ltd',
        initials: 'DE',
        color: const Color(0xFF4A8BEE), // Blue
        isFavorite: true,
      ),
      ProjectModel(
        id: '2',
        name: 'Ehr Update Log',
        company: 'Insource Inc Pvt Ltd',
        initials: 'EH',
        color: const Color(0xFFED8936), // Orange
      ),
      ProjectModel(
        id: '3',
        name: 'Insource : iHRIS',
        company: 'Insource Inc Pvt Ltd',
        initials: 'IN',
        color: const Color(0xFF37475A), // Dark Navy
        isFavorite: true,
      ),
      ProjectModel(
        id: '4',
        name: 'Automation Marketing',
        company: 'Insource Inc Pvt Ltd',
        initials: 'AU',
        color: const Color(0xFF9F7AEA), // Purple
      ),
      ProjectModel(
        id: '5',
        name: 'AMC Manager',
        company: 'Insource Inc Pvt Ltd',
        initials: 'AM',
        color: const Color(0xFF48BB78), // Green
        isFavorite: true,
      ),
      ProjectModel(
        id: '6',
        name: 'Sodvelon Registration',
        company: 'Insource Inc Pvt Ltd',
        initials: 'SO',
        color: const Color(0xFF38B2AC), // Teal
      ),
    ]);
  }

  void searchProjects(String query) {
    if (query.isEmpty) {
      filteredProjects.assignAll(allProjects);
    } else {
      filteredProjects.assignAll(allProjects.where((project) {
        return project.name.toLowerCase().contains(query.toLowerCase()) ||
               project.company.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
  }
  
  void toggleFavorite(String id) {
    final project = allProjects.firstWhereOrNull((p) => p.id == id);
    if (project != null) {
      project.isFavorite.value = !project.isFavorite.value;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
