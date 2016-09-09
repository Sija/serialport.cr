module SerialPort
  class Exception < ::Exception; end

  class Error < Exception
    getter rc : LibSerialPort::Return

    def initialize(@rc : LibSerialPort::Return)
    end

    def to_s(io)
      io << rc
    end
  end

  class ArgumentError < Error
    def initialize
      super(LibSerialPort::Return::ERR_ARG)
    end
  end

  class NotSupportedError < Error
    def initialize
      super(LibSerialPort::Return::ERR_SUPP)
    end
  end

  class MemoryAllocationError < Error
    def initialize
      super(LibSerialPort::Return::ERR_MEM)
    end
  end

  class OSError < Error
    getter code : Int32

    def initialize(@message : String, @code : Int32)
      super(LibSerialPort::Return::ERR_FAIL)
    end

    def to_s(io)
      io << message << ' ' << '(' << code << ')'
    end
  end
end
