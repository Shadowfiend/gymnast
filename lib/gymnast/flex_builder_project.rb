require 'gymnast/flex_project'

module Gymnast
  # The FlexBuilderProject class represents the information extracted from a
  # single FlexBuilder project. This typically includes one or more Flex
  # projects, with their associated applications, modules, etc.
  #
  # Note that a FlexBuilder project can span multiple Flex projects. FlexBuilder
  # projects roughly map to workspaces, in the sense that this class searches
  # recursively for sub-directories that have Flex projects.
  #
  # See the FlexProject and Application classes for more details on the
  # available information.
  class FlexBuilderProject
    class <<self
      alias_method :from_directory, :new
    end

    attr_accessor :projects

    def initialize(dirname = nil)
      project_dirs = Dir.entries(dirname).select do |dir|
        next if dir =~ /\.\.?/ # skip current and parent dirs

        Dir.entries(dir).detect { |dir| dir == '.actionScriptProperties' }
      end

      self.projects = project_dirs.collect { |dir| FlexProject.new dir }
    end
  end
end
