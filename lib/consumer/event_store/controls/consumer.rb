module Consumer
  module EventStore
    module Controls
      module Consumer
        def self.example(stream_name: nil)
          stream_name ||= StreamName.example

          Example.build stream_name
        end

        class Example
          include ::Consumer::EventStore

          handle Controls::Handle::Example
        end

        class Incrementing < ::Consumer::Controls::Consumer::Incrementing
          include ::Consumer::EventStore
        end
      end
    end
  end
end
