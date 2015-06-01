require 'rails_helper'

describe 'UnitUser' do

  it 'is valid with a user_id, and a unit_id' do
    uu = UnitUser.new( user_id: 7, unit_id: 10 );
    expect(uu).to be_valid
  end

  it 'is invalid without a user_id' do
    uu = UnitUser.new( unit_id: 10 );
    uu.valid?
    expect(uu.errors[:user_id]).to include("can't be blank")
  end

  it 'is invalid without a unit_id' do
    uu = UnitUser.new( user_id: 444 );
    uu.valid?
    expect(uu.errors[:unit_id]).to include("can't be blank")
  end

end