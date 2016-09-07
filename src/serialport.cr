require "./serialport/lib/*"
require "./serialport/*"

module SerialPort
  def self.package_version
    String.new LibSerialPort.get_package_version_string
  end
end
