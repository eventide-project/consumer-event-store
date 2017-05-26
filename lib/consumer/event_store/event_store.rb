module Consumer
  module EventStore
    def self.included(cls)
      cls.class_exec do
        include Consumer
      end
    end

    def configure(session: nil, batch_size: nil, position_store: nil)
      cycle_timeout = cycle_timeout_milliseconds || Consumer::Subscription::Defaults.cycle_timeout_milliseconds

      long_poll_duration = Rational(cycle_timeout, 1000).ceil

      unless session.nil?
        get_session = CopySession.(session)
      end

      MessageStore::EventStore::Get.configure(
        self,
        batch_size: batch_size,
        long_poll_duration: long_poll_duration,
        session: get_session
      )

      position_store_stream_name = stream_name.sub %r{\A\$ce-}, ''

      PositionStore.configure(
        self,
        position_store_stream_name,
        session: session,
        position_store: position_store
      )
    end
  end
end
