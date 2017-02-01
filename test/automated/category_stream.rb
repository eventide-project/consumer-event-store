require_relative './automated_init'

context "Category Stream" do
  stream_name = Controls::Category.example

  consumer = Controls::Consumer.example stream_name: "$ce-#{stream_name}"

  context "Position store" do
    position_store = consumer.position_store

    context "Stream name" do
      position_store_stream_name = position_store.stream_name

      test "Does not include $ce- prefix" do
        comment stream_name
        comment position_store_stream_name

        assert position_store_stream_name == "#{stream_name}:position"
      end
    end
  end
end
