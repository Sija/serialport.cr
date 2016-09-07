require "./serialport/lib/*"
require "./serialport/*"

module SerialPort
  def self.package_version
    String.new LibSerialPort.get_package_version_string
  end

  def self.check?(rc : LibSerialPort::Return) : Bool
    rc == LibSerialPort::Return::OK
  end

  def self.check!(rc : LibSerialPort::Return) : LibSerialPort::Return
    return rc if check?(rc)

    code = LibSerialPort.last_error_code
    message_ptr = LibSerialPort.last_error_message
    message = String.new message_ptr

    LibSerialPort.free_error_message message_ptr

    raise Error.new(message, code.to_i, rc)
  end
end
