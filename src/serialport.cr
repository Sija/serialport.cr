require "logger"
require "colorize"

require "./serialport/lib/*"
require "./serialport/*"

module SerialPort
  @@logger : Logger?

  def self.logger : Logger
    @@logger ||= Logger.new(STDERR).tap do |logger|
      severity_colors = {
        "UNKNOWN" => :dark_gray,
        "ERROR"   => :light_red,
        "WARN"    => :red,
        "INFO"    => :blue,
        "DEBUG"   => :green,
        "FATAL"   => :cyan,
      }
      logger.formatter = Logger::Formatter.new do |severity, datetime, progname, message, io|
        io << severity.rjust(5).colorize(severity_colors[severity]? || :green)
        io << " [" << progname.colorize(:cyan) << "]" unless progname.empty?
        io << " -- " << message
      end
      logger.level = Logger::DEBUG if debug?
    end
  end

  macro log(*args, severity = Logger::Severity::DEBUG, backtrace_offset = 0)
    if ::SerialPort.debug? && {{!args.empty?}}
      %DEBUG_CALLER_PATTERN = /caller:Array\(String\)/i
      %caller_list = caller.dup
      if %caller_list.any? &.match(%DEBUG_CALLER_PATTERN)
        while !%caller_list.empty? && %caller_list.first? !~ %DEBUG_CALLER_PATTERN
          %caller_list.shift?
        end
        %caller_list.shift?
      end
      {% if backtrace_offset > 0 %}
        %caller_list.shift {{backtrace_offset}}
      {% end %}
      %str = String.build do |str|
        if %caller = %caller_list.first?
          str << %caller.colorize(:dark_gray)
          str << " -- "
        end
        str << "{{args}} = ".colorize(:light_gray) << {{args}}
      end
      ::SerialPort.logger.log {{severity.id}}, %str, "serialport.cr"
    end
  end

  def self.debug?
    ENV["DEBUG"]? == "1"
  end

  def self.package_version
    String.new LibSerialPort.get_package_version_string
  end

  def self.check?(rc : LibSerialPort::Return) : Bool
    rc == LibSerialPort::Return::OK
  end

  def self.check!(rc : LibSerialPort::Return) : LibSerialPort::Return
    log(rc, backtrace_offset: 1)
    return rc if check?(rc)

    code = LibSerialPort.last_error_code
    message_ptr = LibSerialPort.last_error_message
    message = String.new message_ptr

    LibSerialPort.free_error_message message_ptr

    raise Error.new(message, code.to_i, rc)
  end
end
