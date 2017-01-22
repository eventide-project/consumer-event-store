module Consumer
  module EventStore
    def self.included(cls)
      cls.class_exec do
        include Consumer
      end
    end
  end
end
