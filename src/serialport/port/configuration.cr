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
    end
  end
end
