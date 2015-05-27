require 'rails_helper'

describe 'UnitUserController' do

    before do
      @unituser = UnitUser.create({
        user_id:27,
        unit_id:6,
        duration: 120

      })
    end

    context "create" do

      it 'should set start time correctly' do
        expect(@unituser.duration).to eq(120)
      end

    end




end