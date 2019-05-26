require 'rails_helper'

RSpec.describe SellersController, type: :controller do
  describe '#create' do

    let(:params) do
      {
        token: user.authentication_token,
        shop: 'Shop name',
        email: 'shop@shop.ru',
        password: 'password',
        password_confirmation: 'password'
      }
    end

    subject { post :create, params: params }

    context 'when active user is amdin' do
      let!(:user) { create :user, role: :admin }

      it 'should create new seller and shop' do
        expect { subject }.to change { User.count }.by(1)
                         .and change { Shop.count }.from(0).to(1) 
        expect(response.code).to eq '201'
      end
    end
  end

  describe '#destroy' do
    let!(:user) { create :user, role: :admin }
    let!(:shop) { create :shop }

    let(:params) do
      {
        token: user.authentication_token,
        id: seller.id
      }
    end

    subject { delete :destroy, params: params }

    context 'when shop has another sellers' do
      let!(:seller) { create :user, role: :seller, shop: shop}
      let!(:another_seller) { create :user, role: :seller, shop: shop}


      it 'should destroy only seller' do
        expect { subject }.to change { User.count }.by(-1)
        expect { subject }.not_to change { Shop.count }
        expect(response.code).to eq '200'
      end
    end

    context 'when shop has not another sellers' do
      let!(:seller) { create :user, role: :seller, shop: shop}

      it 'should destroy seller and shop' do
        expect { subject }.to change { User.count }.by(-1)
                         .and change { Shop.count }.by(-1)
        expect(response.code).to eq '200'
      end
    end
  end

  describe '#index' do
    let!(:user) { create :user, role: :admin }
    let!(:seller_1) { create :user, role: :seller }
    let!(:seller_2) { create :user, role: :seller }

    let(:params) do
      {
        token: user.authentication_token,
      }
    end

    subject { get :index, params: params }

    let(:expected_response_body) { [seller_1.as_json, seller_2.as_json].as_json }

    it 'should return all sellers' do
      subject
      expect(response.code).to eq '200'
      expect(JSON.parse response.body).to eq expected_response_body
    end
  end
end