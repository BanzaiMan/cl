require 'cl/help/table'
require 'cl/help/usage'

class Cl
  class Help
    class Cmds < Struct.new(:cmds)
      HEAD = %(Type "#{$0.split('/').last} help COMMAND [SUBCOMMAND]" for more details:\n)

      def format
        [HEAD, Table.new(list).format].join("\n")
      end

      def list
        cmds.any? ? cmds.map { |cmd| format_cmd(cmd) } : [['[no commands]']]
      end

      def format_cmd(cmd)
        ["#{Usage.new(cmd).format}", cmd.summary]
      end
    end
  end
end