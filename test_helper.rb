require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(detailed_skip: false)]

begin
  require "pretty_diffs"

  module Minitest
    class Test
      include PrettyDiffs
    end
  end
rescue LoadError
end

require "debug"
