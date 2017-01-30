require 'consumer'
require 'messaging/event_store'

require 'consumer/event_store/event_store'
require 'consumer/event_store/subscription'
require 'consumer/event_store/position_store'

Consumer::EventStore.activate
