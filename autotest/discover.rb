$LOAD_PATH << File.join(File.dirname(__FILE__), 'rspec')

Autotest.add_discovery do
  "rspec"
end

Autotest.add_hook :initialize do |at|
  at.add_exception(/spec_helper/)
end

