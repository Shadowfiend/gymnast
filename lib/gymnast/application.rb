module Gymnast
  class Application
    attr_reader :app_file

    def initialize(app_file, flex_project)
      @app_file = app_file
      @flex_project = flex_project
    end

    def compiler_line
      @flex_project.compiler_line
    end
  end
end
