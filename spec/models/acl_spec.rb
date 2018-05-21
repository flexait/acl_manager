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

  describe '.root_and_descendents' do
  end
end
