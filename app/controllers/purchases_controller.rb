class PurchasesController < ApplicationController

  def index
    @user = current_user
    @card = Pay.where(user_id: current_user.id).first
    @address = Address.where(user_id: current_user.id).first
    @item = Item.find(params[:item_id])
  #Payjpの秘密鍵を取得
    Payjp.api_key = 'sk_test_af3434547c7810594fce6067'
  #Payjpから顧客情報を取得し、表示
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @card_information = customer.cards.retrieve(@card.card_id)
  end
  def create
    #クレジットカードと製品の変数を設定
        @item = Item.find(params[:item_id])
        @card =Pay.where(user_id: current_user.id).first
        # @item = Item.find(params[:id])
     #Payjpの秘密鍵を取得
        Payjp.api_key= 'sk_test_af3434547c7810594fce6067'
     #payjp経由で支払いを実行
        charge = Payjp::Charge.create(
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
        )
      #製品のbuyer_idを付与
        # @product_buyer= Item.find(params[:item_id])
        # @product_buyer.update( buyer_id: current_user.id)
        # redirect_to purchased_product_path
  end

  private
 
  def item_params
    params.require(:item).permit(
      :name,
      :text,
      :price,
      #この辺の他コードは関係ない部分なので省略してます
    ).merge(user_id: current_user.id)
  end
  
end
