import 'package:core/core/sync_engine/pods/sync_client_provider.dart';
import 'package:core/core/utils/number_validator.dart';
import 'package:core/features/running/entities/running_entity.dart';
import 'package:core/features/running/models/intensity.dart';
import 'package:core/features/running/models/running_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';
import 'package:ui/widgets/card.dart';

class CreateRunningScreen extends ConsumerStatefulWidget {
  const CreateRunningScreen({super.key, required this.title});
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateRunningScreenState();
}

class _CreateRunningScreenState extends ConsumerState<CreateRunningScreen> {
  final _formKey = GlobalKey<FormState>();

  final distanceController = TextEditingController();
  final intensityController = ValueNotifier<Intensity?>(null);

  @override
  Widget build(BuildContext context) {
    final client = ref.read(syncClientProvider);
    final entity = client.getEntity<RunningEntity>();
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(16)),
      child: DraggableScrollableSheet(
        snap: true,
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.7,
        minChildSize: 0.68,
        builder: (context, scrollController) => Scaffold(
          body: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8),
                      Text(
                        "Track a Run",
                        style: TextTheme.of(context).titleMedium,
                      ),
                      SizedBox(height: 24),
                      MyCard(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextFormField(
                            controller: distanceController,
                            autocorrect: false,
                            autofocus: true,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              labelText: "Distance",
                              suffixText: "km",
                            ),
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            validator: (value) => numberValidator(
                              value,
                              positive: true,
                              required: true,
                              nonZero: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SingleSelectorFormField<Intensity>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: intensityController,
                        allowDeselect: false,
                        label: "Intensity",
                        subtitle: "please select the intensity of your workout",
                        items: Intensity.values,
                        labelBuilder: (Intensity item) => item.name,
                        validator: (value) => value == null
                            ? "please select one of the options above"
                            : null,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text("Cancel"),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            child: Text("Confirm"),
                            onPressed: () async {
                              final valid =
                                  _formKey.currentState?.validate() ?? false;
                              if (valid) {
                                final intensity =
                                    intensityController.value ?? Intensity.low;
                                final distance = double.parse(
                                  distanceController.text,
                                );
                                client.insert(
                                  entity,
                                  RunningEntry(
                                    intensity: intensity,
                                    distance: distance,
                                    timestamp: DateTime.now(),
                                  ),
                                );
                                context.pop();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
