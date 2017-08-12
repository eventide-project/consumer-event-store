require_relative '../automated_init'

context "Consumer Stream Position Store, Put Operation" do
  stream_name = Controls::StreamName.example

  position = 11

  position_store = Consumer::EventStore::PositionStore.build(stream_name)
  position_store.put(position)

  test "Position is written to consumer stream" do
    consumer_stream_name = Consumer::EventStore::PositionStore::StreamName.get(stream_name)

    message_data = MessageStore::EventStore::Get::Last.(consumer_stream_name)

    position = message_data.data[:position]

    assert(position == 11)
  end
end
