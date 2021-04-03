# spec/parser_spec.rb
require './lib/parser'

describe Parser do
  let(:log_file) { './spec/fixtures/webserver_sample.log' }

  describe 'initialized without logfile' do
    it 'raises an error' do
      expect { Parser.new('/invalid/path/file.log') }.to raise_error(
        RuntimeError, 'Log file not found at /invalid/path/file.log'
      )
    end
  end

  describe '#list_views' do
    before { @list_views = Parser.new(log_file).list_views }
    it 'returns list of webpages from most view to less view' do
      expected_results = [
        { '/help_page/1' => 4 },
        { '/contact' => 2 },
        { '/index' => 1 },
        { '/about/2' => 1 },
        { '/home' => 1 }
      ]

      expect(@list_views).to eq(expected_results)
    end
  end

  describe '#uniq_views' do
    before { @uniq_views = Parser.new(log_file).uniq_views }
    it 'returns list of webpages from most view to less view' do
      expected_results = [
        { '/contact' => 2 },
        { '/help_page/1' => 2 },
        { '/index' => 1 },
        { '/about/2' => 1 },
        { '/home' => 1 }
      ]

      expect(@uniq_views).to eq(expected_results)
    end
  end
end
