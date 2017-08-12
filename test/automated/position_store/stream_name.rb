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
          assert(position_stream_name == 'someStream:someType+position')
        end
      end
    end

    context "Consumer identifier given" do
      context "Category" do
        stream_name = 'someCategory'
        identifier = 'someIdentifier'

        position_stream_name = Consumer::EventStore::PositionStore::StreamName.get(stream_name, consumer_identifier: identifier)

        test "Appends identifier" do
          assert(position_stream_name == 'someCategory:position-someIdentifier')
        end
      end

      context "Stream" do
        stream_name = 'someStream-1'
        identifier = 'someIdentifier'

        position_stream_name = Consumer::EventStore::PositionStore::StreamName.get(stream_name, consumer_identifier: identifier)

        test "Appends identifier" do
          assert(position_stream_name == 'someStream:position-1-someIdentifier')
        end
      end
    end

    context "Stream name contains other types" do
      other_type = 'someType'

      stream_name = Controls::StreamName.example(id: stream_id, randomize_category: false, type: other_type)

      position_store_stream_name = Consumer::Postgres::PositionStore::StreamName.get(stream_name)

      test do
        control_stream_name = Controls::StreamName::Position.example(
          id: stream_id,
          randomize_category: false,
          types: [other_type]
        )

        assert(position_store_stream_name == control_stream_name)
      end
    end
  end
end
