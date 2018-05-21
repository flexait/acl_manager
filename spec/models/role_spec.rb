require 'rails_helper'

describe AclManager::Role do
  let(:acl) { spy('acl', id: 1) }

  describe '#included?' do
    context 'when given role is on current acl roles list' do
      before do
        allow(subject).to receive(:acl_ids).and_return([1, 2, 3])
      end

      it 'returns true' do
        expect(subject.included?(acl)).to be_truthy
      end
    end

    context 'when given role is not on current acl roles list' do
      before do
        allow(subject).to receive(:acl_ids).and_return([2, 3, 4])
      end

      it 'returns true' do
        expect(subject.included?(acl)).to be_falsey
      end
    end
  end

  describe '#name' do
    it 'returns default name' do
      expect(subject.name).to eq('Role')
    end
  end
end
