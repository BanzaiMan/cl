require 'optparse'

class Cl
  class Parser < OptionParser
    attr_reader :opts

    def initialize(opts, args)
      @opts = {}

      super do
        opts.each do |opt|
          on(*dasherize(*opt.strs)) do |value|
            set(opt, value)
          end

          opt.aliases.each do |name|
            on(*dasherize(aliased(opt, name))) do |value|
              @opts[name] = set(opt, value)
            end
          end
        end
      end

      args.replace(dasherize(*args))
      parse!(args)
    end

    def aliased(opt, name)
      str = opt.strs.detect { |str| str.start_with?('--') } || raise
      str = str.sub(opt.name.to_s, name.to_s)
      str.sub(opt.name.to_s.gsub('_', '-'), name.to_s)
    end

    # should consider negative arities (e.g. |one, *two|)
    def set(opt, value)
      args = [opts, opt.type, opt.name, value]
      args = args[-opt.block.arity, opt.block.arity]
      instance_exec(*args, &opt.block)
    end

    DASHERIZE = /^--([^= ])*/

    def dasherize(*strs)
      strs.map { |str| str.gsub(DASHERIZE) { |opt| opt.gsub('_', '-') } }
    end
  end
end
