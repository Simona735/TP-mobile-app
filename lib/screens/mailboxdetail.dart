import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class MailboxDetail extends StatefulWidget {
  final mailboxId;

  const MailboxDetail({
    Key? key,
    @PathParam() required this.mailboxId,
  }) : super(key: key);

  @override
  State<MailboxDetail> createState() => _MailboxDetailState();
}

class _MailboxDetailState extends State<MailboxDetail> {
  @override
  Widget build(BuildContext context) {
    return ListView(
    );
  }
}
