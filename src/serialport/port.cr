require "./struct"

module SerialPort
  class Port
    include SerialPort::Struct(LibSerialPort::Port)
  end
end
