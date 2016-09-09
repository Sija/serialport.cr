require "./struct"

module SerialPort
  class PortConfig
    include SerialPort::Struct(LibSerialPort::PortConfig)

    def initialize
      new
    end

    def finalize
      free
    end

    private def new
      SerialPort.check! LibSerialPort.new_config(out ptr)
      self.ptr = ptr
    end

    private def free
      LibSerialPort.free_config(self)
      self.ptr = nil
    end

    def baudrate : Int32
      SerialPort.check! LibSerialPort.get_config_baudrate(self, out baudrate)
      baudrate.to_i
    end

    def baudrate=(baudrate : Int32) : Void
      SerialPort.check! LibSerialPort.set_config_baudrate(self, baudrate.to_i16)
    end

    def parity : LibSerialPort::Parity
      SerialPort.check! LibSerialPort.get_config_parity(self, out parity)
      parity
    end

    def parity=(parity : Symbol) : Void
      parity = LibSerialPort::Parity.parse(parity.to_s)
      SerialPort.check! LibSerialPort.set_config_parity(self, parity)
    end

    def bits : Int32
      SerialPort.check! LibSerialPort.get_config_bits(self, out bits)
      bits.to_i
    end

    def bits=(bits : Int32) : Void
      SerialPort.check! LibSerialPort.set_config_bits(self, bits.to_i16)
    end

    def stopbits : Int32
      SerialPort.check! LibSerialPort.get_config_stopbits(self, out stopbits)
      stopbits.to_i
    end

    def stopbits=(stopbits : Int32) : Void
      SerialPort.check! LibSerialPort.set_config_stopbits(self, stopbits.to_i16)
    end

    def rts : LibSerialPort::RTS
      SerialPort.check! LibSerialPort.get_config_rts(self, out rts)
      rts
    end

    def rts=(rts : Symbol) : Void
      rts = LibSerialPort::RTS.parse(rts.to_s)
      SerialPort.check! LibSerialPort.set_config_rts(self, rts)
    end

    def cts : LibSerialPort::CTS
      SerialPort.check! LibSerialPort.get_config_cts(self, out cts)
      cts
    end

    def cts=(cts : Symbol) : Void
      cts = LibSerialPort::CTS.parse(cts.to_s)
      SerialPort.check! LibSerialPort.set_config_cts(self, cts)
    end

    def dtr : LibSerialPort::DTR
      SerialPort.check! LibSerialPort.get_config_dtr(self, out dtr)
      dtr
    end

    def dtr=(dtr : Symbol) : Void
      dtr = LibSerialPort::DTR.parse(dtr.to_s)
      SerialPort.check! LibSerialPort.set_config_dtr(self, dtr)
    end

    def dsr : LibSerialPort::DSR
      SerialPort.check! LibSerialPort.get_config_dsr(self, out dsr)
      dsr
    end

    def dsr=(dsr : Symbol) : Void
      dsr = LibSerialPort::DSR.parse(dsr.to_s)
      SerialPort.check! LibSerialPort.set_config_dsr(self, dsr)
    end

    def xon_xoff : LibSerialPort::XonXoff
      SerialPort.check! LibSerialPort.get_config_xon_xoff(self, out xon_xoff)
      xon_xoff
    end

    def xon_xoff=(xon_xoff : Symbol) : Void
      xon_xoff = LibSerialPort::XonXoff.parse(xon_xoff.to_s)
      SerialPort.check! LibSerialPort.set_config_xon_xoff(self, xon_xoff)
    end

    def flowcontrol : LibSerialPort::FlowControl
      SerialPort.check! LibSerialPort.get_config_flowcontrol(self, out flowcontrol)
      flowcontrol
    end

    def flowcontrol=(flowcontrol : Symbol) : Void
      flowcontrol = LibSerialPort::FlowControl.parse(flowcontrol.to_s)
      SerialPort.check! LibSerialPort.set_config_flowcontrol(self, flowcontrol)
    end
  end
end
