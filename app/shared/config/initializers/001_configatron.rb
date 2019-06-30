require 'configatron'

root = Shared::Engine.root.join('config', 'configatron')
Configatron::Integrations::Rails.init(root)
