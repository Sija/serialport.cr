@[Link("serialport")]
lib LibSerialPort
  enum Return
    OK       =  0
    ERR_ARG  = -1
    ERR_FAIL = -2
    ERR_MEM  = -3
    ERR_SUPP = -4
  end

  enum Mode
    READ       = 1
    WRITE      = 2
    READ_WRITE = 3
  end

  enum Event
    RXREADY = 1
    TXREADY = 2
    ERROR   = 4
  end

  enum Buffer
    INPUT  = 1
    OUTPUT = 2
    BOTH   = 3
  end

  enum Parity
    INVALID = -1
    NONE    =  0
    ODD     =  1
    EVEN    =  2
    MARK    =  3
    SPACE   =  4
  end

  enum RTS
    INVALID     = -1
    OFF         =  0
    ON          =  1
    FLOWCONTROL =  2
  end

  enum CTS
    INVALID     = -1
    IGNORE      =  0
    FLOWCONTROL =  1
  end

  enum DTR
    INVALID     = -1
    OFF         =  0
    ON          =  1
    FLOWCONTROL =  2
  end

  enum DSR
    INVALID     = -1
    IGNORE      =  0
    FLOWCONTROL =  1
  end

  enum XonXoff
    INVALID  = -1
    DISABLED =  0
    IN       =  1
    OUT      =  2
    INOUT    =  3
  end

  enum FlowControl
    NONE    = 0
    XONXOFF = 1
    RTSCTS  = 2
    DTRDSR  = 3
  end

  enum Signal
    CTS = 1
    DSR = 2
    DCD = 4
    RI  = 8
  end

  enum Transport
    NATIVE
    USB
    BLUETOOTH
  end

  struct Port
    name : LibC::Char*
    description : LibC::Char*
    sp_transport : Transport
    usb_bus : LibC::Int
    usb_address : LibC::Int
    usb_vid : LibC::Int
    usb_pid : LibC::Int
    usb_manufacturer : LibC::Char*
    usb_product : LibC::Char*
    usb_serial : LibC::Char*
    bluetooth_address : LibC::Char*
    fd : LibC::Int
  end

  struct PortConfig
    baudrate : LibC::Int
    bits : LibC::Int
    parity : Parity
    stopbits : LibC::Int
    rts : RTS
    cts : CTS
    dtr : DTR
    dsr : DSR
    xon_xoff : XonXoff
  end

  struct EventSet
    handles : Void*
    masks : Event*
    count : UInt32
  end

  fun get_port_by_name = "sp_get_port_by_name"(portname : LibC::Char*, port_ptr : Port**) : Return
  fun free_port = "sp_free_port"(port : Port*) : Void
  fun list_ports = "sp_list_ports"(list_ptr : Port***) : Return
  fun copy_port = "sp_copy_port"(port : Port*, copy_ptr : Port**) : Return
  fun free_port_list = "sp_free_port_list"(ports : Port**) : Void
  fun open = "sp_open"(port : Port*, flags : Mode) : Return
  fun close = "sp_close"(port : Port*) : Return
  fun get_port_name = "sp_get_port_name"(port : Port*) : LibC::Char*
  fun get_port_description = "sp_get_port_description"(port : Port*) : LibC::Char*
  fun get_port_transport = "sp_get_port_transport"(port : Port*) : Transport
  fun get_port_usb_bus_address = "sp_get_port_usb_bus_address"(port : Port*, usb_bus : LibC::Int*, usb_address : LibC::Int*) : Return
  fun get_port_usb_vid_pid = "sp_get_port_usb_vid_pid"(port : Port*, usb_vid : LibC::Int*, usb_pid : LibC::Int*) : Return
  fun get_port_usb_manufacturer = "sp_get_port_usb_manufacturer"(port : Port*) : LibC::Char*
  fun get_port_usb_product = "sp_get_port_usb_product"(port : Port*) : LibC::Char*
  fun get_port_usb_serial = "sp_get_port_usb_serial"(port : Port*) : LibC::Char*
  fun get_port_bluetooth_address = "sp_get_port_bluetooth_address"(port : Port*) : LibC::Char*
  fun get_port_handle = "sp_get_port_handle"(port : Port*, result_ptr : Void*) : Return
  fun new_config = "sp_new_config"(config_ptr : PortConfig**) : Return
  fun free_config = "sp_free_config"(config : PortConfig*) : Void
  fun get_config = "sp_get_config"(port : Port*, config : PortConfig*) : Return
  fun set_config = "sp_set_config"(port : Port*, config : PortConfig*) : Return
  fun set_baudrate = "sp_set_baudrate"(port : Port*, baudrate : Int32) : Return
  fun get_config_baudrate = "sp_get_config_baudrate"(config : PortConfig*, baudrate_ptr : Int32*) : Return
  fun set_config_baudrate = "sp_set_config_baudrate"(config : PortConfig*, baudrate : Int32) : Return
  fun set_bits = "sp_set_bits"(port : Port*, bits : Int32) : Return
  fun get_config_bits = "sp_get_config_bits"(config : PortConfig*, bits_ptr : Int32*) : Return
  fun set_config_bits = "sp_set_config_bits"(config : PortConfig*, bits : Int32) : Return
  fun set_parity = "sp_set_parity"(port : Port*, parity : Parity) : Return
  fun get_config_parity = "sp_get_config_parity"(config : PortConfig*, parity_ptr : Parity*) : Return
  fun set_config_parity = "sp_set_config_parity"(config : PortConfig*, parity : Parity) : Return
  fun set_stopbits = "sp_set_stopbits"(port : Port*, stopbits : Int32) : Return
  fun get_config_stopbits = "sp_get_config_stopbits"(config : PortConfig*, stopbits_ptr : Int32*) : Return
  fun set_config_stopbits = "sp_set_config_stopbits"(config : PortConfig*, stopbits : Int32) : Return
  fun set_rts = "sp_set_rts"(port : Port*, rts : RTS) : Return
  fun get_config_rts = "sp_get_config_rts"(config : PortConfig*, rts_ptr : RTS*) : Return
  fun set_config_rts = "sp_set_config_rts"(config : PortConfig*, rts : RTS) : Return
  fun set_cts = "sp_set_cts"(port : Port*, cts : CTS) : Return
  fun get_config_cts = "sp_get_config_cts"(config : PortConfig*, cts_ptr : CTS*) : Return
  fun set_config_cts = "sp_set_config_cts"(config : PortConfig*, cts : CTS) : Return
  fun set_dtr = "sp_set_dtr"(port : Port*, dtr : DTR) : Return
  fun get_config_dtr = "sp_get_config_dtr"(config : PortConfig*, dtr_ptr : DTR*) : Return
  fun set_config_dtr = "sp_set_config_dtr"(config : PortConfig*, dtr : DTR) : Return
  fun set_dsr = "sp_set_dsr"(port : Port*, dsr : DSR) : Return
  fun get_config_dsr = "sp_get_config_dsr"(config : PortConfig*, dsr_ptr : DSR*) : Return
  fun set_config_dsr = "sp_set_config_dsr"(config : PortConfig*, dsr : DSR) : Return
  fun set_xon_xoff = "sp_set_xon_xoff"(port : Port*, xon_xoff : XonXoff) : Return
  fun get_config_xon_xoff = "sp_get_config_xon_xoff"(config : PortConfig*, xon_xoff_ptr : XonXoff*) : Return
  fun set_config_xon_xoff = "sp_set_config_xon_xoff"(config : PortConfig*, xon_xoff : XonXoff) : Return
  fun set_config_flowcontrol = "sp_set_config_flowcontrol"(config : PortConfig*, flowcontrol : FlowControl) : Return
  fun set_flowcontrol = "sp_set_flowcontrol"(port : Port*, flowcontrol : FlowControl) : Return
  fun blocking_read = "sp_blocking_read"(port : Port*, buf : Void*, count : UInt32, timeout_ms : UInt32) : LibC::Int
  fun blocking_read_next = "sp_blocking_read_next"(port : Port*, buf : Void*, count : UInt32, timeout_ms : UInt32) : LibC::Int
  fun nonblocking_read = "sp_nonblocking_read"(port : Port*, buf : Void*, count : UInt32) : LibC::Int
  fun blocking_write = "sp_blocking_write"(port : Port*, buf : Void*, count : UInt32, timeout_ms : UInt32) : LibC::Int
  fun nonblocking_write = "sp_nonblocking_write"(port : Port*, buf : Void*, count : UInt32) : LibC::Int
  fun input_waiting = "sp_input_waiting"(port : Port*) : LibC::Int
  fun output_waiting = "sp_output_waiting"(port : Port*) : LibC::Int
  fun flush = "sp_flush"(port : Port*, buffers : Buffer) : Return
  fun drain = "sp_drain"(port : Port*) : Return
  fun new_event_set = "sp_new_event_set"(result_ptr : EventSet**) : Return
  fun add_port_events = "sp_add_port_events"(event_set : EventSet*, port : Port*, mask : Event) : Return
  fun wait = "sp_wait"(event_set : EventSet*, timeout_ms : UInt32) : Return
  fun free_event_set = "sp_free_event_set"(event_set : EventSet*) : Void
  fun get_signals = "sp_get_signals"(port : Port*, signal_mask : Signal*) : Return
  fun start_break = "sp_start_break"(port : Port*) : Return
  fun end_break = "sp_end_break"(port : Port*) : Return
  fun last_error_code = "sp_last_error_code" : Int32
  fun last_error_message = "sp_last_error_message" : LibC::Char*
  fun free_error_message = "sp_free_error_message"(message : LibC::Char*) : Void
  fun set_debug_handler = "sp_set_debug_handler"(handler : Void*) : Void
  fun default_debug_handler = "sp_default_debug_handler"(format : LibC::Char*, ...) : Void
  fun get_major_package_version = "sp_get_major_package_version" : Int32
  fun get_minor_package_version = "sp_get_minor_package_version" : Int32
  fun get_micro_package_version = "sp_get_micro_package_version" : Int32
  fun get_package_version_string = "sp_get_package_version_string" : LibC::Char*
  fun get_current_lib_version = "sp_get_current_lib_version" : Int32
  fun get_revision_lib_version = "sp_get_revision_lib_version" : Int32
  fun get_age_lib_version = "sp_get_age_lib_version" : Int32
  fun get_lib_version_string = "sp_get_lib_version_string" : LibC::Char*
end
