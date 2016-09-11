module SerialPort
  class Port
    module Data
      def blocking_read(count : Int32, timeout_ms : Int32 = 0) : Bytes
        data = uninitialized Pointer(UInt8)
        bytes = LibSerialPort.blocking_read(self, data.as(Void*), count.to_u32, timeout_ms.to_u16)
        SerialPort.check! LibSerialPort::Return.new(bytes)
        data.to_slice(bytes)
      end

      def blocking_read_next(count : Int32, timeout_ms : Int32 = 0) : Bytes
        data = uninitialized Pointer(UInt8)
        bytes = LibSerialPort.blocking_read_next(self, data.as(Void*), count.to_u32, timeout_ms.to_u16)
        SerialPort.check! LibSerialPort::Return.new(bytes)
        data.to_slice(bytes)
      end

      def nonblocking_read(count : Int32) : Bytes
        data = uninitialized Pointer(UInt8)
        bytes = LibSerialPort.nonblocking_read(self, data.as(Void*), count.to_u32)
        SerialPort.check! LibSerialPort::Return.new(bytes)
        data.to_slice(bytes)
      end

      def blocking_write(data : String | Bytes, timeout_ms : Int32 = 0) : Int32
        bytes = LibSerialPort.blocking_write(self, data.to_unsafe.as(Void*), data.bytesize.to_u32, timeout_ms.to_u16)
        SerialPort.check! LibSerialPort::Return.new(bytes)
        bytes
      end

      def nonblocking_write(data : String | Bytes) : Int32
        bytes = LibSerialPort.nonblocking_write(self, data.to_unsafe.as(Void*), data.bytesize.to_u32)
        SerialPort.check! LibSerialPort::Return.new(bytes)
        bytes
      end

      def input_waiting : Int32
        bytes = LibSerialPort.input_waiting(self)
        SerialPort.check! LibSerialPort::Return.new(bytes)
        bytes
      end

      def output_waiting : Int32
        bytes = LibSerialPort.output_waiting(self)
        SerialPort.check! LibSerialPort::Return.new(bytes)
        bytes
      end

      def flush(buffers : Symbol = :BOTH) : Void
        buffers = LibSerialPort::Buffer.parse(buffers.to_s)
        SerialPort.check! LibSerialPort.flush(self, buffers)
      end

      def drain : Void
        SerialPort.check! LibSerialPort.drain(self)
      end
    end
  end
end
