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

    attr_reader :applications, :main_app, :compiler_args

    def initialize(dir)
      @applications = []
      @compiler_args = {}

      File.open File.join(dir, '.actionScriptProperties') do |f|
        config = Hpricot.XML(f.read)
        root = config.at('/actionScriptProperties')

        main_app_path = root[:mainApplicationPath]
        (config/:application).each do |el|
          path = el[:path]

          @applications << Application.new(path, self)
          @main_app = @applications.last if path == main_app_path
        end

        compiler = root.at(:compiler)
        @compiler_args.merge! parse_args(compiler[:additionalCompilerArguments])
      end
    end

    private
      # Parses command-line arguments from a string in command-line form.
      # Returns a hash of arguments.
      #
      # For example, given:
      #  -locale en_US
      # Returns:
      #  { :locale => 'en_US' }
      def parse_args(str)
        args = {}

        str.scan(/-(\w+) (\w+)\s*/) do |line|
          args[line.first.to_sym] = line.last
        end

        args
      end
  end
end
