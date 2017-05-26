require_relative './interactive_init'

category = ENV['CATEGORY'] || 'testEventStoreConsumer'

Actor::Supervisor.start do
  Controls::Consumer::Incrementing.start("$ce-#{category}", position_update_interval: 5)
end
