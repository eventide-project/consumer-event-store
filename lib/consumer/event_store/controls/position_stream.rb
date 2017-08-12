module Consumer
  module EventStore
    module Controls
      module PositionStream
        module Write
          def self.call(stream_name=nil, position: nil)
            stream_name ||= StreamName.example(type: 'position')
            position ||= 0

            message = PositionStore::Updated.new
            message.position = position

            Messaging::EventStore::Write.(message, stream_name)

            return stream_name
          end
        end
      end
    end
  end
end
