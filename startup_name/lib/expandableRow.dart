import 'package:flutter/material.dart';
import 'package:startup_name/company.dart';
import 'package:startup_name/listCard.dart';

class ExpandableRow extends StatefulWidget {
  final Company company;
  final CompanyController cc;
  ExpandableRow({required this.company, required this.cc});

  @override
  _ExpandableRowState createState() =>
      _ExpandableRowState(company: company, cc: cc);
}

class _ExpandableRowState extends State<ExpandableRow> {
  final Company company;
  final CompanyController cc;
  _ExpandableRowState({required this.company, required this.cc});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(company.getName()),
        leading: CircleAvatar(
          child: ClipOval(
            child: Image.network(company.getUrl(), fit: BoxFit.fill),
          ),
          backgroundColor: Colors.transparent,
        ),
        children: <Widget>[ListCard(company: company, cc: cc)],
      ),
    );
  }
}
