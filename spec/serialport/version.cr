require "yaml"
require "../spec_helper"

describe SerialPort::VERSION do
  it "should have proper format" do
    SerialPort::VERSION.should match /^\d+(\.\d+){2,3}(-\w+)?$/
  end

  it "should match shard.yml" do
    version = YAML.parse(File.read(File.join(__DIR__, "../..", "shard.yml")))["version"].as_s
    version.should eq SerialPort::VERSION
  end
end
