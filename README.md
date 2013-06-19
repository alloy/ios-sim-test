# ios-sim-test

Run iOS ‘logic’ unit tests from the command-line.

### Installation

For now this will have to be installed directly from the repo or by using Bundler.

### Usage

Be sure to create a scheme specifically for your unit test bundle target, so
that you can easily build the binary with `xcodebuild`, but also so that we can
easily get build settings just for that target.

```
$ ios-sim-test logic --workspace=/path/to/Project.xcworkspace --scheme=UnitTests
```

### TODO

* Support ‘application’ unit tests.
