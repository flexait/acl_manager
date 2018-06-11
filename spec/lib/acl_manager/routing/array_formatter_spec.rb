require 'rails_helper'

describe AclManager::Routing::ArrayFormatter do
  describe '#result' do
    it 'returns a hash with the following keys' do
      expect(subject.result.keys).to eq([:routes, :namespaces, :controllers])
    end

    context 'when instance variables are empty' do
      it 'returns a hash with empty values' do
        expect(subject.result.values).to eq([[],[],[]])
      end
    end

    context 'when instance variables are populated' do
      it 'returns a hash with instance variables values' do
        subject.instance_variable_set(:@routes, [1, 2, 3])
        subject.instance_variable_set(:@namespaces, [1, 1, 1])
        subject.instance_variable_set(:@controllers, [3, 2, 3])

        expect(subject.result.values).to eq([[1, 2, 3],[1],[3, 2]])
      end
    end
  end

  describe '#section' do
    pending
  end
end
