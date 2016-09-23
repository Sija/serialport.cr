require "./struct"
require "./port/*"

module SerialPort
  class Port
    include SerialPort::Struct(LibSerialPort::Port)

    include Enumeration
    include Handling
    include Configuration
    include Signals
    include Data

    def name
      String.new LibSerialPort.get_port_name(self)
    end

    def description
      String.new LibSerialPort.get_port_description(self)
    end

    def transport
      LibSerialPort.get_port_transport(self)
    end

    def usb_bus_address
      SerialPort.check! LibSerialPort.get_port_usb_bus_address(self, out usb_bus, out usb_address)
      {usb_bus, usb_address}
    end

    def usb_vid_pid
      SerialPort.check! LibSerialPort.get_port_usb_vid_pid(self, out usb_vid, out usb_pid)
      {usb_vid, usb_pid}
    end

    def usb_manufacturer
      String.new LibSerialPort.get_port_usb_manufacturer(self)
    end

    def usb_product
      String.new LibSerialPort.get_port_usb_product(self)
    end

    def usb_serial
      String.new LibSerialPort.get_port_usb_serial(self)
    end

    def bluetooth_address
      String.new LibSerialPort.sp_get_port_bluetooth_address(self)
    end

    def handle
      fd = uninitialized LibC::Int
      SerialPort.check! LibSerialPort.get_port_handle(self, pointerof(fd))
      fd
    end
  end
end
