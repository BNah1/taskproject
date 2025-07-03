import 'package:taskproject/model/project_model.dart';
import 'package:taskproject/model/task_model.dart';
import 'package:taskproject/model/user_model.dart';

class MockData {
  static List<UserModel> listUserMock = [
    UserModel("Alice", "u001", "assets/avaters/avatar_1.jpg"),
    UserModel("Bob", "u002", "assets/avaters/avatar_1.jpg"),
    UserModel("Diana", "u003", "assets/avaters/avatar_1.jpg"),
    UserModel("Urgot", "u004", "assets/avaters/avatar_1.jpg"),
  ];

  static List<TaskModel> listTaskMock = [
    TaskModel(
      "Design Homepage",
      DateTime(2025, 7, 10),
      [listUserMock[0], listUserMock[1], listUserMock[2]],
      // Alice + Bob + Diana
      listUserMock[2],
      // Diana
      ["Sketch layout", "Create prototype"],
      "Design the homepage for the new project. Design the homepage for the new project. Design the homepage for the new project.",
      "High",
      "p001",
      DateTime(2025, 7, 12),
      0.3,
      "Complete",
    ),
    TaskModel(
      "Build Login Page asd",
      DateTime(2025, 7, 11, 12),
      [listUserMock[0]],
      // Alice
      listUserMock[3],
      // Urgot
      ["Design UI", "Implement logic"],
      "Create login functionality",
      "High",
      "p001",
      DateTime(2025, 7, 13),
      0.5,
      "Complete",
    ),
    TaskModel(
      "Setup Database",
      DateTime(2025, 7, 13),
      [listUserMock[0], listUserMock[2]],
      // Alice + Diana
      listUserMock[1],
      // Bob
      ["ERD design", "Table creation"],
      "Prepare the database schema",
      "Medium",
      "p002",
      DateTime(2025, 7, 15),
      0.2,
      "In Process",
    ),
    TaskModel(
      "Write Unit Tests",
      DateTime(2025, 7, 16),
      [listUserMock[0]],
      // Alice
      listUserMock[1],
      // Bob
      ["Login test", "Register test"],
      "Ensure all flows are tested",
      "Low",
      "p002",
      DateTime(2025, 7, 18),
      0.1,
      "Reviewing",
    ),
    TaskModel(
      "Setup Database",
      DateTime(2025, 7, 13),
      [listUserMock[0], listUserMock[2]],
      // Alice + Diana
      listUserMock[1],
      // Bob
      ["ERD design", "Table creation"],
      "Prepare the database schema",
      "Medium",
      "p002",
      DateTime(2025, 7, 15),
      0.2,
      "Complete",
    ),
    TaskModel(
      "Write Unit Tests",
      DateTime(2025, 7, 16),
      [listUserMock[0]],
      // Alice
      listUserMock[1],
      // Bob
      ["Login test", "Register test"],
      "Ensure all flows are tested",
      "Low",
      "p002",
      DateTime(2025, 7, 18),
      0.1,
      "Complete",
    ),

    TaskModel(
      "Check UI Review",
      DateTime(2025, 7, 2, 9, 0),
      // 9:00 AM
      [listUserMock[0]],
      listUserMock[1],
      ["Dashboard screen", "Profile screen"],
      "Quick review of UI progress",
      "Medium",
      "p010",
      DateTime(2025, 7, 2, 10, 0),
      0.3,
      "Complete",
    ),
    TaskModel(
      "Fix Login Bug",
      DateTime(2025, 7, 2, 11, 45),
      // 9:45 AM
      [listUserMock[1]],
      listUserMock[0],
      ["Error on wrong credentials", "Missing loader"],
      "Handle edge cases in login",
      "High",
      "p011",
      DateTime(2025, 7, 2, 12, 50),
      0.5,
      "Complete",
    ),
    TaskModel(
      "Write Documentation",
      DateTime(2025, 7, 2, 13, 15),
      // 10:15 AM
      [listUserMock[2]],
      listUserMock[0],
      ["API usage", "Error handling"],
      "Prepare docs for handoff",
      "Low",
      "p012",
      DateTime(2025, 7, 2, 14, 0),
      0.2,
      "Complete",
    ),
    TaskModel(
      "Write Documentation",
      DateTime(2025, 7, 2, 16, 15),
      // 10:15 AM
      [listUserMock[2]],
      listUserMock[0],
      ["API usage", "Error handling"],
      "Prepare docs for handoff",
      "Low",
      "p012",
      DateTime(2025, 7, 2, 17, 0),
      0.2,
      "Complete",
    ),
  ];

  static List<ProjectModel> listProjectMock = [
    ProjectModel(
      projectId: "p001",
      projectName: "Frontend Redesign",
      taskDeadLine: DateTime(2025, 7, 20),
      taskAssigned: [listUserMock[0], listUserMock[1]],
      // Alice + Bob
      taskCreatedBy: listUserMock[2],
      // Diana
      listTask: listTaskMock.where((task) => task.projectId == "p001").toList(),
      progress: 0.7,
      description: "Prepare the database schema Prepare the database schemaPrepare the database schemaPrepare the database schema",
      typeProcess: "IN WORK",
      urgent: "Mid",
      type: "Dev",
    ),
    ProjectModel(
      projectId: "p003",
      projectName: "Frontend Redesign Prepare the database schema",
      taskDeadLine: DateTime(2025, 7, 20),
      taskAssigned: [listUserMock[0], listUserMock[1]],
      // Alice + Bob
      taskCreatedBy: listUserMock[2],
      // Diana
      listTask: listTaskMock.where((task) => task.projectId == "p003").toList(),
      progress: 0.7,
      description: "Prepare the database schema Prepare the database schemaPrepare the database schemaPrepare the database schemaPrepare the database schema",
      typeProcess: "IN WORK",
      urgent: "Low",
      type: "Design",
    ),
    ProjectModel(
      projectId: "p002",
      projectName: "Backend System",
      taskDeadLine: DateTime(2025, 7, 25),
      taskAssigned: [listUserMock[0], listUserMock[2]],
      // Alice + Diana
      taskCreatedBy: listUserMock[3],
      // Urgot
      listTask: listTaskMock.where((task) => task.projectId == "p002").toList(),
      progress: 0.85,
      description: "Prepare the database schema",
      typeProcess: "COMPLETE",
      urgent: "Low",
      type: "Research",
    ),
    ProjectModel(
      projectId: "p003",
      projectName: "Frontend Redesign",
      taskDeadLine: DateTime(2025, 7, 20),
      taskAssigned: [listUserMock[0], listUserMock[1]],
      // Alice + Bob
      taskCreatedBy: listUserMock[2],
      // Diana
      listTask: listTaskMock.where((task) => task.projectId == "p003").toList(),
      progress: 0.7,
      description: "Prepare the database schema",
      typeProcess: "IN WORK",
      urgent: "High",
      type: "Design",
    ),
    ProjectModel(
      projectId: "p002",
      projectName: "Backend System",
      taskDeadLine: DateTime(2025, 7, 25),
      taskAssigned: [listUserMock[0], listUserMock[2]],
      // Alice + Diana
      taskCreatedBy: listUserMock[3],
      // Urgot
      listTask: listTaskMock.where((task) => task.projectId == "p002").toList(),
      progress: 0.85,
      description: "Prepare the database schemaPrepare the database schemaPrepare the database schema",
      typeProcess: "COMPLETE",
      urgent: "High",
      type: "Research",
    ),
  ];
}
