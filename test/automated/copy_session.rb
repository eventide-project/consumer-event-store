require_relative './automated_init'

context "Copy Session" do
  original = EventStore::HTTP::Session.build
  original.establish_connection

  copy = Consumer::EventStore::CopySession.(original)

  context "Specialization" do
    test "Is same" do
      assert copy.instance_of?(original.class)
    end
  end

  context "Connect dependency" do
    connect = copy.connect

    test "Is same" do
      assert connect.equal?(original.connect)
    end
  end

  context "Retry dependency" do
    connect = copy.connect

    test "Is same" do
      assert connect.equal?(original.connect)
    end
  end

  context "HTTP connection" do
    net_http = copy.net_http

    test "Is reset" do
      refute net_http.equal?(original.net_http)
    end
  end
end
