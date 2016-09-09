require "./struct"
require "./port/*"

module SerialPort
  class Port
    include SerialPort::Struct(LibSerialPort::Port)

    include Enumeration
    include Configuration
  end
end
