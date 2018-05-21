require 'rails_helper'

describe AclManager::Acl do
  let(:role) { spy('role', id: 1) }

  describe '.permit!' do
    let(:subject) { AclManager::Acl }

    context 'when acl is nil' do
      it 'returns true ' do
        logger = Rails.logger
        subject.permit!(nil)
        expect(logger).to receive(:warn).at_least(:once)
        expect(subject.permit!(nil)).to be_truthy
      end
    end
  end

  describe '.root' do
    it { expect(subject.class).to respond_to(:root) }
  end

  describe '#included?' do
    context 'when given role is on current acl roles list' do
      before do
        allow(subject).to receive(:role_ids).and_return([1, 2, 3])
      end

      it 'returns true' do
        expect(subject.included?(role)).to be_truthy
      end
    end

    context 'when given role is not on current acl roles list' do
      before do
        allow(subject).to receive(:role_ids).and_return([2, 3, 4])
      end

      it 'returns true' do
        expect(subject.included?(role)).to be_falsey
      end
    end
  end
end
