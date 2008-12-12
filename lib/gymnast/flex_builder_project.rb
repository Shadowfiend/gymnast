require 'gymnast/flex_project'

module Gymnast
  # The FlexBuilderProject class represents the information extracted from a
  # single FlexBuilder project. This includes any applications in it, etc.
  # 
  # Note that a FlexBuilder project can span multiple Flex projects. FlexBuilder
  # projects roughly map to workspaces, in the sense that this class searches
  # recursively for sub-directories that have Flex projects.
  #
  # See the Application class for more details on the available information.
  class FlexBuilderProject
    class <<self
      alias_method :from_directory, :new
    end

    attr_reader :projects

    def initialize(dirname = nil)
      project_dirs = Dir.entries(dirname).select do |dir|
        next if dir =~ /\.\.?/ # skip current and parent dirs

        p dir
        Dir.entries(dir).detect { |dir| dir == '.actionScriptProperties' }
      end

      project_dirs.each { |dir| FlexProject.new dir }
    end
  end
end
