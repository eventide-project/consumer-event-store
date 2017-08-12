require_relative '../automated_init'

context "Consumer Stream Position Store, Get Operation" do
  context "Previous position is not recorded" do
    stream_name = Controls::StreamName.example

    position_store = Consumer::EventStore::PositionStore.build(stream_name)
    position = position_store.get

    test "No stream is returned" do
      assert(position == nil)
    end
  end

  context "Previous position is recorded" do
    stream_name = Controls::PositionStream::Write.(position: 11)

    context do
      position_store = Consumer::EventStore::PositionStore.build(stream_name)
      position = position_store.get

      test "Recorded position is returned" do
        assert(position == 11)
      end
    end

    context "Consumer stream has been updated more than once" do
      Controls::PositionStream::Write.(stream_name, position: 22)

      position_store = Consumer::EventStore::PositionStore.build(stream_name)
      position = position_store.get

      test "Position of most recent update is returned" do
        assert(position == 22)
      end
    end
  end
end
