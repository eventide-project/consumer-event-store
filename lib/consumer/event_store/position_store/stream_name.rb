module Consumer
  module EventStore
    class PositionStore
      module StreamName
        def self.canonize(stream_name)
          types = MessageStore::EventStore::StreamName.get_type_list(stream_name)
          types = Array(types)

          return stream_name if types.include?('position')

          types << 'position'

          entity_name = MessageStore::EventStore::StreamName.get_entity_name(stream_name)
          stream_id = MessageStore::EventStore::StreamName.get_id(stream_name)

          MessageStore::StreamName.stream_name(entity_name, stream_id, types: types)
        end
      end
    end
  end
end
