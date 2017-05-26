require_relative './interactive_init'

category = ENV['CATEGORY'] || 'testEventStoreConsumer'

write = MessageStore::EventStore::Write.build

period = (ENV['PERIOD'] || 300).to_i

logger = Log.get __FILE__

(1..4).to_a.cycle do |stream_id|
  stream_name = MessageStore::StreamName.stream_name(category, stream_id)

  message_data = Controls::MessageData.example

  position = write.(message_data, stream_name)

  logger.info "Wrote message (Stream Name: #{stream_name}, Position: #{position})"

  sleep Rational(period, 1000)
end
