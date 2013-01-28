require "ios-sim-test/version"

class IOSSimTest
  def initialize(xcodebuild_params)
    @xcodebuild_params = xcodebuild_params
  end

  def simulator_home_dir
    File.expand_path('~/Library/Application Support/iPhone Simulator')
  end

  def sdk_dir
    build_settings['SDK_DIR']
  end

  def developer_frameworks_dir
    File.join(sdk_dir, build_settings['DEVELOPER_FRAMEWORKS_DIR'])
  end

  def built_products_dir
    build_settings['BUILT_PRODUCTS_DIR']
  end

  def built_product_path
    File.join(built_products_dir, build_settings['FULL_PRODUCT_NAME'])
  end

  def otest_bin_path
    File.join(sdk_dir, 'Developer/usr/bin/otest')
  end

  private

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
  end
end
