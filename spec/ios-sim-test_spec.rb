$:.unshift File.expand_path('../../lib', __FILE__)
require 'ios-sim-test'

require 'bacon'
require 'mocha-on-bacon'

def fixture(name)
  File.join(File.expand_path('../fixtures', __FILE__), name)
end

describe "IOSSimTest" do
  before do
    @runner = IOSSimTest.new(:workspace => '/path/to/workspace', :scheme => 'UnitTests')
    @runner.stubs(:load_build_settings).returns(File.read(fixture('build-settings.txt')))
  end

  it "returns the iOS simulator home directory path" do
    @runner.simulator_home_dir.should == File.expand_path('~/Library/Application Support/iPhone Simulator')
  end

  #it "ensures the iOS simulator home directory exists" do
    #FileUtils.expects(:mkdir_p).with(@runner.simulator_home_dir)
    #@runner.setup
  #end

  describe "concerning build settings" do
    it "returns the SDK root" do
      @runner.sdk_dir.should == '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.0.sdk'
    end

    it "returns the developer frameworks dir" do
      @runner.developer_frameworks_dir.should == File.join(@runner.sdk_dir, 'Applications/Xcode.app/Contents/Developer/Library/Frameworks')
    end

    it "returns the path to the otest binary" do
      @runner.otest_bin_path.should == File.join(@runner.sdk_dir, 'Developer/usr/bin/otest')
    end

    it "returns the build directory of a project" do
      @runner.built_products_dir.should == '/Users/eloy/tmp/libPusher/DerivedData/libPusher/Build/Products/Debug-iphonesimulator'
    end

    it "returns the built product path" do
      @runner.built_product_path.should == File.join(@runner.built_products_dir, 'UnitTests.octest')
    end
  end
end
