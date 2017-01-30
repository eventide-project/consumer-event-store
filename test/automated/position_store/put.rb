require_relative '../automated_init'

context "Consumer Stream Position Store, Put Operation" do
  stream_name = Controls::StreamName.example

  position = 11

  position_store = Consumer::EventStore::PositionStore.build stream_name
  position_store.put position

  test "Position is written to consumer stream" do
    consumer_stream_name = Consumer::EventStore::PositionStore::StreamName.canonize stream_name

    event_data = EventSource::EventStore::HTTP::Get::Last.(consumer_stream_name)

    position = event_data.data[:position]

    assert position == 11
  end
end
