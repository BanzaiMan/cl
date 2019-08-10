#!/usr/bin/env ruby
$: << File.expand_path('lib')

<%= run sq(<<-'rb')
  class Add < Cl::Cmd
    opt '--active BOOL', type: :boolean
    opt '--retries INT', type: :integer
    opt '--sleep FLOAT', type: :float

    def run
      p active: active.class, retries: retries.class, sleep: sleep.class
    end
  end
  rb
-%>

<%= run "Cl.new('owners').run(%w(add --active yes --retries 1 --sleep 0.1))" %>

<%= out "{:active=>TrueClass, :retries=>#{RUBY_VERSION < '2.4' ? 'Fixnum' : 'Integer'}, :sleep=>Float}" %>