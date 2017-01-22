require_relative '../automated_init'

context "Stream" do
  context "Category" do
    category = Controls::Category.example

    consumer = Controls::Consumer::Example.build category

    context "Subscription dependency" do
      subscription = consumer.subscription

      test "Stream name is prefixed as EventStore category" do
        assert subscription.stream_name == "$ce-#{category}"
      end
    end
  end
end
