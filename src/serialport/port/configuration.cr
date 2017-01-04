module SerialPort
  class Port
    module Configuration
      getter config : PortConfig?

      def config : PortConfig
        @config ||= begin
          config = PortConfig.new
          SerialPort.check! LibSerialPort.get_config(self, config)
          config
        end
      end

      def save : Void
        SerialPort.check! LibSerialPort.set_config(self, config)
      end

      def baudrate=(rate : LibC::Int)
        SerialPort.check! LibSerialPort.set_baudrate(self, rate)
      end

      def parity=(parity : Symbol)
        parity = LibSerialPort::Parity.parse(parity.to_s)
        SerialPort.check! LibSerialPort.set_parity(self, parity)
      end

      def bits=(bits : LibC::Int)
        SerialPort.check! LibSerialPort.set_bits(self, bits)
      end

      def stopbits=(sb : LibC::Int)
        SerialPort.check! LibSerialPort.set_stopbits(self, sb)
      end

      def rts=(rts : Symbol)
        rts = LibSerialPort::RTS.parse(rts.to_s)
        SerialPort.check! LibSerialPort.set_rts(self, rts)
      end

      def cts=(cts : Symbol)
        cts = LibSerialPort::CTS.parse(cts.to_s)
        SerialPort.check! LibSerialPort.set_cts(self, cts)
      end

      def dtr=(dtr : Symbol)
        dtr = LibSerialPort::DTR.parse(dtr.to_s)
        SerialPort.check! LibSerialPort.set_dtr(self, dtr)
      end

      def dsr=(dsr : Symbol)
        dsr = LibSerialPort::DSR.parse(dsr.to_s)
        SerialPort.check! LibSerialPort.set_dsr(self, dsr)
      end

      def xon_xoff=(xx : Symbol)
        xx = LibSerialPort::XonXoff.parse(xx.to_s)
        SerialPort.check! LibSerialPort.set_xon_xoff(self, xx)
      end

      def flowcontrol=(fc : Symbol)
        fc = LibSerialPort::FlowControl.parse(fc.to_s)
        SerialPort.check! LibSerialPort.set_flowcontrol(self, fc)
      end
    end
  end
end
