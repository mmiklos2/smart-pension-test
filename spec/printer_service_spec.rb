require 'spec_helper'
require 'printer_service'

RSpec.describe PrinterService do
  subject { described_class.call(parser_output, information) }

  describe '#call' do
    context 'with invalid log output' do
      let(:parser_output) { nil }
      let(:information) { '' }

      it 'prints out error message' do
        expect { subject }.to output('Please provide valid input.').to_stdout
      end
    end

    context 'with sample log output' do
      let(:parser_output) { HashWithIndifferentAccess.new('/help_page/1': 4) }
      let(:information) { 'visits' }

      it 'responds to call' do
        expect(described_class).to respond_to(:call)
      end

      it { is_expected.to be_nil }

      it 'prints out results' do
        expect { subject }.to output("/help_page/1 - 4 visits\n").to_stdout
      end
    end
  end
end
