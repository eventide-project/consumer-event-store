module Consumer
  module EventStore
    def self.activate
      Subscription.activate
    end

    def self.included(cls)
      cls.class_exec do
        include Consumer
      end
    end

    def configure(session: nil, batch_size: nil, position_store: nil)
      cycle_timeout = cycle_timeout_milliseconds || Consumer::Subscription::Defaults.cycle_timeout_milliseconds

      long_poll_duration = Rational(cycle_timeout, 1000).ceil

      unless session.nil?
        get_session = ::EventStore::HTTP::Session.copy session
      end

      EventSource::EventStore::HTTP::Get.configure(
        self,
        batch_size: batch_size,
        long_poll_duration: long_poll_duration,
        session: get_session
      )

      PositionStore.configure(
        self,
        stream,
        session: session,
        position_store: position_store
      )
    end
  end
end
