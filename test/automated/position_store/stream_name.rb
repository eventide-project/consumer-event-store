require_relative '../automated_init'

context "Position Store" do
  context "Stream Name" do
    context "Does not already include position type" do
      context "Stream" do
        stream_name = 'someStream-111'

        position_stream_name = Consumer::EventStore::PositionStore::StreamName.get(stream_name)

        test "Includes position type" do
          assert position_stream_name == 'someStream:position-111'
        end
      end

      context "Category" do
        stream_name = 'someStream'

        position_stream_name = Consumer::EventStore::PositionStore::StreamName.get(stream_name)

        test "Includes position type" do
          assert position_stream_name == 'someStream:position'
        end
      end

      context "Category (with projection prefix" do
        stream_name = '$ce-someStream'

        position_stream_name = Consumer::EventStore::PositionStore::StreamName.get(stream_name)

        test "Includes position type but not prefix" do
          assert position_stream_name == 'someStream:position'
        end
      end
    end

    context "Already includes position type" do
      context "Stream" do
        stream_name = 'someStream:position-111'

        position_stream_name = Consumer::EventStore::PositionStore::StreamName.get(stream_name)

        test "Includes position type just once" do
          assert position_stream_name == 'someStream:position-111'
        end
      end

      context "Category" do
        stream_name = 'someStream:position'

        position_stream_name = Consumer::EventStore::PositionStore::StreamName.get(stream_name)

        test "Includes position type just once" do
          assert position_stream_name == 'someStream:position'
        end
      end
    end

    context "Includes other type" do
      context "Stream" do
        stream_name = 'someStream:someType-111'

        position_stream_name = Consumer::EventStore::PositionStore::StreamName.get(stream_name)

        test "Preserves other type" do
          assert position_stream_name == 'someStream:someType+position-111'
        end
      end

      context "Category" do
        stream_name = 'someStream:someType'

        position_stream_name = Consumer::EventStore::PositionStore::StreamName.get(stream_name)

        test "Preserves other type" do
          assert position_stream_name == 'someStream:someType+position'
        end
      end
    end
  end
end
