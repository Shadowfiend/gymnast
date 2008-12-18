require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'gymnast/application'
require 'gymnast/flex_project'

include Gymnast

describe Application do
  before(:each) do
    @fp_mock = mock(FlexProject)

    @it = Application.new 'FiveCylons.mxml', @fp_mock
  end

  it 'should provide access to its mxml file' do
    @it.app_file.should == 'FiveCylons.mxml'
  end

  it 'should talk to its Flex project when providing its compiler line' do
    pending 'should be clearer'

    @fp_mock.should_receive(:compiler_line)

    @it.compiler_line
  end
end
