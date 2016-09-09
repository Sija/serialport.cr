module SerialPort
  class Port
    module Handling
      getter? opened : Bool = false

      def finalize
        close if opened?
        super
      end

      def closed?
        !opened?
      end

      def open(mode : Symbol) : Bool
        return false if opened?
        begin
          mode = LibSerialPort::Mode.parse(mode.to_s)
          SerialPort.check! LibSerialPort.open(self, mode)
          @opened = true
        end
        true
      end

      def close : Bool
        return false if closed?
        begin
          SerialPort.check! LibSerialPort.close(self)
          @opened = false
        end
        true
      end
    end
  end
end
