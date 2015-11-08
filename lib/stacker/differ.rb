require 'diffy'
require 'json'

module Stacker
  module Differ

    module_function

    def diff one, two, *args
      Stacker.logger.info "Starting diff"
      down = args.include? :down

      Stacker.logger.info "Starting Diffy"
      diff = Diffy::Diff.new(
        (down ? one : two) + "\n",
        (down ? two : one) + "\n",
        context: 3,
        include_diff_info: true
      ).to_s(*args.select { |arg| arg == :color })

      Stacker.logger.info "Starting strip"
      diff.gsub(/^(\x1B.+)?(\-{3}|\+{3}).+\n/, '').strip
    end

    def json_diff one, two, *args
      diff JSON.pretty_generate(one), JSON.pretty_generate(two), *args
    end

    def yaml_diff one, two, *args
      diff YAML.dump(one), YAML.dump(two), *args
    end

  end
end
