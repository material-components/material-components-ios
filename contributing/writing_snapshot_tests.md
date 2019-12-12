# Writing Snapshot Tests for Components

Snapshot tests are a useful tool to help mitigate visual regressions for
components when changes are made. The following describes the steps to take in
order to write snapshot tests for a component:

1.  Ensure you have installed and configured git-lfs. See
    [here](https://github.com/material-components/material-components-ios/blob/develop/contributing/tools.md#using-git-lfs)
    for steps on how to do this.

2.  If the component you wish to write tests for already has some snapshot
    tests, proceed to step 7.

3.  Add an entry in the **MaterialComponentsSnapshotTest.podspec** file for
    tests for the component you wish to test. For example:

```
  ...
  s.subspec "Cards" do |component|
    component.ios.deployment_target = '9.0'
    component.test_spec 'tests' do |tests|
      tests.test_spec 'snapshot' do |snapshot_tests|
        snapshot_tests.requires_app_host = true
        snapshot_tests.source_files = "components/#{component.base_name}/tests/snapshot/*.{h,m,swift}", "components/#{component.base_name}/tests/snapshot/supplemental/*.{h,m,swift}"
        snapshot_tests.resources = "components/#{component.base_name}/tests/snapshot/resources/*"
        snapshot_tests.dependency "MaterialComponentsSnapshotTests/private/Snapshot"
      end
    end
  end
  ...
```

4.  Add the new snapshot test target to the **Podfile**. For example:

```
  pod MaterialComponentsSnapshotTests, :path => '../', :testspecs => [
    ...
    'Cards/tests/snapshot',
    ...
  ]
```

5.  Create a directory named `snapshot` in the `tests` directory of the
    component.

6.  Create a test class named `MDC<#component>SnapshotTests`. Have this test
    class subclass `MDCSnapshotTestCase`.

7.  Write your snapshot test. The following is an example for the Cards
    component:

```
  - (void)testDefaultCard {
    // Uncomment below to recreate the golden
    //  self.recordMode = YES;

    // Given
    MDCCard *card = [[MDCCard alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];


    // Then
    UIView *backgroundView = [self addBackgroundViewToView:card];
    [self snapshotVerifyView:backgroundView];
  }
```

8.  Set `recordMode` to true in the test method.

9.  Run the snapshot tests on the **iPhone 7 11.2 simulator** to generate the
    golden. **Note**: This will show a test failure to help remind you to remove
    `recordMode` before pushing up your changes. However, the error message is a
    little unclear:

```
    ((noErrors) is true) failed - Snapshot comparison failed: (null)
```

10.  Remove the logic that set `recordMode` to true and re-run your test and
    ensure it passes.

Once, you've written your first snapshot test, it becomes trivial to write
subsequent tests.

**Note:** We currently only support iPhone 7 11.2 snapshots due to the
difficulty in generating different combinations of snapshots. The snapshots
themselves render differently across devices and OS versions.

