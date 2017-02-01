module Consumer
  module EventStore
    module CopySession
      def self.call(session)
        copy = session.dup
        copy.reconnect
        copy
      end
    end
  end
end
