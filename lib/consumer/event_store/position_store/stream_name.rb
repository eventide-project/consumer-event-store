module Consumer
  module EventStore
    class PositionStore
      module StreamName
        def self.get(stream_name)
          match_data = MessageStore::EventStore::StreamName.parse(stream_name)

          types = match_data[:type_list]
          types = Array(types)

          return stream_name if types.include?('position')

          types << 'position'

          entity_name = match_data[:entity]

          stream_id = match_data[:stream_id]

          MessageStore::StreamName.stream_name(
            entity_name,
            stream_id,
            types: types
          )
        end
      end
    end
  end
end
