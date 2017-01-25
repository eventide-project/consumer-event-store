module Consumer
  module EventStore
    module Controls
      module Consumer
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
