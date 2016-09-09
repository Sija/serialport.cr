module SerialPort
  class Port
    module Enumeration
      macro included
        extend Enumeration::ClassMethods
        include Enumeration::InstanceMethods
      end

      module ClassMethods
        def list : Array(self)
          SerialPort.check! LibSerialPort.list_ports(out list)
          ports = [] of self
          begin
            i = 0
            while port = list[i]
              ports << new(port)
              i += 1
            end
          end
          LibSerialPort.free_port_list(list)
          ports
        end
      end

      module InstanceMethods
        def initialize(ptr : LibSerialPort::Port*)
          copy(ptr)
        end

        def initialize(name : String)
          get_by_name(name)
        end

        def finalize
          free
        end

        private def get_by_name(name)
          SerialPort.check! LibSerialPort.get_port_by_name(name, out ptr)
          self.ptr = ptr
        end

        private def copy(ptr)
          SerialPort.check! LibSerialPort.copy_port(ptr, out copy_ptr)
          self.ptr = copy_ptr
        end

        private def free
          LibSerialPort.free_port(self)
          self.ptr = nil
        end
      end
    end
  end
end
