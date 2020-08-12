require 'rails_helper'

describe TweetsController, type: :controller do #classを作っている

  describe 'GET #new' do
    it "new.html.erbに遷移すること" do  #テストする内容
      get :new  #リクエストを作ってる,アクションを指定するところ、
      expect(response).to render_template :new #リクエストをresponseの引数（()中身が引数）に入れる  ender_templateがビューの情報newはキーでnew.html.erbがバリューにあたる
    end

    it "@tweetに正しい値が入っていること" do
      tweet = create(:tweet)
      get :edit, params: { id: tweet } #paramsでtweetのidを引っ張ってきている.new以外の七つのアクションではidが必要なのでparamsを使ってそれぞれのidを引っ張ってくる(今回はtweetsなのでtweetsのid)
      expect(assigns(:tweet)).to eq tweet #assignsはインスタンス変数をテストするときのメソッドtweetの中にはeditのtweet.idが入っている。
    end

    it "edit.html.erbに遷移すること" do
      tweet = create(:tweet)
      get :edit, params: { id: tweet }
      expect(response).to render_template :edit
    end
  
    describe 'GET #index' do
      it "@tweetsに正しい値が入っていること" do
        tweets = create_list(:tweet, 3) #tweetの投稿したと言うデータを3つ作った
        get :index
        # expect(assigns(:tweets)).to match(tweets)#assings(:tweets)の中に上で作った３つのデータをコントローラーに渡している。to match(tweets)では上で作ったコントローラーを通していない三つのデータを作っている。
        expect(assigns(:tweets)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at } )#toの右側はコントローラーを通っって降順になっているがtestで使う方は降順になっていないためmatch(tweets.sort{ |a, b| b.created_at <=> a.created_at } )記述を行う
      end
  
      it "index.html.erbに遷移すること" do
        get :index
      expect(response).to render_template :index
      end
    end
  end
end

