require 'rspec'
require 'caviidae/rspec/helpers'

RSpec.configure do |config|
  config.after(:each) { Caviidae.db.cleanup }
  config.before(:all) { Caviidae.materialize }
  config.include Caviidae::RSpec::Helpers
end
