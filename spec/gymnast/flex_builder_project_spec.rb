require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'gymnast/flex_builder_project'
include Gymnast

describe FlexBuilderProject do
  it 'should create an Application for each valid Flex subdirectory' do
    Dir.stub!(:entries).with('location').
                        and_return(['.', '..', 'dir', 'otherdir', 'dir3'])
    Dir.stub!(:entries).with('dir').
                        and_return(['.', '..', '.actionScriptProperties'])
    Dir.stub!(:entries).with('otherdir').
                        and_return(['.', '..', '.actionScriptProperties'])
    Dir.stub!(:entries).with('dir3').and_return(['.', '..'])

    FlexProject.should_receive(:new).with('dir')
    FlexProject.should_receive(:new).with('otherdir')
    FlexProject.should_not_receive(:new).with('dir3')

    FlexBuilderProject.from_directory('location')
  end
end
