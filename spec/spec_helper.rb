$LOAD_PATH << File.join(File.dirname(__FILE__), '../lib')
require 'spokr'

RSpec.configure do |config|
  config.before :each do
    `mysql -uroot spoke_development -e 'truncate posts;'`
  end
end
