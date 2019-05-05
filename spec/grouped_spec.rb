describe Cl, 'grouped' do
  let!(:a) do
    Class.new(Cl::Cmd) do
      register 'grouped:a'
      opt('-z') { opts[:z] = true }
      def run; [args, opts] end
    end
  end

  let!(:b) do
    Class.new(Cl::Cmd) do
      register 'grouped:b'
      opt('-a') { opts[:a] = true }
      opt('-b') { opts[:b] = true }
      opt('-c') { opts[:c] = true }
      def run; [args, opts] end
    end
  end

  let(:cl) { Cl.runner(ctx, %w(grouped b c d -a -b -c)) }

  it { expect(b.opts.map(&:first).flatten).to eq %w(-a -b -c) }
  it { expect(cl.cmd).to be_a b }
  it { expect(cl.run[0]).to eq %w(c d) }
  it { expect(cl.run[1]).to eq a: true, b: true, c: true }
end
