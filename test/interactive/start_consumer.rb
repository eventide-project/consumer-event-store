require_relative './interactive_init'

category = ENV['CATEGORY'] || 'testEventStoreConsumer'

Actor::Supervisor.start do
  Controls::Consumer::LogsEvents.start category
end
