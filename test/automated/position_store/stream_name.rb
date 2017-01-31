require_relative '../automated_init'

context "Position Store" do
  context "Stream Name" do
    context "Stream" do
      id = '111'
      stream_name = Controls::StreamName.example id: id, randomize_category: false

      position_stream_name = Consumer::EventStore::PositionStore::StreamName.canonize stream_name

      test "Includes position subtype" do
        control_stream_name = Controls::StreamName.example id: id, type: 'position', randomize_category: false

        comment position_stream_name
        comment control_stream_name
        assert position_stream_name == control_stream_name
      end
    end

    context "Category" do
      category = Controls::Category.example randomize_category: false

      position_stream_name = Consumer::EventStore::PositionStore::StreamName.canonize category

      test "Includes position subtype" do
        assert position_stream_name == "#{category}:position"
      end
    end
  end
end
