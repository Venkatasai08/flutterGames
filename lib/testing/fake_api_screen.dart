import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';
import 'package:fluttergames/testing/fake_model.dart';
import 'package:fluttergames/testing/fake_riverpod.dart';

class FakeApiScreen extends ConsumerWidget {
  const FakeApiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer(
                
                builder: (context, value, child) {
                  List<FakeModel> data = value.watch(fakeStateRiverPod);
                  var watchP = value.watch(fakeRiverPod);
                  return watchP.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(data[index].title)),
                                      Checkbox(
                                          value: data[index].completed,
                                          onChanged: (v) {})
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: () {
                    ref.read(fakeStateRiverPod.notifier).getListUpdateState();
                  },
                  child: const Text("GetData")),
            )
          ],
        ),
      ),
    );
  }
}
