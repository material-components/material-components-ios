load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

ios_test_runner(
    name = "IPHONE_5_IN_8_1",
    device_type = "iPhone 5",
    os_version = "8.1",
    visibility = ["//visibility:public"],
)

ios_test_runner(
    name = "IPAD_PRO_12_9_IN_9_3",
    device_type = "iPad Pro (12.9-inch)",
    os_version = "9.3",
    visibility = ["//visibility:public"],
)

ios_test_runner(
    name = "IPHONE_7_IN_11_2",
    device_type = "iPhone 7",
    os_version = "11.2",
    visibility = ["//visibility:public"],
)

ios_test_runner(
    name = "IPHONE_7_PLUS_IN_10_3",
    device_type = "iPhone 7 Plus",
    os_version = "10.3",
    visibility = ["//visibility:public"],
)

ios_test_runner(
    name = "IPHONE_X_IN_11_0",
    device_type = select({
        ":xcode_9_0": "iPhone2017-C",
        "//conditions:default": "iPhone X",
    }),
    os_version = "11.0",
    visibility = ["//visibility:public"],
)

ios_test_runner(
    name = "IPHONE_8_IN_13_0",
    device_type = "iPhone 8",
    os_version = "13.0",
    visibility = ["//visibility:public"],
)

native.config_setting(
    name = "xcode_9_0",
    values = {"xcode_version": "9.0"},
)
