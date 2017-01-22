module Consumer
  module EventStore
    def self.included(cls)
      cls.class_exec do
        include Consumer
      end
    end

    def configure(session: nil, batch_size: nil)
      EventSource::EventStore::HTTP::Get.configure(
        self,
        batch_size: batch_size,
        session: session
      )

      subscription.extend Subscription::StreamName
    end

    module Subscription
      module StreamName
        def stream_name
          EventSource::EventStore::HTTP::StreamName.canonize stream
        end
      end
    end
  end
end
