# frozen_string_literal: true

require 'spec_helper'
require 'file_reader'
require 'active_support/hash_with_indifferent_access'

RSpec.describe FileReader do
  subject { described_class.call(file_path) }

  describe '#call' do
    context 'with invalid log file path' do
      let(:file_path) { 'some/fake/path.log' }

      it 'raises an ArgumentError' do
        expect { subject }.to raise_exception(ArgumentError)
      end
    end

    context 'with invalid file format' do
      let(:file_path) { 'spec/fixtures/file.rb' }

      it 'raises an ArgumentError' do
        expect { subject }.to raise_exception(ArgumentError)
      end
    end

    context 'with valid log file path' do
      let(:file_path) { 'spec/fixtures/simplified.log' }
      let(:expected_page_visits_output) do
        HashWithIndifferentAccess.new(
          '/help_page/1': %w[126.318.035.038 722.247.931.582 126.318.035.038],
          '/index': %w[444.701.448.104 444.701.448.104],
          '/contact': %w[184.123.665.067],
          '/home': %w[184.123.665.067],
          '/about/2': %w[444.701.448.104]
        )
      end

      it 'responds to call' do
        expect(described_class).to respond_to(:call)
      end

      it { is_expected.not_to be_nil }
      it { is_expected.to be_kind_of Hash }
      it { is_expected.to eq(expected_page_visits_output) }
    end
  end
end
