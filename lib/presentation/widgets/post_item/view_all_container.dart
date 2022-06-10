import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class ViewAllCommentsContainer extends StatelessWidget {
  final VoidCallback onTap;
  const ViewAllCommentsContainer({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 2, bottom: 4),
        child: Text(
          S.of(context).view_all_comments,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
