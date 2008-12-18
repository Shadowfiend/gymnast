require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'gymnast/application'
include Gymnast

describe Application do
  before(:each) do
    @application = Application.new 'FiveCylons.mxml', mock(FlexProject)
  end
end
