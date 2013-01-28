require 'ios-sim-test/version'
require 'fileutils'

class IOSSimTest
  attr_reader :xcodebuild_params

  def initialize(xcodebuild_params)
    @xcodebuild_params = { :sdk => 'iphonesimulator' }.merge(xcodebuild_params)
  end

  def simulator_home_dir
    File.expand_path('~/Library/Application Support/iPhone Simulator')
  end

  def sdk_dir
    validate_path('SDK', build_settings['SDK_DIR'])
  end

  def developer_frameworks_dir
    validate_path('developer frameworks', File.join(sdk_dir, build_settings['DEVELOPER_FRAMEWORKS_DIR']))
  end

  def built_products_dir
    validate_path('build directory', build_settings['BUILT_PRODUCTS_DIR'])
  end

  def built_product_path
    validate_path('test bundle', File.join(built_products_dir, build_settings['FULL_PRODUCT_NAME']))
  end

  def otest_bin_path
    validate_path('otest binary', File.join(sdk_dir, 'Developer/usr/bin/otest'))
  end

  def environment
    {
      'DYLD_NEW_LOCAL_SHARED_REGIONS' => 'YES',
      'DYLD_NO_FIX_PREBINDING'        => 'YES',
      'CFFIXED_USER_HOME'             => simulator_home_dir,
      'IPHONE_SIMULATOR_ROOT'         => sdk_dir,
      'DYLD_ROOT_PATH'                => sdk_dir,
      'DYLD_LIBRARY_PATH'             => built_products_dir,
      'DYLD_FRAMEWORK_PATH'           => "#{built_products_dir}:#{developer_frameworks_dir}",
    }
  end

  def run_command(tests)
    tests = tests.empty? ? 'All' : tests.uniq.join(',')
    "#{otest_bin_path} -SenTest #{tests} #{built_product_path} 2>&1"
  end

  def run(tests)
    FileUtils.mkdir_p(simulator_home_dir)
    exec(run_command(tests))
  end

  private

  def validate_path(desc, path)
    raise "The #{desc} path does not exist at: #{path}" unless File.exist?(path)
    path
  end

  def build_settings
    unless @build_settings
      load_build_settings.strip.each_line do |line|
        if @build_settings.nil?
          if line =~ /\ABuild settings for action build and target/
            @build_settings = {}
          end
        else
          key, value = line.strip.split(' = ', 2)
          @build_settings[key] = value
        end
      end
    end
    @build_settings
  end

  def load_build_settings
    # TODO call: xcodebuild -sdk iphonesimulator -showBuildSettings
    `xcodebuild #{xcodebuild_params.map { |k,v| "-#{k} '#{v}'" }.join(' ')} -showBuildSettings`
  end
end
