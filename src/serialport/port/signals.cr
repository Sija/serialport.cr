module SerialPort
  class Port
    module Signals
      def signals : LibSerialPort::Signal
        SerialPort.check! LibSerialPort.get_signals(self, out signal_mask)
        signal_mask
      end

      def start_break : Void
        SerialPort.check! LibSerialPort.start_break(self)
      end

      def end_break : Void
        SerialPort.check! LibSerialPort.end_break(self)
      end
    end
  end
end
