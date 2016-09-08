require "./spec_helper"

VERSION_PATTERN = /^\d+(\.\d+){2,3}(-\w+)?$/
ENV_DEBUG_KEY = "DEBUG"

describe SerialPort do
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

  describe ".check?" do
    context "the return code is OK" do
      it "returns true" do
        SerialPort.check?(LibSerialPort::Return::OK).should be_true
      end
    end
    context "the return code is not OK" do
      it "returns false" do
        SerialPort.check?(LibSerialPort::Return::ERR_ARG).should be_false
      end
    end
  end

  describe ".check!" do
    context "the return code is OK" do
      it "should not raise" do
        (SerialPort.check!(LibSerialPort::Return::OK) rescue :raised).should_not eq :raised
      end
    end
    context "the return code is not OK" do
      it "raises SerialPort::Error with a message and error code" do
        code = LibSerialPort::Return::ERR_ARG
        message = "Undefined error: 0 (#{code})"

        expect_raises(SerialPort::Error, message) do
          SerialPort.check!(code)
        end
      end
    end
  end

  describe ".debug?" do
    context "ENV debug key is set to '1'" do
      debug_flag = ENV[ENV_DEBUG_KEY]?
      begin
        ENV[ENV_DEBUG_KEY] = "1"
        it "should be true" do
          SerialPort.debug?.should be_true
        end
      ensure
        ENV[ENV_DEBUG_KEY] = debug_flag
      end
    end
    context "ENV debug key is set to value other than '1'" do
      debug_flag = ENV[ENV_DEBUG_KEY]?
      begin
        ENV[ENV_DEBUG_KEY] = "10"
        it "should be false" do
          SerialPort.debug?.should be_false
        end
      ensure
        ENV[ENV_DEBUG_KEY] = debug_flag
      end
    end
    context "ENV debug key is unset" do
      debug_flag = ENV.delete ENV_DEBUG_KEY
      begin
        it "should be false" do
          SerialPort.debug?.should be_false
        end
      ensure
        ENV[ENV_DEBUG_KEY] = debug_flag
      end
    end
  end
end
