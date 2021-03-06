<%= run sq(<<-'rb')
  require 'cl'

  # e.g. lib/owners/add.rb
  module Owners
    class Add < Cl::Cmd
      summary 'Add one or more owners to an existing owner group'

      description <<~str
        Use this command to add one or more owners to an existing
        owner group.

        [...]
      str

      args :owner

      opt '-t', '--to TO', 'An existing owner group'

      def run
        # implement adding the owner as given in `owner` (as well as `args`)
        # to the group given in `to` (as well as `opts[:to]`).
        p owner: owner, to: to, to?: to?, args: args, opts: opts
      end
    end
  end
  rb
-%>

# Running this, e.g. using `bin/owners add one,two --to group` will instantiate the
# class `Owners::Add`, and call the method `run` on it.

<%= run sq(<<-'rb')
  # e.g. bin/owners
  #
  # args normally would be ARGV
  args = %w(add one --to group)

  Cl.new('owners').run(args)
  rb
-%>

<%= out '{:owner=>"one", :to=>"group", :to?=>true, :args=>["one"], :opts=>{:to=>"group"}}' %>

<%= run "Cl.new('owners').run(%w(add --help))" %>

<%= out sq(<<-'str')
  Usage: owners add [owner] [options]

  Summary:

    Add one or more owners to an existing owner group

  Description:

    Use this command to add one or more owners to an existing
    owner group.

    [...]

  Arguments:

    owner           type: string

  Options:

    -t --to TO      An existing owner group (type: string)
       --help       Get help on this command
  str
%>
