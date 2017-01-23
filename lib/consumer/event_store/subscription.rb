module Consumer
  module EventStore
    module Subscription
      def self.activate
        Consumer::Subscription.class_exec do
          prepend StreamName
        end
      end

      module StreamName
        def stream_name
          EventSource::EventStore::HTTP::StreamName.canonize stream
        end
      end
    end
  end
end
