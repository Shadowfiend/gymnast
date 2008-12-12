require 'hpricot'
require 'gymnast/application'

module Gymnast
  # The FlexProject class represents a single Flex project. A Flex project
  # typically has one or more applications under it, zero or more modules, and
  # one `main' application.
  #
  # This class has a list of applications (via the +applications+ attribute), as
  # well as information on the source and output folders for the project and the
  # project root directory. It also carries a link back to its parent
  # FlexBuilderProject used to resolve certain paths.
  class FlexProject
    class <<self
      alias_method :from_directory, :new
    end

    attr_reader :applications
    attr_reader :main_app

    def initialize(dir)
      @applications = []

      File.open File.join(dir, '.actionScriptProperties') do |f|
        config = Hpricot(f.read)
        root = config.at('/actionscriptproperties')

        main_app_path = root[:mainapplicationpath]
        (config/:application).each do |el|
          path = el[:path]

          @applications << Application.new(path)
          @main_app = @applications.last if path == main_app_path
        end
      end
    end
  end
end
