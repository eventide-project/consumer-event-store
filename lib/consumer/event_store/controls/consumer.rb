module Consumer
  module EventStore
    module Controls
      module Consumer
        class Example
          include ::Consumer::EventStore

          handle Controls::Handle::Example
        end
      end
    end
  end
end
