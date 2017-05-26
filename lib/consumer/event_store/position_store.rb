module Consumer
  module EventStore
    class PositionStore
      include Consumer::PositionStore

      initializer :stream_name

      dependency :get_last, MessageStore::EventStore::Get::Last
      dependency :session, MessageStore::EventStore::Session
      dependency :write, ::Messaging::EventStore::Write

      def self.build(stream_name, session: nil)
        position_stream_name = StreamName.get(stream_name)

        instance = new position_stream_name
        MessageStore::EventStore::Session.configure instance, session: session
        instance.configure
        instance
      end

      def configure
        MessageStore::EventStore::Get::Last.configure self, session: session
        Messaging::EventStore::Write.configure self, session: session
      end

      def get
        message_data = get_last.(stream_name)

        return nil if message_data.nil?

        message = Messaging::Message::Import.(message_data, Updated)
        message.position
      end

      def put(position)
        message = Updated.new
        message.position = position

        write.(message, stream_name)
      end
    end
  end
end
