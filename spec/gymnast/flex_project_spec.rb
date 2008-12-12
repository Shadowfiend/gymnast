require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'gymnast/flex_project'
include Gymnast

describe FlexProject, 'when creating from the test file' do
  before(:all) do
    @as_prop_data = nil
    File.open File.join(TEST_DATA, 'testASProperties') do |f|
      @as_prop_data = f.read
    end
  end

  before(:each) do
    @as_props = StringIO.new(@as_prop_data)

    File.stub!(:open).with(/\.actionScriptProperties$/).and_yield(@as_props)
    Application.stub!(:new).and_return { mock(Application) }
  end

  it 'should read the actionScriptProperties file in the directory' do
    File.should_receive(:open).with(/\.actionScriptProperties$/).
                               and_yield(@as_props)

    FlexProject.from_directory 'place'
  end

  it 'should read the main application as the one named FiveCylons.mxml' do
    app = mock(Application)
    Application.stub!(:new).with('FiveCylons.mxml').and_return(app)

    @it = FlexProject.from_directory 'place'

    @it.main_app.should == app
  end

  describe 'when extracting applications' do
    it 'should extract one application' do
      @it = FlexProject.from_directory 'place'

      @it.should have(1).applications
    end

    it 'should pass the application the path to its mxml file' do
      app = mock(Application)
      Application.should_receive(:new).with('FiveCylons.mxml').and_return(app)

      @it = FlexProject.from_directory 'place'
    end
  end
end
