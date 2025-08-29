import 'package:flutter/material.dart';
import '../../../../models/employee.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(employee.pictureUrl),
        ),
        title: Text(employee.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employee.workspace),
            if (employee.note != null) Text(employee.note!),
          ],
        ),
      ),
    );
  }
}
