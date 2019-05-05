require 'configatron'

root = Base::Engine.root.join('config', 'configatron')
Configatron::Integrations::Rails.init(root)
