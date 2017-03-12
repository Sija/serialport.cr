require "./spec_helper"

VERSION_PATTERN = /^\d+(\.\d+){2,3}(-\w+)?$/
ENV_DEBUG_KEY   = "DEBUG"

describe SerialPort do
  describe ".package_version" do
    it "should have proper format" do
      SerialPort.package_version.should match VERSION_PATTERN
    end
  end

  describe ".check!" do
    context "the return code is OK" do
      it "should not raise" do
        (SerialPort.check!(LibSerialPort::Return::OK) rescue :raised).should_not eq :raised
      end
    end
    context "the return code is not OK" do
      it "raises SerialPort::Error with return code" do
        rc = LibSerialPort::Return::ERR_ARG

        expect_raises(SerialPort::Error, rc) do
          SerialPort.check!(rc)
        end
      end
    end
    context "the return code is ERR_FAIL" do
      it "raises SerialPort::OSError" do
        expect_raises(SerialPort::OSError) do
          SerialPort.check! LibSerialPort::Return::ERR_FAIL
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
