module Consumer
  module EventStore
    module Controls
      module Consumer
        class Example
          include ::Consumer::EventStore

          handle Controls::Handle::Example
        end

        class LogsEvents < ::Consumer::Controls::Consumer::LogsEvents
          include ::Consumer::EventStore
        end
      end
    end
  end
end
