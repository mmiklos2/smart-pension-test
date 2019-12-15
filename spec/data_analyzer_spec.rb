# frozen_string_literal: true

require 'spec_helper'
require 'data_analyzer'
require 'active_support/hash_with_indifferent_access'

RSpec.describe DataAnalyzer do
  subject { described_class.call(pages_hash, unique: uniq) }

  describe '#call' do
    context 'with empty hash' do
      let(:pages_hash) { {} }
      let(:uniq) { false }

      it { is_expected.to be_nil }
    end

    context 'with valid input' do
      let(:uniq) { false }
      let(:pages_hash) do
        HashWithIndifferentAccess.new('/help_page/1': %w[126.318.035.038])
      end

      it { is_expected.not_to be_nil }
      it { is_expected.to be_kind_of Hash }
    end

    context 'with input to request all visits' do
      let(:pages_hash) do
        HashWithIndifferentAccess.new(
          '/help_page/1': %w[126.318.035.038 722.247.931.582 126.318.035.038],
          '/index': %w[444.701.448.104 444.701.448.104],
          '/contact': %w[184.123.665.067],
          '/home': %w[184.123.665.067],
          '/about/2': %w[444.701.448.104]
        )
      end
      let(:uniq) { false }
      let(:expected_output) do
        HashWithIndifferentAccess.new(
          '/help_page/1': 3,
          '/index': 2,
          '/contact': 1,
          '/home': 1,
          '/about/2': 1
        )
      end

      it 'is expected to return an ordered hash' do
        expect(subject.values).to eq(expected_output.values)
      end
    end

    context 'with input to request unique views' do
      let(:uniq) { true }
      let(:pages_hash) do
        HashWithIndifferentAccess.new(
          '/help_page/1': %w[126.318.035.038 722.247.931.582 126.318.035.038],
          '/index': %w[444.701.448.104 444.701.448.104],
          '/contact': %w[184.123.665.067],
          '/home': %w[184.123.665.067],
          '/about/2': %w[444.701.448.104]
        )
      end
      let(:expected_output) do
        HashWithIndifferentAccess.new(
          '/help_page/1': 2,
          '/contact': 1,
          '/home': 1,
          '/about/2': 1,
          '/index': 1
        )
      end

      it 'is expected to return an ordered hash' do
        expect(subject.values).to eq(expected_output.values)
      end
    end
  end
end
