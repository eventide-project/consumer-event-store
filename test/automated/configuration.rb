require_relative './automated_init'

context "Configuration" do
  batch_size = 11
  cycle_timeout_milliseconds = 1111

  stream_name = Controls::StreamName.example

  session = EventSource::EventStore::HTTP::Session.build

  consumer = Controls::Consumer::Example.build(
    stream_name,
    batch_size: batch_size,
    cycle_timeout_milliseconds: cycle_timeout_milliseconds,
    session: session
  )

  context "Get" do
    get = consumer.get

    context "Batch size" do
      test "Is set" do
        assert get.batch_size == batch_size
      end
    end

    context "Session" do
      test "Is set" do
        assert get do
          session? session
        end
      end
    end

    context "Long poll duration" do
      test "Is cycle timeout rounded up to nearest second" do
        assert get.long_poll_duration == 2
      end
    end
  end

  context "Position store" do
    position_store = consumer.position_store

    test "Is configured" do
      assert position_store.instance_of?(Consumer::EventStore::PositionStore)
    end

    context "Session" do
      test "Is set" do
        assert position_store.session.equal?(session)
      end
    end

    context "Stream" do
      control_stream = EventSource::Stream.build stream_name
      stream = EventSource::Stream.build position_store.stream_name

      test "Category" do
        assert stream.category == "#{control_stream.category}:position"
      end

      test "ID" do
        assert stream.id == control_stream.id
      end
    end
  end
end
