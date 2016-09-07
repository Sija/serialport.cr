module SerialPort
  class Exception < ::Exception; end

  class Error < Exception
    getter rc : LibSerialPort::Return
    getter code : Int32

    def initialize(message : String?, @code : Int32, @rc : LibSerialPort::Return)
      super(message)
    end

    def to_s(io)
      io << message << ' ' << '(' << rc << ')'
    end
  end
end
