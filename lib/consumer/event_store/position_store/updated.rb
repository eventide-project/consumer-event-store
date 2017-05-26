module Consumer
  module EventStore
    class PositionStore
      class Updated
        include Messaging::Message

        attribute :position, Integer
      end
    end
  end
end
