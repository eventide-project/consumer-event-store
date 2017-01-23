# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-consumer-event_store'
  s.version = '0.0.0.3'
  s.summary = 'Category and stream consumer for EventStore'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/consumer-event-store'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-consumer'
  s.add_runtime_dependency 'evt-messaging-event_store'

  s.add_development_dependency 'test_bench'
end
