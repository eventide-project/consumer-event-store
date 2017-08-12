require_relative './interactive_init'

category = ENV['CATEGORY'] || 'testEventStoreConsumer'

if identifier = ENV['IDENTIFIER']
  Controls::Consumer::Incrementing.class_exec do
    identifier(identifier)
  end
end

Actor::Supervisor.start do
  Controls::Consumer::Incrementing.start("$ce-#{category}", position_update_interval: 5)
end
