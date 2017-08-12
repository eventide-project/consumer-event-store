module Consumer
  module EventStore
    class PositionStore
      module StreamName
        def self.get(stream_name, consumer_identifier: nil)
          match_data = MessageStore::EventStore::StreamName.parse(stream_name)

          types = match_data[:type_list]
          types = Array(types)

          return stream_name if types.include?('position')

          types << 'position'

          entity_name = match_data[:entity]

          stream_id = match_data[:stream_id]

          unless consumer_identifier.nil?
            if stream_id.nil?
              stream_id = consumer_identifier
            else
              stream_id = "#{stream_id}-#{consumer_identifier}"
            end
          end

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
