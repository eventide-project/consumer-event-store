module Consumer
  module EventStore
    class PositionStore
      include Consumer::PositionStore

      initializer :stream_name

      dependency :get_last, EventSource::EventStore::HTTP::Get::Last
      dependency :session, EventSource::EventStore::HTTP::Session
      dependency :write, ::Messaging::EventStore::Write

      def self.build(stream_name, session: nil)
        position_stream_name = StreamName.canonize stream_name

        instance = new position_stream_name
        EventSource::EventStore::HTTP::Session.configure instance, session: session
        instance.configure
        instance
      end

      def configure
        EventSource::EventStore::HTTP::Get::Last.configure self, session: session
        Messaging::EventStore::Write.configure self, session: session
      end

      def get
        event_data = get_last.(stream_name)

        return nil if event_data.nil?

        message = Messaging::Message::Import.(event_data, PositionUpdated)
        message.position
      end

      def put(position)
        message = PositionUpdated.build :position => position

        write.(message, stream_name)

        message
      end

      class PositionUpdated
        include Messaging::Message

        attribute :position, Integer
      end

      module StreamName
        def self.canonize(stream_name)
          types = EventSource::StreamName.get_type_list stream_name
          types = Array(types)

          return stream_name if types.include? 'position'

          types << 'position'

          entity_name = EventSource::StreamName.get_entity_name stream_name
          id = EventSource::StreamName.get_id stream_name

          EventSource::StreamName.stream_name entity_name, id, types: types
        end
      end
    end
  end
end
