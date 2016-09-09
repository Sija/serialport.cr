module SerialPort
  module Struct(T)
    @ptr : T*?

    def initialize(ptr : T*? = nil)
      self.ptr = ptr
    end

    def to_unsafe : T*
      # SerialPort.log ptr, backtrace_offset: 1
      ptr
    end

    def wrapped : T
      ptr.value
    end

    def ptr? : T*?
      @ptr
    end

    def ptr : T*
      @ptr ||= Pointer(T).null
    end

    protected def ptr=(ptr) : T*?
      # SerialPort.log ptr, backtrace_offset: 1
      @ptr = ptr
    end
  end
end
