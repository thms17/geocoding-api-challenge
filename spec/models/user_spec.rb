require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should save successfully' do
    user = User.new.save
    expect(user).to eq(true)
  end

  it 'should have a token' do
    user = User.create!
    expect(user.auth_token.present?).to eq(true)
  end
end
