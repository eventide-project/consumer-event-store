module Consumer
  module EventStore
    class PositionStore
      module Messages
        class PositionUpdated
          include Messaging::Message

          attribute :position, Integer
        end
      end
    end
  end
end
