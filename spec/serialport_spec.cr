require "./spec_helper"

VERSION_PATTERN = /^\d+(\.\d+){2,3}(-\w+)?$/

describe SerialPort do
  # TODO: Write tests

  describe "VERSION" do
    it "should have proper format" do
      SerialPort::VERSION.should match VERSION_PATTERN
    end
  end

  describe ".package_version" do
    it "should have proper format" do
      SerialPort.package_version.should match VERSION_PATTERN
    end
  end
end
